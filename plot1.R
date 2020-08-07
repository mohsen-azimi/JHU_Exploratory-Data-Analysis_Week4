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

# 1. Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008?

totalNEI <- aggregate(Emissions ~ year, NEI, sum)

png("Plot1.png", width = 720, height = 480)

plot(totalNEI$year, totalNEI$Emissions, type = "o", col = "steelblue3", 
     main = expression("Total "~ PM[2.5]~ "Emissions in US"), 
     ylab = expression("Total "~   PM[2.5] ~ "Emissions"), xlab = "Year")
dev.off()
