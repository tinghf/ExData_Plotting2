# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

plot6 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  motorVehicle <- subset(SCC, grepl("- On-Road ", as.character(EI.Sector)))
  sccs<-motorVehicle$SCC
  motorNEI<-subset(NEI, SCC %in% sccs)
  
  allEmissions<-aggregate(subset(motorNEI, fips=="24510" | fips=="06037")$Emissions, by=list(year = subset(motorNEI, fips=="24510" | fips=="06037")$year, fips = subset(motorNEI, fips=="24510" | fips=="06037")$fips), FUN=sum)
  allEmissions[allEmissions$fips %in% "24510", 2] <- "Baltimore"
  allEmissions[allEmissions$fips %in% "06037", 2] <- "California"
  colnames(allEmissions) <- c("Year", "City", "Emission")
  
  q <- qplot(x=Year, y=Emission, fill=City, data=allEmissions, geom="bar", stat="identity") +
    facet_wrap(~City, scales="free_y") +
    geom_text(aes(label=prettyNum(Emission, format="f", digits=5), vjust=-.2, fontface="bold")) +
    scale_x_continuous(limits=c(1997, 2010), breaks=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008)) +
    ylab("Total PM2.5 emission") +
    xlab("Year")
  print(q)
  
  dev.print(png, file = "plot6.PNG"
  , width = 700, height = 480
)
  dev.off()
}