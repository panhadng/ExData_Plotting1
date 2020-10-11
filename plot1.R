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

#convert and check
data$Date <- as.Date(data$Date , format = "%d/%m/%Y")
str(data)
data$Global_active_power <- as.numeric(data$Global_active_power)

#saves as png file
png(file = "plot1.png")

#plot the data
hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

#close graphics device
dev.off()