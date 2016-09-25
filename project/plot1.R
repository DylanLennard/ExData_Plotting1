#### plot 1 ####
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
DT <- DT[, Date:=as.Date(Date, format="%d/%m/%Y")]
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
DT <- DT[DT$Date %in% dates]

### open png graphics
png(file="plot1.png", width=480, height=480)

### create plot
with(DT, hist(Global_active_power, col = "red", 
              main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)"))

### close png graphics
dev.off()
