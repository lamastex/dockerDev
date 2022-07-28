# Minimal #

A docker image containing Apache Spark and SBT.

## Build ##

To build the image run the command `docker build -t <tag> .` in the `minimal`
folder of the project. Replace `<tag>` with a tag of your choosing to easily
reference the image later for builds. The suggested tag is `lamastex/minimal`,
which will be used for the remainder of this document.

## Usage ##

To start a container use the command `docker run -it lamastex/minimal`. By
default it will start the Spark shell. All of Spark's binaries are in the `PATH`
variable and so can be readily run directly from this shell. The default
behaviour can be changed by specifying the `--entrypoint` option in the `docker
run` command. For example `docker run -it --entrypoint="bash" lamastex/minimal`
will start bash instead of the Spark shell.

## Ports ##

The following ports are exposed by the dockerfile:

- Spark driver webUI: 4040
