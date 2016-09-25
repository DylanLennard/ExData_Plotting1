#### plot 4 ####
setwd("./ExData_Plotting1/project")

if (!require("data.table")) {
    install.packages("data.table")
}
library(data.table)

### install the dataset if not already installed . 
fileName <- "household_power_consumption.txt"

if(!file.exists(fileName)){
    url <- paste0("https://d396qusza40orc.cloudfront.net/",
                  "exdata%2Fdata%2Fhousehold_power_consumption.zip")
    download.file(url, destfile = "project.zip", method = "curl")
    unzip("project.zip")
    file.remove("project.zip")
}

### read in document
DT <- fread(fileName, sep = ";", na.strings="?")

### subset by dates 02/01/2007-02/02/2007
DT[, Date:=as.Date(Date, format = "%d/%m/%Y")]
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
DT <- DT[DT$Date %in% dates]

### create DateTime string to use on x-axis
DT[, DateTime:= paste(Date, Time)]
DT[, "DateTime":=lapply(.SD, function(x) as.POSIXct(strptime(x, 
                                    "%Y-%m-%d %H:%M:%S"))),.SDcols="DateTime"]

### open png graphics
png(file="plot4.png", width=480, height=480)

### set facet parameter
par(mfrow = c(2, 2))

### create plots
# plot 1
par(mar = c(5.1, 5.1, 4.1, 4.1))
with(DT, plot(DateTime, Global_active_power, 
              ylab = "Global Active Power (kilowatts)", 
              xlab = NA, type = "l"))

# plot 2
with(DT, plot(DateTime, Voltage, type = "l"))

# plot 3
par(mar = c(5.1, 5.1, 4.1, 4.1))
with(DT, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering",
              xlab = NA, type="l"))
with(DT, lines(DateTime, Sub_metering_2, col ="red"))
with(DT, lines(DateTime, Sub_metering_3, col ="blue"))
legend("topright", lty = 1, col = c("black","blue", "red"), 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                bty = "n")

# plot 4 now skeleton for plot 4 
with(DT, plot(DateTime, Global_reactive_power, type= 'l'))

### close png
dev.off()

