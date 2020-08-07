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

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008??

SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)

png("Plot4.png", width = 720, height = 480)

ggplot(totalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type") +
  theme(legend.title = element_text(face = "bold"))
dev.off()
