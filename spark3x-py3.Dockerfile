FROM lamastex/dockerdev:spark3x
RUN apt install -y python3-pip
RUN apt install -y python3
RUN pip3 install twarc
RUN apt clean
RUN ln -s /usr/bin/python3 /usr/bin/python



