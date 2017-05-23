#
# how i install bigtop 1.1.0 on ubuntu 16.04
# https://gist.github.com/tonycox/322e8ffa584123f1b498c705cf5d972f
#
FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y upgrade

# install java (homedir - /usr/lib/jvm/java-8-oracle/)
RUN apt-get install -y apt-file
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN apt-get -y install oracle-java8-installer

# or use this to set as default -> sudo apt install oracle-java8-set-default

# install maven (homedir - /usr/share/maven)
RUN apt-get -y install maven

# set env
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> /etc/bash.bashrc
RUN echo "export M2_HOME=/usr/share/maven" >> /etc/bash.bashrc
RUN echo "export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH" >> /etc/bash.bashrc
RUN source /etc/bash.bashrc
RUN mvn -v

# Install the Apache Bigtop GPG key
RUN wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.2.0/repos/GPG-KEY-bigtop | sudo apt-key add -

# Make sure to grab the repo file:
RUN wget -O /etc/apt/sources.list.d/bigtop-1.2.0.list http://archive.apache.org/dist/bigtop/bigtop-1.2.0/repos/trusty/bigtop.list

# Update the apt cache
RUN apt-get -y update

# Install bigtop-utils
RUN apt-get -y install bigtop-utils

# Install the full Hadoop stack (or parts of it)
RUN apt-get -y install hadoop\* flume-* oozie\* hive\*

## Running

# Format the namenode
RUN /etc/init.d/hadoop-hdfs-namenode init

# Start the necessary Hadoop services
RUN for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do sudo service $i start ; done
RUN service hadoop-yarn-resourcemanager start
RUN service hadoop-yarn-nodemanager start

# Check hadoop fs
RUN sudo hdfs dfs -ls /

# Run hive
RUN hadoop fs -mkdir /tmp
RUN hadoop fs -mkdir /user/hive/warehouse
RUN hadoop -chmod g+x /tmp
RUN hadoop -chmod g+x /user/hive/warehouse

# if dirs have not been created on local fs
RUN mkdir /var/run/hive
RUN mkdir /var/lock/subsys

RUN /etc/init.d/hive-server start