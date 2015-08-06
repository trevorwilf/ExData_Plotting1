library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(grid)
setwd("C:\\github\\ExData_Plotting1")
# get data set
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "powerconsumption.zip")
#unzip("powerconsumption.zip")

powertable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skipNul = TRUE, blank.lines.skip = TRUE)
powertable <- mutate(powertable, DateTime = as.POSIXct(paste(powertable$Date, powertable$Time), format="%d/%m/%Y %H:%M:%S"))
powertable$Date <- as.Date(powertable$Date, format= "%d/%m/%Y")
powertable$Time <- as.Date(powertable$Time, format= "%H:%M:%S")


powersubset <- as.data.frame(subset(powertable, Date >= "2007-02-01" & Date <= "2007-02-02"))


#plot(y = powersubset$Global_active_power, x = powersubset$DateTime)

ggplot(data=powersubset, aes(x=powersubset$DateTime, y=powersubset$Global_active_power, group=1)) +
  geom_line() +
  ylab("Global Active Power (kilowatts)") +
  xlab("") +
  scale_x_datetime(labels = date_format("%a"),
    breaks = date_breaks("1 day")) +
  theme(
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA),
        axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
        axis.text.y = element_text(vjust = 0, hjust = .75, angle = 90, colour = "black", size = 13),
        axis.ticks.length = unit(.4, "cm"),
        axis.title.y=element_text(vjust=2, size = 13)
        )

