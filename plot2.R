#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
unqSCC<-unique(SCC$SCC)

# device
png(filename="plot2.png",width = 480, height = 480)

#filter in SCC in master file
flNEI<-NEI[NEI$SCC %in% unqSCC,]
Baltimore <- flNEI[flNEI$fips == "24510", ]

#Get ragged array 
sumEmissions<-tapply(Baltimore$Emissions,Baltimore$year,FUN=sum,na.rm=T)

plot(names(sumEmissions), 
     sumEmissions, type="l", xlab = "Year", 
     ylab="Total PM2.5 Emissions (tons)", 
     main = "PM2.5 Emissions by Year " , 
     col="Green")
legend("topright",pch=1, col="green",legend="Baltimore")

dev.off()