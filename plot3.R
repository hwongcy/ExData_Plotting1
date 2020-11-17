# file name:   plot3.R
# description: This the program for the third plot of the Course Project 1 of EDA.
#              The program will first download the data file from provided web site
#              and read into a data frame "data.Extract". Then it will plot a
#              line chart of the "Sub_metering_1", "Sub_metering_2" and 
#              "Sub_metering_3" between 2007-02-01 and 2007-02-02 according to 
#              the examples. In addition, corresponding legends of the chart
#              will be ploted. The figure will be saved in PNG format with file 
#              name "plot3.PNG". Finally, the device will be closed before it is
#              exit.


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


# plot Energy Sub Metering

filename.plot3 <- "./plot3.png"

# plot the figure and save in the file plot1.png

png(filename.plot3, width = 480, height = 480, units = "px")

# plot the Sub_metering_1 with ylab

plot(data.Extracted$Time, 
     data.Extracted$Sub_metering_1, 
     xlab = '', 
     ylab = "Energy sub metering", 
     type = "l")

# plot the Sub_metering_2

lines(data.Extracted$Time, data.Extracted$Sub_metering_2, col = "red")

# plot the Sub_metering_3

lines(data.Extracted$Time, data.Extracted$Sub_metering_3, col = "blue")

# print the legend

legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

# close the device and connections

dev.off()
closeAllConnections()

