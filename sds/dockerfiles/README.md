# lamastex/sds Dockerfiles 

A set of dockerfiles for using Apache Hadoop and Apache Spark either alone or
together with Zeppelin or Jupyter notebooks. See individual folders for more
information.

## Build 

The images can be built using the included `build.sh` script which will build
the contained images with tags `lamastex/minimal`, `lamastex/base`,
`lamastex/zeppelin`, `lamastex/jupyter` and `lamastex/kafka`. Running
`build.sh --tag <tag>` will build the images with the tag specified by `<tag>`
instead of the default which is `latest`. Alternatively you can find build
instructions for each separate docker image in their respective folders.

## Docker hub 

The images are also available at Docker hub.
