# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

plot4 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  coalCombustion<-subset(SCC, grepl("- Coal", as.character(EI.Sector)))
  sccs<-coalCombustion$SCC
  coalNEI<-subset(NEI, SCC %in% sccs)
  
  allEmissions<-aggregate(coalNEI$Emissions, by=list(year = coalNEI$year), FUN=sum)
  
  bp<-barplot(
    as.integer(allEmissions$x/1000),
    main = "Total PM2.5 emission from coal combustion-related sources by year (US)",
    ylab="PM2.5 Emission (kilotons)",
    xlab="Years",
    names = c("1999", "2002", "2005", "2008")
  )
  
  dev.print(png, file = "plot4.PNG", 
  width = 640, height = 480
  )
  dev.off()
}