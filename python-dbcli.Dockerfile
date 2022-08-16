FROM python

WORKDIR /root
RUN apt-get update && apt-get install zip
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip3 install databricks-cli
