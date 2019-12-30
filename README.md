# Apache Hadoop
[![CI status](https://github.com/nvtienanh/docker-hive/workflows/CI/badge.svg?branch=2.3.4-alpine)](https://github.com/nvtienanh/docker-hive/actions?query=branch%3A+branch%3A2.3.4-alpine++)
[![Docker Version](https://images.microbadger.com/badges/version/nvtienanh/hive:2.3.4-alpine.svg)](https://hub.docker.com/r/nvtienanh/hive/)
[![Docker Pulls](https://img.shields.io/docker/pulls/nvtienanh/hive)](https://hub.docker.com/r/nvtienanh/hive/)
[![Docker Layers](https://img.shields.io/microbadger/layers/nvtienanh/hive/2.3.4-alpine)](https://hub.docker.com/r/nvtienanh/hive/)


This is a docker container for Apache Hive 2.3.4. It is based on https://github.com/nvtienanh/docker-hadoop so check there for Hadoop configurations.
This deploys Hive and starts a hiveserver2 on port 10000.
Metastore is running with a connection to postgresql database.
The hive configuration is performed with HIVE_SITE_CONF_ variables (see hadoop-hive.env for an example).

To run Hive with postgresql metastore:
```
    docker-compose up -d
```

To deploy in Docker Swarm:
```
    docker stack deploy -c docker-compose.yml hive
```

To run a PrestoDB 0.181 with Hive connector:

```
  docker-compose up -d presto-coordinator
```

This deploys a Presto server listens on port `8080`

## Testing
Load data into Hive:
```
  $ docker-compose exec hive-server bash
  # /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
  > CREATE TABLE pokes (foo INT, bar STRING);
  > LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;
```

Then query it from PrestoDB. You can get [presto.jar](https://prestosql.io/docs/current/installation/cli.html) from PrestoDB website:
```
  $ wget https://repo1.maven.org/maven2/io/prestosql/presto-cli/308/presto-cli-308-executable.jar
  $ mv presto-cli-308-executable.jar presto.jar
  $ chmod +x presto.jar
  $ ./presto.jar --server localhost:8080 --catalog hive --schema default
  presto> select * from pokes;
```

## Liên hệ
* Anh Nguyen [@nvtienanh](https://github.com/nvtienanh) 

## Tham khảo
* [Big Data Europe](https://github.com/big-data-europe/)