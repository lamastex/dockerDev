FROM lamastex/base

WORKDIR /root

# Setting required environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV KAFKA_HOME=/root/kafka_2.11-2.2.1
ENV PATH=$KAFKA_HOME/bin:$PATH

# Downloading and installing Kafka
RUN curl -O http://apache.mirrors.spacedump.net/kafka/2.2.1/kafka_2.11-2.2.1.tgz && \
    tar -xzf kafka_2.11-2.2.1.tgz && \
    rm kafka_2.11-2.2.1.tgz

# Cleanup
Run apt clean

# Expose Zookeeper port
EXPOSE 2181

# Expose default Kafka port
EXPOSE 9092

ENTRYPOINT ["/bin/bash"]
