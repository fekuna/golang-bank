#!/bin/sh

set -e

echo "run db migration"
/app/migrate -path /app/migrations -database "$DB_SOURCE" -verbose up

# exec the parameter or CMD
echo "start the app"
exec "$@"