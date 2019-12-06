# Load the dplyr package so we can use the mutate function later
library(dplyr)

# Load data in from a file called "household_power_consumption.txt".  The file must be in the working directory.
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "", na.strings = "?")

# Convert the Date column from a factor variable to a Date variable.
powerdata$Date <- as.Date(powerdata$Date, format("%d/%m/%Y"))

# Subset the data.frame to keep only dates 2007-02-01 and 2007-02-02
powerdata <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")

# Concatenate the Date and Time columns into one variable called datetime
powerdata <- mutate(powerdata, datetime = paste(powerdata$Date, powerdata$Time))

# Convert the new datetime variable to POSIXlt
powerdata$datetime <- strptime(powerdata$datetime, format = "%Y-%m-%d %H:%M:%S")

# Create the plot and save it in a file called "plot4.png"
png("plot4.png")
  # Set up that the image will be a 2 by 2 array of subplots
par(mfrow = c(2,2))

  # Make the top left subplot
plot(powerdata$datetime, powerdata$Global_active_power, 
     type="n", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
lines(powerdata$datetime, powerdata$Global_active_power)

  # Make the top right subplot
plot(powerdata$datetime, powerdata$Voltage, 
     type="n", 
     xlab = "datetime", 
     ylab = "Voltage")
lines(powerdata$datetime, powerdata$Voltage)

  # Make the bottom left subplot
plot(powerdata$datetime, powerdata$Sub_metering_1, 
     type="n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(powerdata$datetime, powerdata$Sub_metering_1, col = "black")
lines(powerdata$datetime, powerdata$Sub_metering_2, col = "red")
lines(powerdata$datetime, powerdata$Sub_metering_3, col = "blue")
legend("topright", 
       inset = .01,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       box.lty = 0)

  # Make the bottom right subplot
plot(powerdata$datetime, powerdata$Global_reactive_power, 
     type="n", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")
lines(powerdata$datetime, powerdata$Global_reactive_power)

dev.off()