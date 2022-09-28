#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

mkdir -p ~/.ssh
chown -R root:root ~/.ssh
chmod -R 0700 ~/.ssh
cp -ip /run/secrets/host_ssh_key ~/.ssh/main-windows.pem
chmod -R 0600 ~/.ssh

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"