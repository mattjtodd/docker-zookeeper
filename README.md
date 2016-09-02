# docker-zookeeper
A base dynamically configurable Zookeeper image

## Overview

"ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services."

For more information about this see the [https://zookeeper.apache.org].

## Single Node

```
docker run -p 2181:2181 utuba/zookeeper
```

## Clustered (Multi-Server) Setup

[Ensemble mode] (https://zookeeper.apache.org/doc/r3.3.3/zookeeperAdmin.html#sc_zkMulitServerSetup) can be configured by defining:

* `-id` to define the node id written to the data/myid an integer 1-255.
* `-s` or `--server` to define each member of the ensemble.
 
So:

```
-id <myid> -s <member-myid>=<server-name>:<port>:<port>
```

For example:

```
docker run -p 2181:2181 utuba/zookeeper -id 1 -s 1=zookeeper1:2888:3888 -s 2=zookeeper2:2888:3888 -s 3=zookeeper3:2888:3888
```

The compose file illustrates this setup and can be stood up using

```
docker-compose up
```

