#!/bin/bash
# wait-for-postgres.sh

set -e

host="$1"
shift
port="$2"
shift
cmd="$@"

until telnet  $host  $port; do
  >&2 echo "Mongodb is unavailable - sleeping"
  sleep 1
done

>&2 echo "Mongodb is up - executing command"
exec $cmd