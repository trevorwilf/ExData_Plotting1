#########################
## Author: Trevor
## Date: 8/06/2015
#########################

setwd("C:\\github\\ExData_Plotting1")
# get data set
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "powerconsumption.zip")
#unzip("powerconsumption.zip")

# cleanup data set
powertable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skipNul = TRUE, blank.lines.skip = TRUE)
powertable$Date <- as.Date(powertable$Date, format= "%d/%m/%Y")

powersubset <- as.data.frame(subset(powertable, Date >= "2007-02-01" & Date <= "2007-02-02"))

# create histogram
hist(powersubset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#export png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()