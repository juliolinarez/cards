#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

bundle install --jobs $(nproc) --retry 3

exec "$@"