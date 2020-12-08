## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 2nd script with the question and the answer.

## Question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

library(dplyr)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
totEm_Baltimore <- summarySCC %>% filter(fips == 24510) %>% select(Emissions, year) %>% group_by(year) %>% summarise(Total_Em_Baltimore = sum(Emissions, na.rm = TRUE))
totEm_Baltimore

## Making a plot and saving to a PNG file
barplot(Total_Em_Baltimore ~ year, data = totEm_Baltimore, xlab = "Year", ylab = "Total Emissions of PM2.5 in tons in Baltimore City", main = "Total Emissions of PM2.5 in Baltimore City (1999-2008)", col = "darkgreen", ylim = c(0, 3500))
dev.copy(png, filename = "plot2.png")
dev.off()

## Answer: The total emissions of PM2.5 decreased in Baltimore City from 1999 to 2008.
