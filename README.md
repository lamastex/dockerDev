# dockerDev
Dockerized Development Environment for Spark+Scala+mvn/sbt+..., python, and R for specific open-source projects.

This is currently being developed for various projects involving Spark, Scala, R, Python, etc.

Some concrete open-source projects using these docker containers that are avialable directly dockerhub at:

- https://hub.docker.com/u/lamastex

include:

- Spark/Scala: with `docker pull lamastex/dockerdev`

  - https://github.com/aamend/spark-gdelt 
  - https://github.com/lamastex/spark-gdelt 
  - https://github.com/lamastex/spark-trend-calculus

- Python: 

  - with `docker pull lamastex/python-findata`

    - https://github.com/lamastex/FX-1-Minute-Data
    - https://github.com/lamastex/yfinance
    - etc.
  
  - with `docker pull lamastex/python-twarc`

    - [twarc](https://github.com/DocNow/twarc)
    - [mep/py/](https://github.com/lamastex/mep/)

- R: with `docker pull lamastex/r-base-rvest`

  - https://github.com/lamastex/emm-newsbrief-rvest

## Build

```
docker build -t lamastex/dockerdev:latest .
```
## Run

Run a docker container for the project as daemon and execute into it with bash.

```
$ pwd
~/all/git/

$ docker run --rm -d -it --name=spark-gdelt --mount type=bind,source=${PWD},destination=/root/GIT -p 4040:4040 lamastex/dockerdev:latest

$ docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS               NAMES
d838fdc21f5a	lamastex/dockerdev:latest   "/bin/bash"         3 seconds ago       Up 3 seconds        4040/tcp            spark-gdelt

$ docker exec -it spark-gdelt /bin/bash
```

## Code in `spark-shell`

For example, if the spark project is `aamend/spark-gdelt`:

```
root@d838fdc21f5a:~/GIT/aamend/spark-gdelt# pwd       
/root/GIT/aamend/spark-gdelt

root@d838fdc21f5a:~/GIT/aamend/spark-gdelt# mvn verify

...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:28 min
[INFO] Finished at: 2020-03-12T08:58:23Z
[INFO] ------------------------------------------------------------------------

root@d838fdc21f5a:~/GIT/aamend/spark-gdelt# cp target/spark-gdelt-2.2-SNAPSHOT.jar ../../../spark-2.4.4-bin-hadoop2.7/jars/
```

After packaging needed jar and adding it to the `jars` folder, one can start coding in spark across all relevant git repos, as follows:

```
root@d838fdc21f5a:~/GIT/aamend/spark-gdelt# cd ../../

root@d838fdc21f5a:~/GIT/aamend# pwd
/root/GIT

root@d838fdc21f5a:~/GIT/aamend# spark-shell
09:07:36,398  WARN  org.apache.hadoop.util.NativeCodeLoader:  62 - Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://d838fdc21f5a:4040
Spark context available as 'sc' (master = local[*], app id = local-1584004065812).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.4.4
      /_/
         
Using Scala version 2.11.12 (OpenJDK 64-Bit Server VM, Java 1.8.0_242)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```

You can pass extra arguments to spark-shell. For example, to set file-encoding to utf-8, do:

```
spark-shell --conf "spark.driver.extraJavaOptions=-Dfile.encoding=utf-8"
```

# Stopping or starting the container

When you want to stop or start the container just do `docker stop spark-gdelt` or `docker start spark-gdelt` and then `docker exec -it spark-gdelt /bin/bash` to get inside the running container.

Note that `docker kill` will stop and remove the container. See `docker help` for more details.

# Commiting mvn downloads to a container

This is useful if you don't want to keep downloading from mvn when pom/xml is fixed for dev cycle.

```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:45 min
[INFO] Finished at: 2020-07-04T14:11:03Z
[INFO] ------------------------------------------------------------------------
root@bb0d1714cde9:~/GIT/spark-gdelt# exit
$ ls
aamend                                 dockerDev            mob-spark              spark-gdelt
apache                                 emm-newsbrief-rvest  mrs2                   tilowiklund
computational-statistical-experiments  lamastex.github.io   private
distributed-histogram-trees            magellan             scalable-data-science

$ docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS                    NAMES
bb0d1714cde9        lamastex/dockerdev:latest   "/bin/bash"         23 minutes ago      Up 23 minutes       0.0.0.0:4040->4040/tcp   spark-gdelt
raaz@raaz-ThinkPad-T480:~/all/git$ docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS                    NAMES
bb0d1714cde9        lamastex/dockerdev:latest   "/bin/bash"         27 minutes ago      Up 27 minutes       0.0.0.0:4040->4040/tcp   spark-gdelt

$ docker commit spark-gdelt lamastex/dockerdev:20200407-spark-gdelt
sha256:3132086a46e04316fb280df9f31d6f975d53ebd637edeaa5ad6a686dfd058c29

$ docker images
REPOSITORY           TAG                    IMAGE ID            CREATED             SIZE
lamastex/dockerdev   20200407-spark-gdelt   3132086a46e0        12 seconds ago      1.54GB
lamastex/dockerdev   latest                 9dd569021915        35 minutes ago      1.27GB
ubuntu               18.04                  8e4ce0a6ce69        2 weeks ago         64.2MB
hello-world          latest                 bf756fb1ae65        6 months ago        13.3kB

$ docker kill spark-gdelt
spark-gdelt

$ docker run --rm -it --mount type=bind,source=${PWD},destination=/root/GIT -p 4040:4040 lamastex/dockerdev:20200407-spark-gdelt

root@9f2b5d6cb084:~# cd GIT/spark-gdelt/

root@9f2b5d6cb084:~/GIT/spark-gdelt# mvn verify # should proceed from the cached jars
```

Note that if you run the container as above then you have to change the port on the host-side to have multiple running containers. 
This is useful sometimes. Alternatively, you can run the container in daemon mode as follows.

If you want to launch in deamon mode with a name and execute into the same running container with  a name then do:

```
docker run --rm -it -d --name=20200407-spark-gdelt --mount type=bind,source=${PWD},destination=/root/GIT -p 4040:4040 lamastex/dockerdev:20200407-spark-gdelt
```

Note that if you do not use `--rm` flag then the docker container will not be removed when you exit the container.

# Python docker dev environment

This `python-findata.Dockerfile` is for python dev environemnt for the following packages:

- yfinance
- histdata

To Use:

```
docker pull lamastex/python-findata
docker run --rm  -it --mount type=bind,source=${PWD},destination=/root/GIT lamastex/python-findata /bin/bash
```

This `python-twarc.Dockerfile` is for python dev environemnt for the following packages:

- [twarc](https://github.com/DocNow/twarc)
- [mep/py/](https://github.com/lamastex/mep/)

To Use:

In interactive mode after starting in daemon mode: 

```
docker pull lamastex/python-twarc:latest
docker run --rm -d -it --name=mep-pytwarc --mount type=bind,source=${PWD},destination=/root/GIT lamastex/python-twarc:latest
$ docker exec -it mep-pytwarc /bin/bash
```

To Build such docker containers:

```
docker build -t lamastex/python-findata -f python-findata.Dockerfile .
docker build -t lamastex/python-twarc -f python-twarc.Dockerfile .
```

To push them to docker Hub so they cna be pulled:

```
docker push lamastex/python-twarc:latest
```


# Using tmux is recommended

When connecting via ssh and working in a running ec2 instance or in a local Linux/Mac machine, it is best to use tmux.

```
man tmux
```

For example, you can ssh into a ec2 instance or even to any local Linux/Mac machine, using tmux.

Here are some of the most basic commands you will need:

```
# list all tmux sessions in a machine:

ubuntu@ip-xxx-xx-xx-xxx:~$ tmux list-sessions
0: 4 windows (created Mon Jul 13 20:35:07 2020) [255x66]

# to create anew session named emm-scraper with some nice settings do
$ tmux -2 -u new-session -A -s emm-scraper

$ tmux list-session
emm-scraper: 1 windows (created Wed Jul 15 13:16:50 2020) [204x52]

# attach to a session it is session numbered 0 here

ubuntu@ip-xxx-xx-xx-xxx:~$ tmux attach -t 0

# attach to a session it is session named emm-scraper here

ubuntu@ip-xxx-xx-xx-xxx:~$ tmux attach -t emm-scraper

# Note all tmux commands are preceded by ctrl-b, where ctrl-b is <ctrl> ans 'b' pressed together)

# you can detach from a session and reattach by ssh-ing in later to the same session

ctrl-b d
[detached (from session 0)]
ubuntu@xx-xxx-xx-xx-xxx:~$ 

# some basic tmux commands, all preceded by ctrl-b, where ctrl-b is <ctrl> ans 'b' pressed together)
ctrl-b 1  # for switching to a new window within the session labelled 1 (or 2, 3, etc if more windows were created)
ctrl-b d  # for detach
ctrl-b c  # to create a new window (much better than creating a new tab in shell even when working locally without tmux)
ctrl-b x  # to delete
ctrl-b l  # to switch to the previous window - very useful for laternating between two windows in a tmux session 
ctrl-b [  # get into scroll-mode so as to be able to scroll using arrow keys within the window - especially non-visible history of commands and output in window
q         # to quit scroll mode and return to window
```
