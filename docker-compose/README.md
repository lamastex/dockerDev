# Docker-compose
Example of how to use docker-compose to dockerize webscraping with Rselenium. In order to do this we need to specify:
- The headless webdriver we want to use
- The docker-compose file
- The remote server adress for the driver.
This example uses image [selenium/standalone-chrome](https://hub.docker.com/r/selenium/standalone-chrome) for the Headless Chrome Webdriver, the [albertnilsson/rselenium](https://hub.docker.com/repository/docker/albertnilsson/rselenium) for the actual scraping and we will scrape the header for the the following web page: [https://www.r-project.org/about.html](https://www.r-project.org/about.html).

The first thing we will do is pull the images, do:
* `docker pull albertnilsson/rselenium`
* `docker pull selenium/standalone-chrome`

Next we will have to specify the [docker-compose.yml](https://docs.docker.com/compose/) file.
```
 services:
    selenium:
      image: selenium/standalone-chrome
      shm_size: 2gb
      ports:
        - "4444:4444"
    scraper:
      image: albertnilsson/rselenium
      entrypoint: Rscript /root/scrape_r.R /root/tmp_urls.csv
      volumes:
        - .:/root
      depends_on:
        - selenium
  
```

This specifys that we have two services selenium and scraper.
The important to notice from the first is that we set **shm_size: 2gb** which specifies the shared memory. The reason for this is that if we don't increase the shared memory the driver crashes. For the scraper container we notice that we have **depends_on selenium**. This means that when when we do `docker-compose` up the selenium container will start before the scraper.


Now to the script that actually does the scraping. For the remote driver `remoteDriver(remoteServerAddr ="selenium",browserName= "chrome", port=4444L)` we have to specify `remoteServerAddr ="selenium"` since the default is localhost. Now if we do `docker-compose up --abort-on-container-exit` the containers will start, the script scrape_r.R will run, write the header of the web page to head.csv and then the containers will shutdown.
