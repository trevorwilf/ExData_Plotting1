#########################
## Author: Trevor
## Date: 8/06/2015
#########################
# dependencies
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(grid)
library(reshape2)

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

# cleanup dataset
powertable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skipNul = TRUE, blank.lines.skip = TRUE)
powertable <- mutate(powertable, DateTime = as.POSIXct(paste(powertable$Date, powertable$Time), format="%d/%m/%Y %H:%M:%S"))
powertable$Date <- as.Date(powertable$Date, format= "%d/%m/%Y")
powertable$Time <- as.Date(powertable$Time, format= "%H:%M:%S")

powersubset <- as.data.frame(subset(powertable, Date >= "2007-02-01" & Date <= "2007-02-02"))

# create graph
ggplot(data=powersubset) +
  geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_1, label = "Sub_metering_1", colour = "Sub_metering_1")) +
  geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_2, label = "Sub_metering_2", colour = "Sub_metering_2")) +
  geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_3, label = "Sub_metering_3", colour = "Sub_metering_3")) +                 
  scale_color_manual(values=c("black", "red", "blue")) +
  ylab("Energy Sub Metering") +
  xlab("") +
  scale_x_datetime(labels = date_format("%a"),
    breaks = date_breaks("1 day")) +
  theme(
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA),
        axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
        axis.text.y = element_text(vjust = 0, hjust = .5, angle = 90, colour = "black", size = 13),
        axis.ticks.length = unit(.4, "cm"),
        axis.title.y=element_text(vjust=2),
        legend.position = c(1, 1), 
        legend.justification = c(.92, .85),
        legend.title=element_blank(),
        legend.background = element_rect(colour = "black", fill = NA),
        legend.key = element_rect(fill = NA),
        legend.key.height=unit(.4,"cm")
        )

#export png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()