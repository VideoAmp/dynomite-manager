#!/bin/bash

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

mkdir -p /var/log/dynomite-manager/

cd ~/dynomite-manager
git config user.email "docker@videoamp.com"
git config user.name "docker"
git fetch
git checkout -f origin/feature/ecs_support

export TERM=dumb
source /etc/default/dynomite-manager
./gradlew jettyRun > /var/log/dynomite-manager/dynomite-manager.log
