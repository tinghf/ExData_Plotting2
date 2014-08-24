#  make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

plot1 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  allEmissions<-aggregate(NEI$Emissions, by=list(year = NEI$year), FUN=sum)
  
  bp<-barplot(
    as.integer(allEmissions$x),
    main = "Total PM2.5 emission by year",
    ylab="Total PM2.5 Emission (tons)",
    xlab="Years",
    names = c("1999", "2002", "2005", "2008")
  )
  
  dev.print(png, file = "plot1.PNG", 
  width = 480, height = 480
  )
  dev.off()
}