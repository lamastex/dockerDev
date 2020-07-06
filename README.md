# dockerDev
Dockerized Development Environment for Spark+Scala+mvn/sbt+...

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

