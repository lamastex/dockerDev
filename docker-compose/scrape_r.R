suppressMessages(library(RSelenium))
suppressMessages(library(magrittr))
argv <- commandArgs(trailingOnly=TRUE)
OUTPUT_PATH <- argv[1] 
if(length(argv) != 1) {
  stop("Usage: RScript OUTPUT_PATH")
}
Sys.sleep(5)
eCaps <- list(
  chromeOptions = 
    list(prefs = list("profile.default_content_settings.popups" = 0L)))
remDr <- remoteDriver(remoteServerAddr ="selenium",browserName= "chrome", port=4444L)

remDr$open()
remDr$navigate("https://www.r-project.org/about.html")
header <- remDr$findElements(using = 'xpath', "/html/body/div/div[1]/div[2]/h1")[[1]]$getElementText()
write.table(header, 
            file = OUTPUT_PATH,
            row.names = FALSE,
            quote=FALSE,
            col.names =FALSE
           )