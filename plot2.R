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

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

baltimore <- subset(NEI, NEI$fips == "24510")

totalBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

png("Plot2.png", width = 720, height = 480)


plot(totalBaltimore$year, totalBaltimore$Emissions, type = "o", 
     main = expression("Total Baltimore" ~ PM[2.5] ~ "Emissions"), 
     xlab = "Year", ylab = expression("Total Baltimore "~ PM[2.5] ~ "Emissions"), col = "steelblue3")
dev.off()
