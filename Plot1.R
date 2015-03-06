# This script start with assumption that the necessary file: "household_power_consumption.txt"
# has been downloaded from the following website:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# it has been unzipped and is availabe in the working directory 

# read the data
library(data.table)
large_dataset <- read.table("household_power_consumption.txt",sep=";", 
                            dec=".",header=TRUE,na.strings="?",stringsAsFactors=FALSE)

# set the date in the right "date"format (converting from character)
large_dataset$Date <- as.Date(large_dataset$Date, format="%d/%m/%Y")

# create a second dataset including only the observations made on the dates 2007-02-01 and 2007-02-02
dataset <- large_dataset[large_dataset$Date == "2007-02-01" | 
                           large_dataset$Date == "2007-02-02", ]
# Initialize the Plot1 as png (see: https://class.coursera.org/exdata-012/forum/thread?thread_id=3#post-64)
png("Plot1.png")

# set the margins parameters and remove the background
par(mar=c(4,4,2,1),oma=c(1,0,1,0),bg=NA)

# create the histogram
hist(dataset$Global_active_power, col="red",ylim=c(0, 1235),
     main="Global Active Power",xlab="Global Active Power (kilowatts)")

# close the file device
dev.off()