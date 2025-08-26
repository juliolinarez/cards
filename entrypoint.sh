#!/bin/bash
set -e

# Change to the Rails directory
cd /rails || cd /app

# Remove any existing server pid file
rm -f tmp/pids/server.pid

# In production (Fly.io), dependencies are already installed during build
# Only install dependencies in development
if [ "$RAILS_ENV" != "production" ]; then
  # Install Ruby dependencies
  bundle install --jobs $(nproc) --retry 3

  # Install Node.js dependencies if package.json exists
  if [ -f "package.json" ]; then
    npm install
  fi

  # Build CSS with Tailwind if needed
  if [ -f "package.json" ] && [ -f "tailwind.config.js" ]; then
    npm run build:css || echo "CSS build failed, continuing..."
  fi
fi

exec "$@"
