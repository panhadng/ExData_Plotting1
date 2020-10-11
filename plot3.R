#load the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "data/exdata-data-household-power-consumption.zip")
unzip(zipfile = "data/exdata-data-household-power-consumption.zip", exdir = "data")
data1 <- read.delim("data/household_power_consumption.txt", sep = ";")
options(scipen = 999)
library(dplyr)

#subset
data = rbind(data1[data1$Date == "1/2/2007",], data1[data1$Date == "2/2/2007",])
data["NA",] = data["?",]

#convert to appropriate data types
data$Date <- as.Date(data$Date , format = "%d/%m/%Y")
data$date.and.time <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

#saves as png file
png(file = "plot3.png")

#plot the graph
plot(x = data$date.and.time, y = data$Sub_metering_1, col = "black", 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = data$date.and.time, y = data$Sub_metering_2, col = "red")
lines(x = data$date.and.time, y = data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)

#close graphics device
dev.off()