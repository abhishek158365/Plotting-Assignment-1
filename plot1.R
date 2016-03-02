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

png("plot1.png", width=480, height=480)
hist(Data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()