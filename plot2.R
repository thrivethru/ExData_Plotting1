plot2 <- function() {
  ## Reads in data from household_power_consumption a dataset with
  ## Measurements of electric power consumption in one household with a one-minute sampling rate 
  ## over a period of almost 4 years. 
  ## Takes a subset from the data of dates 2007-02-01 and 2007-02-02
  ## Plots a time series of Global Active Power
  ## Saves the plot as a PNG
  
  ## Necessary libraries
  library(data.table)
  library(dplyr)
  library(lubridate)
  
  ## columns to select
  colsToKeep <- c("Date", "Time", "Global_active_power")
  
  energyData <- fread("household_power_consumption.csv", sep = ";", header = TRUE, select = colsToKeep, na.strings="?", data.table = FALSE)
  energyDates <- filter(energyData, Date == "1/2/2007" | Date == "2/2/2007")
  
  ## Combine Date and Time as a date object
  energyDateTime <- transmute(energyDates, Date_Time = dmy_hms(paste(Date, Time, sep = " ")), Global_active_power = Global_active_power)
  
  ## create plot
  plot(energyDateTime, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
  lines(energyDateTime, type = "l")
  
  ## save plot as plot2.png
  dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
  dev.off() ## close the PNG device
}