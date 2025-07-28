#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

# Install Ruby dependencies
bundle install --jobs $(nproc) --retry 3

# Install Node.js dependencies if package.json exists
if [ -f "package.json" ]; then
  npm install
fi

# Build CSS with DaisyUI if needed
if [ -f "package.json" ] && [ -f "tailwind.config.js" ]; then
  npm run build:css || echo "CSS build failed, continuing..."
fi

exec "$@"
