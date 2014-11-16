wd <- getwd()
fpath <- file.path(wd,"activity_mon.rds")
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
if(!file.exists(fpath)){
  ## generate temp files/dirs to fetch zip file, and unzip data
  temp <- tempfile()
  download.file(url,temp)
  zipdir <- tempfile()
  dir.create(zipdir)
  unzip(temp, exdir=zipdir)
  files <- list.files(zipdir)
  ## read data to pwrdat variable
  activity_dat <- read.table(paste(zipdir, files[1], sep = "/"),header=TRUE, sep=',', na.strings='NA', colClasses=c("numeric","character","numeric"))
  ## unlink temporary files
  unlink(temp)
  unlink(zipdir)
  activity_dat$date <- as.Date(activity_dat$date,"%Y-%m-%d")
  ## save cache data
  saveRDS(activity_dat, fpath)

}
else {
  ## fetch cache data, data found
  activity_dat <- readRDS(fpath)
}
