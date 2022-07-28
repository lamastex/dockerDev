# Base #

A docker image containing Apache Hadoop, Apache Spark and SBT.

## Build ##

To build the image run the command `docker build -t <tag> .` in the `base`
folder of the project. Replace `<tag>` with a tag of your choosing to easily
reference the image later for builds. The suggested tag is `lamastex/base`,
which will be used for the remainder of this document.

## Usage ##

To start a container use the command `docker run -it lamastex/base`. By default
it will start a `bash` shell. All of Hadoop's and Spark's binaries are in the
`PATH` variable and so can be readily run directly from this shell. For example,
to start the spark shell run the command `spark-shell`. The default behaviour
can be changed by specifying the `--entrypoint` option in the `docker run`
command. For example `docker run -it --entrypoint="spark-shell" lamastex/base`
will start the Spark shell instead of bash.

## Ports ##

The following ports are exposed by the dockerfile:

- hdfs webUI: 9870
- Yarn webUI: 8088
- Spark driver webUI: 4040
