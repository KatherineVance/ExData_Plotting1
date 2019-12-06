# Load data in from a file called "household_power_consumption.txt".  The file must be in the working directory.
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "", na.strings = "?")

# Convert the Date column from a factor variable to a Date variable.
powerdata$Date <- as.Date(powerdata$Date, format("%d/%m/%Y"))

# Subset the data.frame to keep only dates 2007-02-01 and 2007-02-02
powerdata <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")

# Create the histogram and save it in a file called "plot1.png"
png("plot1.png")
hist(powerdata$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     ylim = c(0, 1200))
dev.off()