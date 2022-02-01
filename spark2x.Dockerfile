FROM ubuntu:18.04

WORKDIR /root

# Setting required environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/root/spark-2.4.5-bin-hadoop2.7
ENV MAVEN_HOME=/root/apache-maven-3.6.3
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
RUN wget https://archive.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz && \
    tar -xzf spark-2.4.5-bin-hadoop2.7.tgz && \
    rm spark-2.4.5-bin-hadoop2.7.tgz

# Downloading graphframes jar
RUN cd $SPARK_HOME/jars && wget https://repos.spark-packages.org/graphframes/graphframes/0.7.0-spark2.4-s_2.11/graphframes-0.7.0-spark2.4-s_2.11.jar
# Downloading delta-core jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.11/0.5.0/delta-core_2.11-0.5.0.jar

# Downloading scalacheck jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.11/1.13.5/scalacheck_2.11-1.13.5.jar

# Downloading scala-logging jars
RUN cd $SPARK_HOME/jars && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.11/3.9.2/scala-logging_2.11-3.9.2.jar && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-api_2.11/2.1.2/scala-logging-api_2.11-2.1.2.jar && \
    wget https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging-slf4j_2.11/2.1.2/scala-logging-slf4j_2.11-2.1.2.jar

# Downloading scalatest jar
RUN cd $SPARK_HOME/jars && wget https://repo1.maven.org/maven2/org/scalatest/scalatest_2.11/3.0.3/scalatest_2.11-3.0.3.jar

# Downloading Maven

RUN wget http://apache.mirrors.spacedump.net/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
    tar -xzf apache-maven-3.6.3-bin.tar.gz && \
    rm apache-maven-3.6.3-bin.tar.gz

# Installing ImageMagick

RUN apt install -y imagemagick

# Make necessary symlinks
RUN ln -s /usr/bin/convert /usr/local/bin/convert
RUN ln -s /usr/bin/identify /usr/local/bin/identify

# Expose Spark ports
EXPOSE 4040

# Installing SBT
RUN apt-get update 
RUN apt-get install apt-transport-https curl gnupg -yqq 
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list 
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list 
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" |  gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import 
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && apt-get update && apt-get install sbt 


# Generating gpg keys
RUN echo "Key-Type: default\nSubkey-Type: default\nName-Real: testing\nName-Comment: This key is for testing\nName-Email: testing@testing.test\nExpire-Date: 0\n%no-protection\n%commit" > gpgBatch.txt
RUN gpg --batch --generate-key < gpgBatch.txt

# Cleanup
Run apt clean

ENTRYPOINT ["/bin/bash"]
