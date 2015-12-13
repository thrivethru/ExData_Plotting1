plot4 <- function() {
  ## Reads in data from household_power_consumption a dataset with
  ## Measurements of electric power consumption in one household with a one-minute sampling rate 
  ## over a period of almost 4 years. 
  ## Takes a subset from the data of dates 2007-02-01 and 2007-02-02
  ## Plots a timesseries of several variables
  ## Saves the plot as a PNG
  
  ## Necessary libraries
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ## columns to select
  
  energyData <- fread("household_power_consumption.csv", sep = ";", header = TRUE, na.strings="?", data.table = FALSE)
  energyDates <- filter(energyData, Date == "1/2/2007" | Date == "2/2/2007")
  
  ## Combine Date and Time as a date object
  energyDateTime <- mutate(energyDates, Date_Time = dmy_hms(paste(Date, Time, sep = " ")))
  
  par(mfrow = c(2, 2))
  xrange <- range(energyDateTime$Date_Time)
  ## create plots 1 global active power
  yrange1 <- range(energyDateTime$Global_active_power)
  plot(xrange, yrange1, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
  lines(energyDateTime$Date_Time,energyDateTime$Global_active_power, type = "l")
  
  ## create plot 2 voltage
  yrange2 <- range(energyDateTime$Voltage)
  plot(xrange, yrange2, type = "n", xlab = "", ylab = "Voltage")
  lines(energyDateTime$Date_Time,energyDateTime$Voltage, type = "l")
  
  ## create plot 3 sub metering
  yrange3 <- range(energyDateTime$Sub_metering_1, energyDateTime$Sub_metering_2, energyDateTime$Sub_metering_3)
  plot(xrange, yrange3, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_1, type = "l", col = "black")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_2, type = "l", col = "red")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_3, type = "l", col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
  
  ## create plot 4 global reactive power
  yrange4 <- range(energyDateTime$Global_reactive_power)
  plot(xrange, yrange4, type = "n", xlab = "", ylab = "Global Reactive Power (kilowatts)")
  lines(energyDateTime$Date_Time,energyDateTime$Global_reactive_power, type = "l")
  
  ## save plot as plot4.png
  dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
  dev.off() ## close the PNG device
}