FROM lamastex/base

WORKDIR /root

# Installing requirements
RUN apt update && apt install -y \
    ipython \
    jupyter \
    python-pip \
    python3-pip && \
    apt clean

# Expose Jupyter ports
EXPOSE 8888

# Install Toree
RUN pip3 install \
    toree \
    findspark && \
    jupyter toree install --spark_home=$SPARK_HOME --interpreters=Scala,SQL --python=python3

ENTRYPOINT ["jupyter-notebook", "--allow-root", "--ip", "0.0.0.0"]
