zipName<-"HouseHold_elec.zip"
UnzipFile<-"household_power_consumption.txt"
DURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Downloading and unzipping (if not done already)
if(!file.exists(zipName))
  download.file(DURL,zipName)
if(!file.exists(UnzipFile))
  unzip(zipName)


DataFull<-read.table(UnzipFile,na.strings="?",sep=";",header=TRUE,stringsAsFactors=FALSE)
Data<-DataFull[DataFull$Date %in% c("1/2/2007","2/2/2007") ,]
rm(DataFull)
Data$Time<-strptime(paste(Data$Date,Data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
Data$Date<-as.Date(Data$Date,"%d/%m/%Y")

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(Data$Time, Data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(Data$Time, Data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(Data$Time,Data$Sub_metering_1,type="l", ylab="Energy Submetering", xlab="")
lines(Data$Time,Data$Sub_metering_2,col="red",type="l")
lines(Data$Time,Data$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.5,lty=1, lwd=2, col=c("black", "red", "blue"),bty="n")
plot(Data$Time,Data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
