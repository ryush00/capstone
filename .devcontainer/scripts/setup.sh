# codespaces make the ports public
gh codespace ports visibility 3000:public -c $CODESPACE_NAME


# Ensure .overmind.sock and server.pid is removed
rm -f tmp/pids/server.pid

# Start overmind
bin/rails server -b 0.0.0.0