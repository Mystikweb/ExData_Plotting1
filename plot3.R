# Create a temp file to hold the download
zipFile <- tempfile()

# Download the required file to the temp file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = zipFile)

# Read the file that is zipped with the correct separator and the na values and filter it based on the required dates
power_data <- subset(read.table(unz(zipFile, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?"), Date == "1/2/2007" | Date == "2/2/2007")

# Clean up the temp file
unlink(zipFile)
rm(zipFile)

# Combine the date and time into one column for plotting
power_data$DateTime <- as.POSIXct(paste(power_data$Date, power_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Plot 3
# Start the new plot based on the date and time vs sub metering 1 column
with(power_data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub meeting"))

# Add the lines for each sub metering column
with(power_data, lines(DateTime, Sub_metering_1))
with(power_data, lines(DateTime, Sub_metering_2, col = "red"))
with(power_data, lines(DateTime, Sub_metering_3, col = "blue"))

# Add the legend
legend("topright", legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

# Create the png file from the screen graphics
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

# Turn off the copy device
dev.off()
