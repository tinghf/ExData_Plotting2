# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

plot2 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  allEmissions<-aggregate(subset(NEI, fips=="24510")$Emissions, by=list(year = subset(NEI, fips=="24510")$year), FUN=sum)
  
  bp<-barplot(
    as.integer(allEmissions$x),
    main = "PM2.5 emission by year in Baltimore City",
    ylab="Total PM2.5 Emission (tons)",
    xlab="Years",
    names = c("1999", "2002", "2005", "2008")
  )
  
  dev.print(png, file = "plot2.PNG", 
  width = 480, height = 480
  )
  dev.off()
}