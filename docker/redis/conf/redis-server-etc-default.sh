# redis-server configure options

# ULIMIT: Call ulimit -n with this argument prior to invoking Redis itself.
# This may be required for high-concurrency environments. Redis itself cannot
# alter its limits as it is not being run as root. (default: do not call
# ulimit)
#
# ULIMIT=65536
DAEMON_ARGS="/etc/redis/redis.conf"

if [ -r /etc/default/redis-server ]
then
	. /etc/default/redis-server-env
fi

if [ ! -z "${REDIS_MAXMEMORY_PERCENT}" ]; then
  REDIS_MAXMEMORY=$(grep MemTotal /proc/meminfo | awk -v factor=${REDIS_MAXMEMORY_PERCENT:-0.95} '{maxmemory=int($2/1024*factor); print maxmemory"mb"}')
  DAEMON_ARGS="$DAEMON_ARGS --maxmemory $REDIS_MAXMEMORY"
fi

if [ ! -z "${REDIS_MAXMEMORY_POLICY}" ]; then
  DAEMON_ARGS="$DAEMON_ARGS --maxmemory-policy $REDIS_MAXMEMORY_POLICY"
fi

if [ ! -z "${REDIS_MAXMEMORY_SAMPLES}" ]; then
  DAEMON_ARGS="$DAEMON_ARGS --maxmemory-samples $REDIS_MAXMEMORY_SAMPLES"
fi
