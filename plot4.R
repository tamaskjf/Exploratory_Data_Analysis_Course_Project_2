## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 4th script with the question and the answer.

## Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(dplyr)
library(ggplot2)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
sourceCC_Comb_Coal <- sourceCC[grepl("[Cc]omb.*[Cc]oal", sourceCC$Short.Name, ignore.case = TRUE),]
str(sourceCC_Comb_Coal)
summarySCC_sourceCC_Comb_Coal <- inner_join(summarySCC, sourceCC_Comb_Coal, by = "SCC")

## Making a plot and saving to a PNG file
g <- ggplot(summarySCC_sourceCC_Comb_Coal, aes(factor(year), Emissions/10^6)) + 
  geom_bar(stat = "identity", fill = "darkblue") + 
  labs(x = "Year", y = "Total Emissions of PM2.5 in tons", title = "Total Coal Combustion-related Emissions of PM2.5 \n in tons in the United States (1999-2008)") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("plot4.png")
print(g)

## Answer: The coal combustion-related emissions of PM2.5 decreased in the United States from 1999 to 2008.
