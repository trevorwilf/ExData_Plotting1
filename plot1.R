#########################
## Author: Trevor
## Date: 8/06/2015
#########################

# adjust to your own working directory
setwd("C:\\github\\ExData_Plotting1")

# get data set
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("exdata-data-household_power_consumption.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "powerconsumption.zip")
    unzip("powerconsumption.zip")
  }
  unzip("powerconsumption.zip")
}

# cleanup data set
powertable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skipNul = TRUE, blank.lines.skip = TRUE)
powertable$Date <- as.Date(powertable$Date, format= "%d/%m/%Y")

powersubset <- as.data.frame(subset(powertable, Date >= "2007-02-01" & Date <= "2007-02-02"))

# create histogram
par(oma=c(0,0,1,0), mar=c(4,4,2,1), mgp=c(2,1,0), cex.axis=.75, cex.lab=.75)
hist(powersubset$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

#export png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()