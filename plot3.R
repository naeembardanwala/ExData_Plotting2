library(ggplot2)
#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
unqSCC<-unique(SCC$SCC)
# device
png(filename="plot3.png",width = 550, height = 550)

#filter in SCC in master file
flNEI<-NEI[NEI$SCC %in% unqSCC,]

Baltimore <- flNEI[flNEI$fips == "24510", ]


# aggregate
aggBaltimore <- aggregate(Baltimore$Emissions, 
                           by = list(Year = Baltimore$year, Type = Baltimore$type), 
                           FUN = sum)

colnames(aggBaltimore) <- c("Year", "Type", "Emissions")

g<-ggplot(aggBaltimore, aes(Year, Emissions, colour = Type)) + geom_line() + labs(title="Total PM25 Emissions(tons) in Baltimore City")
print(g)
dev.off()  

