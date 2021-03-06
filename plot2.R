library(dplyr)
consmp <- read.csv("../supplemental/household_power_consumption.txt", sep=";", header=TRUE,
                   stringsAsFactors=FALSE, na.strings="?", 
                   colClasses=c("character", "character", rep("numeric", 7)))
consmp_tab <- tbl_df(consmp)
consmp_tab <- consmp_tab %>% 
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(DateTime=paste(Date, Time)) %>%
    mutate(DateTime=as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S"))

png("plot2.png", width=480, height=480)
plot(Global_active_power ~ DateTime, data=consmp_tab, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
