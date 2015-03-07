##Plot4

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
elecsub <-cbind(datetimeobj, elecsub)

## Plot graphs and output to png file
png(filename="plot4.png", width=480, height=480)
par(mfcol=c(2,2), bg="NA")
with(elecsub, {
  plot(datetimeobj, Global_active_power, ylab="Global Active Power", xlab="", type="l")
  with(elecsub, plot(datetimeobj, Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab=""))
  with(elecsub, points(datetimeobj, Sub_metering_2, type="l", col="red"))
  with(elecsub, points(datetimeobj, Sub_metering_3, type="l", col="blue"))
  legend("topright", lty=c(1,1), col = c("black", "red", "blue"), box.col="white", inset=0.01, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetimeobj, Voltage, ylab="Voltage", xlab="datetime", type="l")
  plot(datetimeobj, Global_reactive_power, xlab="datetime", type="l")
})
dev.off()