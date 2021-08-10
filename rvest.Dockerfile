FROM r-base
WORKDIR /root
RUN apt-get update
RUN apt-get install libcurl4-openssl-dev
RUN apt-get -y install libxml2-dev
RUN apt-get -y install libssl-dev
RUN Rscript -e 'install.packages(c("magrittr", "tibble","dplyr", "rvest","rjson","stringr"))'