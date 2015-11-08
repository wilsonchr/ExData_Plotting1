# This file produces the first required plot for Project 1 of Exploratory data analysis. 

# Download and unzip the data if it's not already available
if(!file.exists("household_power_consumption.txt")){
  if(!file.exists("household_power_consumption.zip")){
    print("Downloading data")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  }
  print("Unzipping downloaded file.")
  unzip("household_power_consumption.zip")
}
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

# Plot a histogram
print("Plotting...")
png(filename = "plot1.png")
hist(as.numeric(powerdata_ss$Global_active_power), col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()
print("Done.")