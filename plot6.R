# Exploratory Data Analysis: Week4 Project2
# Mohsen Azimi, Aug, 2020


# Load libraries
library(ggplot2)
library(RColorBrewer)

# Download and read the air_pollution data
filename <- "data.zip"

if (!file.exists(filename)){
  dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(dataurl, filename, method="curl")
}  

if (!file.exists("Source_Classification_Code.rds")) { 
  unzip(filename) 
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
}


# Check data
str(NEI)
str(SCC)

# 6. Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, 
# California (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

baltLosAngelesMotors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
baltLosAngelesMotorsAGG <- aggregate(Emissions ~ year + fips, baltLosAngelesMotors, sum)

png("Plot6.png", width = 720, height = 480)

ggplot(baltLosAngelesMotorsAGG, aes(year, Emissions, col = fips)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Baltimore and Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions")) +
  labs(x = "Year", y = expression(~PM[2.5]~ "Motor Vehicle Emissions") ) +
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
  theme(legend.title = element_text(face = "bold"))
dev.off()
