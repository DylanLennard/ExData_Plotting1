#### plot 2 ####
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
DT <- fread("household_power_consumption.txt", sep = ";", na.strings="?")

### subset by dates 02/01/2007-02/02/2007
DT[, Date:=as.Date(Date, format = "%d/%m/%Y")]
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
DT <- DT[DT$Date %in% dates]

### create DateTime string to use on x-axis
DT[, DateTime:= paste(Date, Time)]
DT[, "DateTime":=lapply(.SD, function(x) as.POSIXct(strptime(x, 
                                "%Y-%m-%d %H:%M:%S"))),.SDcols="DateTime"]

### open png graphics
png(file="plot2.png", width=480, height=480)

### adjust margins slightly
par(mar = c(5.1, 5.1, 4.1, 4.1))

### create plot
with(DT, plot(DateTime, Global_active_power, 
              ylab = "Global Active Power (kilowatts)", 
              xlab = NA, type = "l"))

### close png graphics
dev.off()