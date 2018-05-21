#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
unqSCC<-unique(SCC$SCC)

# device
png(filename="plot1.png",width = 480, height = 480)

#filter for SCC in master file
flNEI<-NEI[NEI$SCC %in% unqSCC,]

#Get ragged array 
sumEmissions<-tapply(flNEI$Emissions,flNEI$year,FUN=sum,na.rm=T)

plot(names(sumEmissions), 
     sumEmissions, type="l", xlab = "Year", 
     ylab="Total PM2.5 Emissions (tons)", 
     main = "PM2.5 Emissions by Year " , 
     col="Blue")

dev.off()