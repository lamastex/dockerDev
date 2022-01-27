FROM ubuntu:18.04

WORKDIR /root

# Setting required environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/root/spark-3.1.2-bin-hadoop3.2
ENV MAVEN_HOME=/root/apache-maven-3.8.4
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$MAVEN_HOME/bin

# Installing required and useful packages from repositories
RUN apt update && apt install -y \
    gcc \
    git \
    openjdk-8-jdk \
    vim \
    curl \
    wget \
    iproute2 \
    iputils-ping \
    unzip

# Downloading and unpacking Apache Spark
RUN wget https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz && \
    tar -xzf spark-3.1.2-bin-hadoop3.2.tgz && \
    rm spark-3.1.2-bin-hadoop3.2.tgz

# Downloading graphframes jar
RUN cd $SPARK_HOME/jars && wget https://repos.spark-packages.org/graphframes/graphframes/0.8.1-spark3.0-s_2.12/graphframes-0.8.1-spark3.0-s_2.12.jar 

# Downloading delta-core jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.1.0/delta-core_2.12-0.1.0.jar 

# Downloading scalacheck jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.15.4/scalacheck_2.12-1.15.4.jar

# Downloading scala-logging jars
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.9.4/scala-logging_2.12-3.9.4.jar 
# The following two are not available for 2.12 - perhaps wrapped-up now?
#    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-api_2.11/2.1.2/scala-logging-api_2.11-2.1.2.jar && \
#    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-slf4j_2.11/2.1.2/scala-logging-slf4j_2.11-2.1.2.jar

# Downloading scalatest jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalatest/scalatest_2.12/3.2.9/scalatest_2.12-3.2.9.jar

# Downloading Maven

RUN wget https://downloads.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz && \
    tar -xzf apache-maven-3.8.4-bin.tar.gz && \
    rm apache-maven-3.8.4-bin.tar.gz

# Installing ImageMagick

RUN apt install -y imagemagick

# Make necessary symlinks
RUN ln -s /usr/bin/convert /usr/local/bin/convert
RUN ln -s /usr/bin/identify /usr/local/bin/identify

# Expose Spark ports
EXPOSE 4040

# Installing SBT
RUN apt-get update && apt-get install apt-transport-https curl gnupg -yqq && \ 
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" |  gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && apt-get update && apt-get install sbt && sbt about

# Generating gpg keys
RUN echo "Key-Type: default\nSubkey-Type: default\nName-Real: testing\nName-Comment: This key is for testing\nName-Email: testing@testing.test\nExpire-Date: 0\n%no-protection\n%commit" > gpgBatch.txt
RUN gpg --batch --generate-key < gpgBatch.txt

# Cleanup
Run apt clean

ENTRYPOINT ["/bin/bash"]
