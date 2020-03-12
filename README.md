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
~/all/git/

$ docker run --rm -d -it --name=spark-gdelt --mount type=bind,source=${PWD},destination=/root/GIT lamastex/dockerdev:latest 

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

When you want to stop or start the container just do `docker stop spark-gdelt` or `docker start spark-gdelt` and then `docker exec -it spark-gdelt /bin/bash' to get inside the running container.

Note that `docker kill` will stop and remove the container. See `docker help` for more details.

