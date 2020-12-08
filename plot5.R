## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 5th script with the question and the answer.

## Question: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
sourceCC_Vehicle <- sourceCC[grepl("[Vv]ehicle", sourceCC$SCC.Level.Two, ignore.case = TRUE),]
summarySCC_Total_Em_Baltimore_Vehicle <- summarySCC %>% 
  filter(fips == "24510") %>% 
  select(SCC, fips, Emissions, year) %>%
  inner_join(sourceCC_Vehicle, by = "SCC") %>%
  group_by(year) %>%
  summarise(Total_Em_Baltimore_Vehicle = sum(Emissions, na.rm = TRUE))
summarySCC_Total_Em_Baltimore_Vehicle

## Making a plot and saving to a PNG file
g <- ggplot(summarySCC_Total_Em_Baltimore_Vehicle, aes(factor(year), Total_Em_Baltimore_Vehicle)) + 
  geom_bar(stat = "identity", fill = "darkgreen") + 
  labs(x = "Year", y = "Total Emissions of PM2.5 in tons from motor vehicles", title = "Total Emissions of PM2.5 in tons from motor vehicles  \nin Baltimore City (1999-2008)") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("plot5.png")
print(g)

## Answer: The emissions of PM2.5 from motor vehicles decreased in Baltimore City from 1999 to 2008.
