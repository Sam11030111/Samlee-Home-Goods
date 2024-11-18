#!/bin/bash
set -e

rm -f /rails/tmp/pids/server.pid
# Run database migrations
bin/rails db:migrate

# Start the Rails server
bin/rails server -b '0.0.0.0'
