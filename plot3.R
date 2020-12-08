## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 3rd script with the question and the answer.

## Question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
totEm_Baltimore_type <- summarySCC %>% 
  filter(fips == 24510) %>% 
  select(Emissions, year, type) %>% 
  group_by(year, type) %>% 
  summarise(Total_Em_Baltimore = sum(Emissions, na.rm = TRUE))
totEm_Baltimore_type

## Making a plot and saving to a PNG file
g <- ggplot(totEm_Baltimore_type, aes(x = factor(year), y = Total_Em_Baltimore, fill = type)) + 
  geom_bar(stat = "identity") +
  facet_grid (. ~ type) + 
  labs(x = "Year", y = "Total Emissions of PM2.5 in tons", title = "Total Emissions of PM2.5 in tons \nin Baltimore City by type (1999-2008)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("plot3.png")
print(g)


## Answer: Of the four type of total emissions of PM2.5 variables the NON-ROAD, the NONPOINT and ON-ROAD variables decreased, and the POINT variable increased in Baltimore City from 1999 to 2008.
