## 0. Archive exdata_data_household_power_consumption.zip should be unzipped
#     into working directory.

## 1. Read source data (text file), parse it (2007-02-01 and 2007-02-02)
#     write results to file, release the memory

sourcefilename <- "household_power_consumption.txt"
interimfilename <- "interimfile.txt"

sourcefile <- scan(sourcefilename, character(0), sep = "\n")
writeLines(
  sourcefile[c(1, grep("^1/2/2007", sourcefile), grep("^2/2/2007", sourcefile))],
  interimfilename, sep = "\n"
)
rm(sourcefile)

## 2. Loading data from interim file

hpc <- read.table(interimfilename, header = TRUE, sep = ";", dec = ".",
                  colClasses = c(rep("character", 2), rep("numeric", 7))
)

hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

## 3. Making Plots (using the base plotting system) PNG 480 x 480 plot3.png
#     File plot3.png will be stored into working directory

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

# Plot #1
plot(hpc$DateTime, hpc$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = ""
)

# Plot #2
plot(hpc$DateTime, hpc$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime"
)

# Plot #3
plot(hpc$DateTime, hpc$Sub_metering_1,
     type = "l", col = "black",
     ylab = "Energy sub metering",
     xlab = ""
)

lines(hpc$DateTime, hpc$Sub_metering_2,
      type = "l", col = "red"
)

lines(hpc$DateTime, hpc$Sub_metering_3,
      type = "l", col = "blue"
)

legend("topright", col = c("black", "red",  "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1
)

# Plot #4
plot(hpc$DateTime, hpc$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime"
)


dev.off()

## 4. Working directory Cleanup
#     
#rm(hpc)
#rm(sourcefilename)
#file.remove(interimfilename)
#rm(interimfilename)