# Zeppelin

Docker image containing Apache Hadoop, Apache Spark, Apache Zeppelin and SBT.

## Build

To build the image run the command `docker build -t <tag> .` in the `zeppelin`
folder of the project. Replace `<tag>` with a tag of your choosing to easily
reference the image later for builds. The suggested tag is `lamastex/zeppelin`,
which will be used for the remainder of this document.

## Usage

To start Zeppelin notebook simply use the command `docker run -it -p 8080:8080
lamastex/zeppelin` and enter the webui at `localhost:8080`. If you want to run
a different command use `docker run -it --entrypoint <command>
lamastex/zeppelin` where `<command>` is the command you wish to run instead of
starting Zeppelin, e.g. `bash`.

## Ports

The following ports are exposed by the dockerfile:

- Zeppelin webUI: 8080
- hdfs webUI: 9870
- Yarn webUI: 8088
- Spark driver webUI: 4040
