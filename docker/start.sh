#!/bin/bash

# Start the necessary Hadoop services
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do service $i start ; done
service hadoop-yarn-resourcemanager start
service hadoop-yarn-nodemanager start

# Check hadoop fs
hdfs dfs -ls /

# Run hive
hadoop fs -mkdir /tmp
hadoop fs -mkdir /user/hive/warehouse
hadoop -chmod g+x /tmp
hadoop -chmod g+x /user/hive/warehouse

/etc/init.d/hive-server start
