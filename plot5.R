# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

plot5 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  motorVehicle <- subset(SCC, grepl("- On-Road ", as.character(EI.Sector)))
  sccs<-motorVehicle$SCC
  motorNEI<-subset(NEI, SCC %in% sccs)
  
  allEmissions<-aggregate(subset(motorNEI, fips=="24510")$Emissions, by=list(year = subset(motorNEI, fips=="24510")$year), FUN=sum)
  
  bp<-barplot(
    as.integer(allEmissions$x),
    main = "Total PM2.5 emission from motor vehicle sources in Baltimore City",
    ylab="PM2.5 Emission (tons)",
    xlab="Years",
    names = c("1999", "2002", "2005", "2008")
  )
  
  dev.print(png, file = "plot5.PNG"
  , width = 700, height = 480
  )
  dev.off()
}