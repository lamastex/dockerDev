FROM lamastex/base

WORKDIR /root

# Setting required environment variables
ENV ZEPPELIN_HOME=/root/zeppelin-0.8.2-bin-all
ENV PATH=$ZEPPELIN_HOME/bin:$PATH

# Installing utilities
RUN apt update && apt install -y \
    python-pip \
    python3-pip && \
    apt clean

# Downloading and unpacking Apache Zeppelin
RUN curl -O http://apache.mirrors.spacedump.net/zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz && \
    tar -xzf zeppelin-0.8.2-bin-all.tgz && \
    rm zeppelin-0.8.2-bin-all.tgz

# Expose zeppelin ports
EXPOSE 8080

ENTRYPOINT ["zeppelin"]
