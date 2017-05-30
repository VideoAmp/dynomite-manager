#!/bin/bash

set -x
set -e
# service redis-server start

# service dynomite start
mkdir -p /var/log/redis/
chown -R redis:redis /var/lib/redis
chown -R redis:redis /var/log/redis
echo "export REDIS_MAXMEMORY=$REDIS_MAXMEMORY" >> /etc/default/redis-server-env
echo "export REDIS_MAXMEMORY_PERCENT=$REDIS_MAXMEMORY_PERCENT" >> /etc/default/redis-server-env
echo "export REDIS_MAXMEMORY_POLICY=$REDIS_MAXMEMORY_POLICY" >> /etc/default/redis-server-env
echo "export REDIS_MAXMEMORY_SAMPLES=$REDIS_MAXMEMORY_SAMPLES" >> /etc/default/redis-server-env

mkdir -p /var/log/dynomite/
chown dynomite:dynomite /var/log/dynomite

service redis-server start
service dynomite start


tail -F /var/log/dynomite/dynomite.log