##Plot2

# This script expects to find the file 'household_power_consumption.txt' in the directory it is run.
# Download the 'Electric power consumption [20Mb]' dataset from the Assignment 1 instructions page at
# https://class.coursera.org/exdata-012/human_grading/view/courses/973506/assessments/3/submissions
# then unzip the archive in your working directory in R.

## Import data

elec = read.table("household_power_consumption.txt",
                  sep=";",
                  dec=".",
                  header=TRUE,
                  stringsAsFactors=FALSE,
                  na.strings="?",
                  colClasses=c(rep("character",2), rep("numeric",7)))

## Create subset for the dates of February 1 and 2, 2007 
elecsub <- subset(elec, elec$Date == "1/2/2007" | elec$Date == "2/2/2007")

## Convert date and time character string columns into one POSIXlt time object column
datetime <- paste(elecsub$Date, elecsub$Time, sep=" ")
datetimeobj <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

## Bind new time object column to the front of the elecsub data.frame
elecsubt <-cbind(datetimeobj, elecsub)

## Plot histogram and output to png file 
png(filename="plot2.png", width=480, height=480)
par(bg="NA")
with(elecsubt, plot(datetimeobj, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()