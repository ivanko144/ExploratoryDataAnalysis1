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

## 3. Making Plots (using the base plotting system) PNG 480 x 480 plot1.png
#     File plot1.png will be stored into working directory

png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(hpc$Global_active_power, freq = TRUE,  col = "red", border = NULL,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     axes = TRUE
     )

dev.off()

## 4. Working directory Cleanup
#     
#rm(hpc)
#rm(sourcefilename)
#file.remove(interimfilename)
#rm(interimfilename)
