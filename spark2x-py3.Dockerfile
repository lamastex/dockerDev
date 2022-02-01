FROM lamastex/dockerdev:spark2x
RUN apt install -y python3-pip
RUN apt install -y python3
RUN apt clean
RUN ln -s /usr/bin/python3 /usr/bin/python



