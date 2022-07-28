FROM lamastex/minimal

WORKDIR /root

# Setting required environment variables
ENV HADOOP_HOME=/root/hadoop-3.2.1
ENV HADOOP_CONF_DIR=/root/hadoop-3.2.1/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Downloading and unpacking Hadoop
RUN curl -O http://apache.mirrors.spacedump.net/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz && \
    tar -xzf hadoop-3.2.1.tar.gz && \
    rm hadoop-3.2.1.tar.gz

# Expose Hadoop hdfs webUI port
EXPOSE 9870

# Expose Hadoop Yarn webUI port
EXPOSE 8088

# Cleanup
Run apt clean

ENTRYPOINT ["/bin/bash"]
