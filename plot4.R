library(ggplot2)
#Set working directory
setwd("~/RWorks/ExploratoryAnalysis")

#load full data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
CombCoalSCC <- SCC[grep("Comb.*Coal", SCC$EI.Sector), "SCC"]

# device
png(filename="plot4.png",width = 550, height = 550)

#filter in SCC in master file
flNEI<-NEI[NEI$SCC %in% CombCoalSCC,]


# aggregate
aggEmissions <- aggregate(flNEI$Emissions, 
                           by = list(Year = flNEI$year), 
                           FUN = sum)

colnames(aggEmissions) <- c("Year", "Emissions")

# plot
g<-ggplot(aggEmissions, aes(Year, Emissions)) + geom_line(color="purple") + labs(title = "Total PM25 Emissions(Tons) from Coal-Combustion Sources",y="Total Emissions")
print(g)
dev.off()  

