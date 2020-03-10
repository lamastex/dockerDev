# dockerDev
Dockerized Development Environment for Raaz's

This is currently being developed for:
 
 - https://github.com/aamend/spark-gdelt 

## Build

```
docker build -t lamastex/dockerdev:latest .
```
## Run

Run a docker container for the project as daemon and execute into it with bash.

```
$ pwd
~/all/git/aamend/spark-gdelt

$ docker run --rm -d -it --name=spark-gdelt --mount type=bind,source=${PWD},destination=/root/spark-gdelt lamastex/dockerdev:latest 

$ docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS               NAMES
c6a23f3d17cb        lamastex/dockerdev:latest   "/bin/bash"         3 seconds ago       Up 3 seconds        4040/tcp            spark-gdelt

$ docker exec -it spark-gdelt /bin/bash
```
