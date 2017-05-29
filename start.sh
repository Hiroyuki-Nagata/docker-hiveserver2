#!/bin/bash

# Start the necessary Hadoop services
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do service $i restart ; done
service hadoop-yarn-resourcemanager restart
service hadoop-yarn-nodemanager restart

# Check hadoop fs
hdfs dfs -ls /
