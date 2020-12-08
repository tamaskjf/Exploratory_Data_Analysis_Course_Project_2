## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 1st script with the question and the answer.

## Question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
totEm <- summarySCC %>% 
  select(Emissions, year) %>% 
  group_by(year) %>% 
  summarise(Total_Em = sum(Emissions, na.rm = TRUE))
totEm

## Making a plot and saving to a PNG file
barplot(Total_Em/10^6 ~ year, data = totEm, xlab = "Year", ylab = "Total Emissions of PM2.5 in million tons in the United States", main = "Total Emissions of PM2.5 in the United States (1999-2008)", col = "darkblue", ylim = c(0,8))
dev.copy(png, filename = "plot1.png")
dev.off()

## Answer: The total emissions of PM2.5 decreased in the United States from 1999 to 2008.
