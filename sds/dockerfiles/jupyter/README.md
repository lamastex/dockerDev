# hsJupyter

Docker image containing Apache Hadoop, Apache Spark, SBT and Jupyter with Toree
kernels for Spark support in Jupyter notebooks.

## Build

To build the image run the command `docker build -t <tag> .` in the `jupyter`
folder of the project. Replace `<tag>` with a tag of your choosing to easily
reference the image later for builds. The suggested tag is `lamastex/jupyter`,
which will be used for the remainder of this document.

## Usage

To start Jupyter notebook simply use the command `docker run -it -p 8888:8888
lamastex/jupyter` and use the token printed to stdout to enter the webui at
`localhost:8888`. If you want to run a different command use `docker run -it
--entrypoint <command> lamastex/jupyter` where `<command>` is the command you
wish to run instead of starting Jupyter, e.g. `bash`.

The Toree Scala and SQL interpreters are preinstalled for using Spark with Scala
and SQL. For using PySpark the package `findspark` is also installed. To use
PySpark and have a Spark context available as `sc`, start a Python3 notebook and
run

```python
import findspark
findspark.init()
import pyspark
sc = pyspark.SparkContext()
```

## Ports

The following ports are exposed by the dockerfile:

- Jupyter webUI: 8888
- hdfs webUI: 9870
- Yarn webUI: 8088
- Spark driver webUI: 4040
