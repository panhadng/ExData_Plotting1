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
png(file = "plot2.png")

#plot the graph
plot(y=data$Global_active_power, x=data$date.and.time, 
     type = "l", 
     xlab="", 
     ylab = "Global Active Power (kilowatts)")

#close graphics device
dev.off()