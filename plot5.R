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

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

baltimoreMotor <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
baltimoreMotorAGG <- aggregate(Emissions ~ year, baltimoreMotor, sum)

png("Plot5.png", width = 720, height = 480)

ggplot(baltimoreMotorAGG, aes(year, Emissions)) +
  geom_line(col = "steelblue3") +
  geom_point(col = "steelblue3") +
  ggtitle(expression("Baltimore " ~ PM[2.5] ~ "Motor Vehicle Emissions")) +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))
dev.off()
