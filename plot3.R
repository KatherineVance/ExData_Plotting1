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

# Create the line graph and save it in a file called "plot3.png"
png("plot3.png")
plot(powerdata$datetime, powerdata$Sub_metering_1, 
     type="n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(powerdata$datetime, powerdata$Sub_metering_1, col = "black")
lines(powerdata$datetime, powerdata$Sub_metering_2, col = "red")
lines(powerdata$datetime, powerdata$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1)
dev.off()