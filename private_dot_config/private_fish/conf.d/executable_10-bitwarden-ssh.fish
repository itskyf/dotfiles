set --global --export SSH_AUTH_SOCK "$HOME/.ssh/bitwarden.sock"

# Capture output to catch partial failures
set --local ssh_output (ssh-add -l 2>&1)
set --local ssh_status $status
set --local needs_restart false

# Status 2: socket unreachable
if test $ssh_status -eq 2
    set needs_restart true
    # Status 1 + error: socket alive, Windows pipe broken
else if string match --quiet -- "*communication with agent failed*" "$ssh_output"
    set needs_restart true
end

if test "$needs_restart" = true
    # Clean stale state
    pkill --full "socat.*$SSH_AUTH_SOCK" &>/dev/null
    rm --force "$SSH_AUTH_SOCK"

    set --local npipe_bin (command --search npiperelay.exe)

    if test -n "$npipe_bin"
        # Bridge Unix socket to Windows named pipe in background
        setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$npipe_bin -ei -s //./pipe/openssh-ssh-agent",nofork &>/dev/null &
        disown
    else
        echo "npiperelay.exe missing from PATH" >&2
    end
end
