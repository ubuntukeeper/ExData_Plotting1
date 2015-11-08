library(dplyr)
consmp <- read.csv("../supplemental/household_power_consumption.txt", sep=";", header=TRUE,
                   stringsAsFactors=FALSE, na.strings="?", 
                   colClasses=c("character", "character", rep("numeric", 7)))
consmp_tab <- tbl_df(consmp)
consmp_tab <- consmp_tab %>% 
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(DateTime=paste(Date, Time)) %>%
    mutate(DateTime=as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S"))

png("plot4.png", width=480, height=480)

par(mfcol=c(2,2), mar=c(4,2,2,2))
with(consmp_tab, {
    plot(Global_active_power ~ DateTime, data=consmp_tab, type="l", 
         xlab="", ylab="Global Active Power (kilowatts)")
    
    plot(consmp_tab$DateTime, consmp_tab$Sub_metering_1, type="l", 
         xlab="", ylab="Energy sub metering")
    lines(x=consmp_tab$DateTime, y = consmp_tab$Sub_metering_2, col="red")
    lines(x=consmp_tab$DateTime, y = consmp_tab$Sub_metering_3, col="blue")
    legend("topright", lty=c(1,1), col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Voltage ~ DateTime, data=consmp_tab, type="l", 
         xlab="datetime", ylab="Voltage")

    plot(Global_reactive_power ~ DateTime, data=consmp_tab, type="l", 
         xlab="datetime", ylab="Voltage")
})

dev.off()
