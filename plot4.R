#########################
## Author: Trevor
## Date: 8/06/2015
#########################
# dependencies
#install.packages("gridExtra")
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(grid)
library(gridExtra)
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

# create four graphs
# graph using base system
par(mfrow=c(2,2), oma=c(0,0,1,0), mar=c(3,3,1,1), mgp=c(2,1,0), cex.axis=.75, cex.lab=.75)

#graph one
plot(powersubset$DateTime, powersubset$Global_active_power, 
     type="l",
     ylab="Global Active Power", xlab="")
#graph two
plot(powersubset$DateTime, powersubset$Voltage, 
     type="l",
     ylab="Voltage", xlab="datetime")
#graph three
plot(powersubset$DateTime, powersubset$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering", xlab="")
lines(powersubset$DateTime, powersubset$Sub_metering_2, col='Red')
lines(powersubset$DateTime, powersubset$Sub_metering_3, col='Blue')
legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n",
       pt.cex = 1, cex = .7,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#graph four
plot(powersubset$DateTime, powersubset$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power", xlab="datetime")

#export png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

####################################
# disregard this section
# misread instructions thought I could do this in ggplot leaving this here but it is commented out and not used in the script
# q1 <- ggplot(data=powersubset, aes(x=powersubset$DateTime, y=powersubset$Voltage, group=1)) +
#   geom_line() +
#   ylab("Voltage") +
#   xlab("datetime") +
#   scale_y_continuous(labels=c("",234,"",238,"",242,"",246,""), 
#                      breaks=seq(232,248, by = 2)) +
#   scale_x_datetime(labels = date_format("%a"),
#                    breaks = date_breaks("1 day")) +
#   theme(
#     panel.grid.major = element_blank(), 
#     panel.grid.minor = element_blank(), 
#     panel.background = element_blank(),
#     panel.border = element_rect(colour = "black", fill = NA),
#     axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
#     axis.text.y = element_text(vjust = 0, hjust = .5, angle = 90, colour = "black", size = 13),
#     axis.ticks.length = unit(.4, "cm"),
#     axis.title.y=element_text(vjust=1, size = 13)
#   )
# 
# q2 <- ggplot(data=powersubset, aes(x=powersubset$DateTime, y=powersubset$Global_active_power, group=1)) +
#   geom_line() +
#   ylab("Global Active Power (kilowatts)") +
#   xlab("") +
#   scale_x_datetime(labels = date_format("%a"),
#                    breaks = date_breaks("1 day")) +
#   theme(
#     panel.grid.major = element_blank(), 
#     panel.grid.minor = element_blank(), 
#     panel.background = element_blank(),
#     panel.border = element_rect(colour = "black", fill = NA),
#     axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
#     axis.text.y = element_text(vjust = 0, hjust = .75, angle = 90, colour = "black", size = 13),
#     axis.ticks.length = unit(.4, "cm"),
#     axis.title.y=element_text(vjust=1, size = 10)
#   )
# 
# q3 <- ggplot(data=powersubset) +
#   geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_1, label = "Sub_metering_1", colour = "Sub_metering_1")) +
#   geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_2, label = "Sub_metering_2", colour = "Sub_metering_2")) +
#   geom_line(aes(x=powersubset$DateTime, y=powersubset$Sub_metering_3, label = "Sub_metering_3", colour = "Sub_metering_3")) +                 
#   scale_color_manual(values=c("black", "red", "blue")) +
#   ylab("Energy Sub Metering") +
#   xlab("") +
#   scale_x_datetime(labels = date_format("%a"),
#     breaks = date_breaks("1 day")) +
#   theme(
#         panel.grid.major = element_blank(), 
#         panel.grid.minor = element_blank(), 
#         panel.background = element_blank(),
#         panel.border = element_rect(colour = "black", fill = NA),
#         axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
#         axis.text.y = element_text(vjust = 0, hjust = .5, angle = 90, colour = "black", size = 13),
#         axis.ticks.length = unit(.4, "cm"),
#         axis.title.y=element_text(vjust=1),
#         legend.position = c(1, 1), 
#         legend.justification = c(.92, .85),
#         legend.title=element_blank(),
#         #legend.background = element_rect(colour = "black", fill = NA),
#         legend.key = element_rect(fill = NA),
#         legend.key.height=unit(.4,"cm")
#         )
# 
# q4 <- ggplot(data=powersubset, aes(x=powersubset$DateTime, y=powersubset$Global_reactive_power, group=1)) +
#   geom_line() +
#   ylab("Global_reactive_power") +
#   xlab("datetime") +
#   scale_x_datetime(labels = date_format("%a"),
#                    breaks = date_breaks("1 day")) +
#   theme(
#     panel.grid.major = element_blank(), 
#     panel.grid.minor = element_blank(), 
#     panel.background = element_blank(),
#     panel.border = element_rect(colour = "black", fill = NA),
#     axis.text.x = element_text(vjust = 0, hjust = .5, colour = "black", size = 13),
#     axis.text.y = element_text(vjust = 0, hjust = .5, angle = 90, colour = "black", size = 13),
#     axis.ticks.length = unit(.4, "cm"),
#     axis.title.y=element_text(vjust=1, size = 13)#,
#     #axis.title.x=element_text(vjust=-.8, size = 13)
#   )
#
# combine four graphs
# grid.arrange(q2, q1, q3, q4)