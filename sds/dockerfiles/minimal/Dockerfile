FROM ubuntu:18.04

WORKDIR /root

# Setting required environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/root/spark-2.4.4-bin-hadoop2.7
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Installing required and useful packages from repositories
RUN apt update && apt install -y \
    gcc \
    git \
    openjdk-8-jdk \
    vim \
    wget \
    iproute2 \
    iputils-ping

# Downloading and unpacking Apache Spark
RUN wget http://apache.mirrors.spacedump.net/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz && \
    tar -xzf spark-2.4.4-bin-hadoop2.7.tgz && \
    rm spark-2.4.4-bin-hadoop2.7.tgz

# Downloading Kafka streaming jars for Spark
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-10_2.11/2.4.4/spark-streaming-kafka-0-10_2.11-2.4.4.jar && \
    wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.4.0/kafka-clients-2.4.0.jar && \
    wget https://repo1.maven.org/maven2/org/apache/kafka/kafka_2.11/2.4.0/kafka_2.11-2.4.0.jar

# Downloading delta.io jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.11/0.5.0/delta-core_2.11-0.5.0.jar

# Downloading graphframes jar
RUN cd $SPARK_HOME/jars && wget http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.7.0-spark2.4-s_2.11/graphframes-0.7.0-spark2.4-s_2.11.jar

# Downloading gson jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.6/gson-2.8.6.jar

# Downloading jopt jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar

# Downloading junit jars
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/junit/junit/4.13/junit-4.13.jar && \
    wget https://repo1.maven.org/maven2/com/novocode/junit-interface/0.11/junit-interface-0.11.jar

# Downloading scalcheck jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.11/1.14.3/scalacheck_2.11-1.14.3.jar

# Downloading scala-logging jars
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.11/3.9.2/scala-logging_2.11-3.9.2.jar && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-api_2.11/2.1.2/scala-logging-api_2.11-2.1.2.jar && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-slf4j_2.11/2.1.2/scala-logging-slf4j_2.11-2.1.2.jar

# Downloading scalatest jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalatest/scalatest_2.11/3.1.1/scalatest_2.11-3.1.1.jar

# Downloading spark-streaming-twitter jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/apache/bahir/spark-streaming-twitter_2.11/2.4.0/spark-streaming-twitter_2.11-2.4.0.jar

# Downloading twitter4j jars
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/org/twitter4j/twitter4j-async/4.0.6/twitter4j-async-4.0.6.jar && \
    wget https://repo1.maven.org/maven2/org/twitter4j/twitter4j-core/4.0.6/twitter4j-core-4.0.6.jar && \
    wget https://repo1.maven.org/maven2/org/twitter4j/twitter4j-media-support/4.0.6/twitter4j-media-support-4.0.6.jar && \
    wget https://repo1.maven.org/maven2-org/twitter4j/twitter4j-stream/4.0.6/twitter4j-stream-4.0.6.jar

# Expose Spark ports
EXPOSE 4040

# Setting up ssh
RUN apt update && \
    apt install -y openssh-server && \
    mkdir .ssh && \
    ssh-keygen -f .ssh/id_rsa -N "" && \
    cat .ssh/id_rsa.pub > .ssh/authorized_keys && \
    /etc/init.d/ssh start && \
    echo "Host *\n\tStrictHostKeyChecking no" > .ssh/config

# Installing SBT
RUN apt install -y gnupg && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update && \
    apt-get install sbt && \
    sbt about

# Cleanup
Run apt clean

ENTRYPOINT ["spark-shell"]
