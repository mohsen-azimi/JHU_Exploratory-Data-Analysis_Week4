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

# 3. Of the four types of sources indicated by the \color{red}{\verb|type|}type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.?

baltimore <- subset(NEI, NEI$fips == "24510")
baltimoreType <- aggregate(Emissions ~ year + type, baltimore, sum)

png("Plot3.png", width = 720, height = 480)

ggplot(baltimoreType, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total Baltimore " ~ PM[2.5] ~ "Emissions")) +
  ylab(expression("Total Baltimore " ~ PM[2.5] ~ "Emissions")) +
  xlab("Year") +
  scale_colour_discrete(name = "Type") +
  theme(legend.title = element_text(face = "bold"))
dev.off()
