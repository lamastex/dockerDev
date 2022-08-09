FROM apache/zeppelin:0.10.1

LABEL maintainer="lamastex"

ENV SPARK_HOME="/opt/zeppelin/spark" 

RUN echo "Download Spark binary" && \
    mkdir -p ${SPARK_HOME} && \
    wget -nv -O /tmp/spark-3.2.2-bin-hadoop3.2.tgz https://archive.apache.org/dist/spark/spark-3.2.2/spark-3.2.2-bin-hadoop3.2.tgz && \
    tar --strip-components=1 -zxvf  /tmp/spark-3.2.2-bin-hadoop3.2.tgz -C ${SPARK_HOME} && \
    rm -f /tmp/spark-3.2.2-bin-hadoop3.2.tgz 

# Downloading graphframes jar
RUN cd $SPARK_HOME/jars && wget https://repos.spark-packages.org/graphframes/graphframes/0.8.2-spark3.2-s_2.12/graphframes-0.8.2-spark3.2-s_2.12.jar 

# Downloading delta-core jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.0/delta-core_2.12-2.0.0.jar

# spark UI port 
EXPOSE 4040

# usage
# docker run -d -it -u $(id -u) -p 8080:8080 -p 4040:4040 --rm -v $PWD/logs:/logs -v $PWD/notebook:/notebook  -e ZEPPELIN_LOG_DIR='/logs' -e ZEPPELIN_NOTEBOOK_DIR='/notebook' --name zeppelin lamastex/zeppelin-spark
