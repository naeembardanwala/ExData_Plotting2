library(ggplot2)
#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
unqSCC<-unique(SCC$SCC)

# device
png(filename="plot6.png",width = 550, height = 550)

#filter in SCC in master file
Baltimore<-NEI[NEI$SCC %in% unqSCC & NEI$fips == "24510" & NEI$type == "ON-ROAD",]
LosAngeles<-NEI[NEI$SCC %in% unqSCC & NEI$fips == "06037" & NEI$type == "ON-ROAD",]


# aggregate
aggBaltimore <- aggregate(Baltimore$Emissions, 
                           by = list(Year = Baltimore$year), 
                           FUN = sum)

aggLosAngeles <- aggregate(LosAngeles$Emissions, 
                          by = list(Year = LosAngeles$year), 
                          FUN = sum)

colnames(aggBaltimore) <- c("Year", "Emissions")
colnames(aggLosAngeles) <- c("Year", "Emissions")

# plot case study style
par(mfrow = c(1, 1))

#merge by year
mrg <- merge(aggBaltimore, aggLosAngeles, by = "Year")
colnames(mrg) <- c("Year", "Baltimore","LosAngeles")

# set range for comparisions
rng <- range(mrg$Baltimore, mrg$LosAngeles, na.rm = T)

# now plot
with(mrg, plot(Year, Baltimore,ylim=rng,col="blue",ylab="Total Emissions In Tons"))
with(mrg, points(Year, mrg$LosAngeles,col="red"))

#set title and legend
title(main="Baltimore vs Los Angeles Motor Vehicle Emission")
legend("center",pch=1, col=c("blue","red"),legend=c("Baltimore","Los Angeles"),box.lty=0,box.lwd=0)

#draw segments for the year
segments(mrg$Year,mrg$Baltimore, mrg$Year,mrg$LosAngeles)
dev.off()  

