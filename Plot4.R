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

# creates a datetime variable pasting the date and the time variable
dataset$datetime <- paste(dataset$Date,dataset$Time,sep = " ")
# convert the datetime variable in the right format
dataset$datetime <- strptime(dataset$datetime,"%Y-%m-%d %H:%M:%S")

# Initialize the Plot4 as png (see: https://class.coursera.org/exdata-012/forum/thread?thread_id=3#post-64)
png("Plot4.png")

# set the structure containing 2x2 graphs, the margins parameters and remove the background
par(mfrow=c(2,2),mar=c(5,4,3,1),bg=NA)

# create the first graph
plot(dataset$datetime,dataset$Global_active_power,type="l",
     ylab="Global Active Power",xlab = "")

# create the second graph
plot(dataset$datetime,dataset$Voltage,type="l",
     ylab="Voltage",xlab = "datetime")

# start to create the third graph with the black line corresponding to the Sub_metering_1
plot(dataset$datetime,dataset$Sub_metering_1,type="l",col="black",ylim=c(0, 38),
     ylab="Energy sub metering",xlab = "")
# add the red line corresponding to the Sub_metering_2 to the third graph
lines(dataset$datetime,dataset$Sub_metering_2,col="red")
# add the blue line corresponding to the Sub_metering_3 to the third graph
lines(dataset$datetime,dataset$Sub_metering_3,col="blue")
# insert the legend on the third graph
legend("topright",lty=c(1,1),lwd=c(1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),box.lwd = 0)

# create the forth graph
plot(dataset$datetime,dataset$Global_reactive_power,type="l",ylab="Global_rective_power",
     xlab = "datetime")

# close the file device
dev.off()