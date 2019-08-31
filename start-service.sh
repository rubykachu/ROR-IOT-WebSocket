#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Install dependencies
bundle check || bundle install --binstubs="$BUNDLE_BIN"
yarn install --check-files

# Create database and migrate
rails db:create db:migrate

# Start Rails with port default 3000
foreman start -f Procfile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
