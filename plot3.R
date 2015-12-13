plot3 <- function() {
  ## Reads in data from household_power_consumption a dataset with
  ## Measurements of electric power consumption in one household with a one-minute sampling rate 
  ## over a period of almost 4 years. 
  ## Takes a subset from the data of dates 2007-02-01 and 2007-02-02
  ## Plots a timeseries of subm metering 1-3
  ## Saves the plot as a PNG
  
  ## Necessary libraries
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ## columns to select
  colsToKeep <- c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  energyData <- fread("household_power_consumption.csv", sep = ";", header = TRUE, select = colsToKeep, na.strings="?", data.table = FALSE)
  energyDates <- filter(energyData, Date == "1/2/2007" | Date == "2/2/2007")
  
  ## Combine Date and Time as a date object
  energyDateTime <- transmute(energyDates, Date_Time = dmy_hms(paste(Date, Time, sep = " ")), Sub_metering_1 = Sub_metering_1, Sub_metering_2 = Sub_metering_2, Sub_metering_3 = Sub_metering_3)
  
  ## create plot
  xrange <- range(energyDateTime$Date_Time)
  yrange <- range(energyDateTime$Sub_metering_1, energyDateTime$Sub_metering_2, energyDateTime$Sub_metering_3)
  plot(xrange, yrange, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_1, type = "l", col = "black")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_2, type = "l", col = "red")
  lines(energyDateTime$Date_Time, energyDateTime$Sub_metering_3, type = "l", col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
  
  ## save plot as plot3.png
  dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
  dev.off() ## close the PNG device
}