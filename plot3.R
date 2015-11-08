# This file produces the third required plot for Project 1 of Exploratory data analysis. 

# Download and unzip the data if it's not already available
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("household_power_consumption.zip")){
    print("Downloading data")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  }
  print("Unzipping downloaded file.")
  unzip("household_power_consumption.zip")
}
# To save time, load the subset file if available
if(file.exists("household_power_consumption_subset.obj")){
  print("Subset file exists... loading...")
  load(file="household_power_consumption_subset.obj")
} else{
  print("Subset doesn't exist. Loading all data, subsetting, and saving.")
  # Load the data
  powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?"))
  # Convert Date + Time to timestamp
  powerdata$timestamp <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %H:%M:%S")
  # Select time range of interest (2007-02-01 -> 2007-02-02)
  powerdata_ss <- powerdata[powerdata$timestamp >= "2007-02-01" & powerdata$timestamp < "2007-02-03", ]
  save(powerdata_ss, file="household_power_consumption_subset.obj")
}

# Plot a time-series with multiple series
print("Plotting...")
png(filename = "plot3.png")
plot(powerdata_ss$timestamp, powerdata_ss$Sub_metering_1, xlab = "", ylab="Energy sub metering", main = "", type="n")
lines(powerdata_ss$timestamp, powerdata_ss$Sub_metering_1, col="black")
lines(powerdata_ss$timestamp, powerdata_ss$Sub_metering_2, col="red")
lines(powerdata_ss$timestamp, powerdata_ss$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col = c("black", "red", "blue"))
dev.off()
print("Done.")