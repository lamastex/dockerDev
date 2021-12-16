FROM python

WORKDIR /root

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip3 install databricks-cli
