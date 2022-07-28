# hsKafka

Docker image containing Apache Hadoop, Apache Spark, Apache Kafka and SBT.

## Build

To build the image run the command `docker build -t <tag> .` in the `kafka`
folder of the project. Replace `<tag>` with a tag of your choosing to easily
reference the image later for builds. The suggested tag is `lamastex/kafka`,
which will be used for the remainder of this document.

## Usage

To start Kafka in standalone mode simply use the command `docker run -it -p
9092:9092 lamastex/kafka`. If you want to run a different command use `docker
run -it --entrypoint <command> lamastex/kafka` where `<command>` is the command
you wish to run instead of starting Kafka, e.g. `bash`.

## Ports

The following ports are exposed by the dockerfile:

- Kafka : 9092
- Zookeeper client connections: 2181
- hdfs webUI: 9870
- Yarn webUI: 8088
- Spark driver webUI: 4040
