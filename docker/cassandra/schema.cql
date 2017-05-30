CREATE KEYSPACE dyno_bootstrap WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true;

CREATE TABLE dyno_bootstrap.tokens (
    key text PRIMARY KEY,
    "Id" text,
    "appId" text,
    "availabilityZone" text,
    datacenter text,
    "elasticIP" text,
    hostname text,
    "instanceId" text,
    location text,
    "token" text,
    updatetime timeuuid
) WITH COMPACT STORAGE
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.SnappyCompressor'}
    AND dclocal_read_repair_chance = 0.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 256
    AND read_repair_chance = 1.0
    AND speculative_retry = 'NONE';
CREATE INDEX tokens_appid_idx ON dyno_bootstrap.tokens ("appId");

CREATE TABLE dyno_bootstrap.locks (
    key blob,
    column1 text,
    value blob,
    PRIMARY KEY (key, column1)
) WITH COMPACT STORAGE
    AND CLUSTERING ORDER BY (column1 ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.SnappyCompressor'}
    AND dclocal_read_repair_chance = 0.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 256
    AND read_repair_chance = 1.0
    AND speculative_retry = 'NONE';
