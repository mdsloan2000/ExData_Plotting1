#       Run the function plot1() to prepare the data and execute the file.  The function will prepare the data and 
#       create the file plot1.png in the working directory.  It will delete any prexisting plot1.png file in the
#       the directory.  Note that the output is also displayed on the screen.


prepare_data <- function() {
        
#         The following code checks for the relevant data in the local directory.  If the file is not found or
#         is not unpacked, the code takes the appropriate action.  For convenience sake, I hard code the two dates to
#         search the data then subset and return the table based on the two dates.  This could be more elegant and 
#         setable by perhaps allowing a vector of dates to be passed but this worked fine.  Finally, the code returns 
#         the subsetted table.  
        
        
        if (!file.exists("household_power_consumption.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                              "household_power_consumption.zip")
        }
        if (!file.exists("household_powerConsumption.txt")) {
                unzip("household_power_consumption.zip")
        }
        
        dt <- read.csv("./household_power_consumption.txt", sep=";", na.strings="?", 
                       stringsAsFactors=FALSE)
        
        date1 <- as.Date("2007-02-01")
        date2 <- as.Date("2007-02-02")
        
        dt <- dt[date1 == as.Date(dt$Date, "%d/%m/%Y")| date2 ==as.Date(dt$Date, "%d/%m/%Y"),]
        
        return (dt)        
}


plot3 <- function() {

#       The following routine takes the data from prepare data, plots it to the screen then writes it to a file.

        plotit <- prepare_data()
        plotit$datetime <- as.POSIXlt (paste(plotit$Date, plotit$Time),  "%d/%m/%Y %H:%M:%S", tz = "EST")
        p1 <- plotit$datetime
        p2 <- plotit$Sub_metering_1
        p3 <- plotit$Sub_metering_2
        p4 <- plotit$Sub_metering_3
        legnames <-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        
        for (i in 1:2)  {
                if (i==2) {png(filename="./plot3.png")}
                
                plot (p1, p2, type = "l", col = "Black", ylim = c(0,30), ylab = "Energy sub metering", xlab = "")
                legend ("topright", cex=0.70, pch=16, col=c("Black","Red","Blue"), legend = legnames)
                par(new=T)
                lines(p1, p3, type = "l", col = "Red", ylim = c(0,30))
                lines(p1, p4, type = "l", col = "Blue", ylim = c(0,30))
                
                par(new=F)
                if (i==2) {dev.off()}
        }
        return()
}

