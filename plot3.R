# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

plot3 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  allEmissions<-aggregate(subset(NEI, fips=="24510")$Emissions, by=list(year = subset(NEI, fips=="24510")$year, type = subset(NEI, fips=="24510")$type), FUN=sum)
  
  library("ggplot2")
  
  g <- ggplot(allEmissions) + aes(x=year, y=x, colour=type) + geom_bar(stat="identity", width=2.5) + geom_text(aes(label=prettyNum(x, format="f", digits=5), vjust=-.2, fontface="bold")) + facet_wrap(~type) + scale_x_continuous(limits=c(1997, 2010), breaks=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008)) + ylab("Total PM2.5 emission per source in Baltimore City (tons)") + xlab("Year")
  print(g)
  
  dev.print(png, file = "plot3.PNG", 
  width = 960, height = 960
  )
  dev.off()
}