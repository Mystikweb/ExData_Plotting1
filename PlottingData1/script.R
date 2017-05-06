# Create a temp file to hold the download
zipFile <- tempfile()

# Download the required file to the temp file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = zipFile)

# Read the file that is zipped with the correct separator and the na values
raw_data <- read.table(unz(zipFile, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

# Clean up the temp file
unlink(zipFile)
rm(zipFile)

# Convert the date and time fiels to objects
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")
raw_data$Time <- as.POSIXct(raw_data$Time, format = "%H:%M:%S")

# Get data only from the specified days
power_data <- raw_data[raw_data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

# To reduce the overhead remove the raw data from the workspace
rm(raw_data)

# Plot 1
hist(power_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")