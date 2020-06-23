#downloading data

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,'household_power_consumption.zip')
unzip('household_power_consumption.zip')
data <- read.table('household_power_consumption.txt', header = TRUE, sep = ';',na.strings = '?')

#summary(data)
# Date               Time           Global_active_power Global_reactive_power    Voltage      Global_intensity
# Length:2075259     Length:2075259     Min.   : 0.076      Min.   :0.000         Min.   :223.2   Min.   : 0.200  
# Class :character   Class :character   1st Qu.: 0.308      1st Qu.:0.048         1st Qu.:239.0   1st Qu.: 1.400  
# Mode  :character   Mode  :character   Median : 0.602      Median :0.100         Median :241.0   Median : 2.600  
# Mean   : 1.092      Mean   :0.124         Mean   :240.8   Mean   : 4.628  
# 3rd Qu.: 1.528      3rd Qu.:0.194         3rd Qu.:242.9   3rd Qu.: 6.400  
# Max.   :11.122      Max.   :1.390         Max.   :254.2   Max.   :48.400  
# NA's   :25979       NA's   :25979         NA's   :25979   NA's   :25979   
# Sub_metering_1   Sub_metering_2   Sub_metering_3  
# Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
# 1st Qu.: 0.000   1st Qu.: 0.000   1st Qu.: 0.000  
# Median : 0.000   Median : 0.000   Median : 1.000  
# Mean   : 1.122   Mean   : 1.299   Mean   : 6.458  
# 3rd Qu.: 0.000   3rd Qu.: 1.000   3rd Qu.:17.000  
# Max.   :88.000   Max.   :80.000   Max.   :31.000  
# NA's   :25979    NA's   :25979    NA's   :25979 

#filterind data from the dates 2007-02-01 and 2007-02-02 and combining date and time
filter_data <- data[data$Date %in% c('1/2/2007','2/2/2007'),]
datetime <- strptime(paste(filter_data$Date, filter_data$Time, sep=''), '%d/%m/%Y %H:%M:%S') 

#making the 3-rd plot
par(pty="s")
par(mar=c(2,2,1,1))
plot(datetime, filter_data$Sub_metering_1, type='l',xlab='', ylab='Energy sub metering')
lines(datetime, filter_data$Sub_metering_2, type='l', col='red')
lines(datetime, filter_data$Sub_metering_3, type='l', col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=1, lwd=2.5, col=c('black', 'red', 'blue'))

#saving the plot
dev.copy(png,'plot3.png', width=480, height=480)
dev.off()

