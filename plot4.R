# file name:   plot4.R
# description: This the program for the forth plot of the Course Project 1 of EDA.
#              The program will first download the data file from provided web site
#              and read into a data frame "data.Extract". Then it will plot 4
#              line charts of the Global Active Power, Voltage, Energy Sub Metering
#              and Global Reactive Power according to the examples. The figure will 
#              be saved in PNG format with file name "plot4.PNG". Finally, the 
#              device will be closed before it is exit.


# download and unzip the data file

data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.filename <- "./data/household_power_consumption.txt"

if(!file.exists("./data")) {
    dir.create("./data")
}

if(!file.exists(data.filename)) {
    download.file(data.url, destfile = "./data/Dataset.zip", method = "curl")
    unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
}



# data preparation

if(exists("data.All")) {
    rm(data.All)
}
data.All <- read.table(data.filename, 
                       header = TRUE,
                       sep = ";",
                       colClasses = c("character", "character", "numeric",
                                      "numeric", "numeric",
                                      "numeric", "numeric",
                                      "numeric", "numeric"), 
                       na.strings = "?")

# Convert Date and Time from character format to date and datetime format

data.All$Date <- as.Date(data.All$Date, format("%d/%m/%Y"))
data.All$Time <- as.POSIXct(paste(data.All$Date, data.All$Time))

if(exists("data.Extracted")) {
    rm(data.Extracted)
}
data.Extracted <- subset(data.All, data.All$Date >= as.Date("2007-02-01") & data.All$Date <= as.Date("2007-02-02"))


# plot Global Active Power

filename.plot4 <- "./plot4.png"

# plot the figure and save in the file plot4.png

png(filename.plot4, width = 480, height = 480, units = "px")


# setup the multi plot

par(mfrow = c(2, 2))


# plot the Global Active Power

plot(data.Extracted$Time, 
     data.Extracted$Global_active_power, 
     xlab = "", 
     ylab = "Global Active Power (kilowatt)", 
     type = "l")

# plot the Voltage

plot(data.Extracted$Time, 
     data.Extracted$Voltage, 
     xlab = "datetime", 
     ylab = "Voltage", 
     type = "l")


# plot the Energy Sub Metering

plot(data.Extracted$Time, 
     data.Extracted$Sub_metering_1, 
     xlab = '', 
     ylab = "Energy sub metering", 
     type = "l")

lines(data.Extracted$Time, data.Extracted$Sub_metering_2, col = "red")

lines(data.Extracted$Time, data.Extracted$Sub_metering_3, col = "blue")

legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1,
       bty = "n")


# plot the Global Reactive Power

plot(data.Extracted$Time, 
     data.Extracted$Global_reactive_power, 
     xlab = "datetime", 
     ylab = "Global_reactive_power", 
     type = "l")


# close the device and connections

dev.off()
closeAllConnections()

