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


plot2 <- function() {

#       The following routine takes the data from prepare data, plots it to the screen then writes it to a file.

        plotit <- prepare_data()
        plotit$datetime <- as.POSIXlt (paste(plotit$Date, plotit$Time),  "%d/%m/%Y %H:%M:%S", tz = "EST")
        p1 <- plotit$datetime
        p2 <- plotit$Global_active_power
       for (i in 1:2)  {
                 gap <- plotit$Globalactive_power  #creates GAP
                 
                  
                if (i==2) {png(filename="./plot2.png")}
                plot (p1,p2, type = "l", xlab = "datetime", ylab= "Global Active Power (kilowatts)")
                if (i==2) {dev.off()}
        }
        return()
}

