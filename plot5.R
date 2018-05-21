library(ggplot2)
#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
unqSCC<-unique(SCC$SCC)

# device
png(filename="plot5.png",width = 550, height = 550)

#filter in SCC in master file
flNEI<-NEI[NEI$SCC %in% unqSCC & NEI$fips == "24510" & NEI$type == "ON-ROAD",]


# aggregate
aggEmissions <- aggregate(flNEI$Emissions, 
                           by = list(Year = flNEI$year), 
                           FUN = sum)

colnames(aggEmissions) <- c("Year", "Emissions")

# plot
g<-ggplot(aggEmissions, aes(Year, Emissions)) + geom_line(color="red") + labs(title = "Total PM25 Emissions(Tons) from Motor Vehicles in Baltimore City",y="Total Emissions")
print(g)
dev.off()  

