FROM python

WORKDIR /root

RUN pip3 install yfinance
RUN pip3 install lxml
RUN pip3 install histdata



