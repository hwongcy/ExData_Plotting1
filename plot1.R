# file name:   plot1.R
# description: This the program is the first plot of the Course Project 1 of EDA.
#              The program will first download the data file from provided web site
#              and read into a data frame "data.Extract". Then it will plot a
#              histogram of the "Global Active Power" between 2007-02-01 and
#              2007-02-02 according to the examples. The figure will be saved in
#              PNG format with file name "plot1.PNG". Finally, the device will
#              be closed before exit.


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


# read the 2007-02-01 and 2007-02-02 data from the data file

data.file <- file(data.filename)
data.Extracted <- read.table(text = grep("^[1,2]/2/2007", readLines(data.file), value = TRUE), 
                             sep = ";",
                             col.names = c("Date", "Time", "Global_active_power", 
                                           "Global_reactive_power", "Voltage", 
                                           "Global_intensity", "Sub_metering_1",
                                           "Sub_metering_2", "Sub_metering_3"),
                             colClasses = c("character", "character", "numeric",
                                            "numeric", "numeric",
                                            "numeric", "numeric",
                                            "numeric", "numeric"), 
                             na.strings = "?")

# Convert Date and Time from character format to date and datetime format

data.Extracted$Date <- as.Date(data.Extracted$Date, format("%d/%m/%Y"))
data.Extracted$Time <- as.POSIXct(paste(data.Extracted$Date, data.Extracted$Time))


# plot Global Active Power

filename.plot1 <- "./plot1.png"

# plot the figure and save in the file plot1.png

png(filename.plot1, width = 480, height = 480, units = "px")

with(data.Extracted, hist(Global_active_power, 
                          xlab = "Global Active Power (kilowatt)", 
                          main = "Global Active Power", 
                          col = "red"))

# close the device

dev.off()
