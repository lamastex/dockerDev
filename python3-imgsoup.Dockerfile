FROM python

WORKDIR /root

RUN apt-get update && apt-get install -y --no-install-recommends vim 
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip3 install beautifulsoup4==4.9.3 soupsieve==2.1 tqdm==4.56.0
RUN mkdir -p /root/tilowiklund &&  cd /root/tilowiklund/ && \
    git clone https://gitlab.com/tilowiklund/imgsoup.git 
RUN ln -s /usr/bin/env /bin/env 
RUN ln -s /root/tilowiklund/imgsoup/imgsoup /bin/imgsoup 

