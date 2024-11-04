# codespaces make the ports public
gh codespace ports visibility 3000:public -c $CODESPACE_NAME


# Kill any existing overmind processes
overmind kill

# Ensure .overmind.sock and server.pid is removed
rm -f .overmind.sock tmp/pids/server.pid

# Install dependencies
bundle install
yarn install

# Start overmind
overmind start -f Procfile.dev
