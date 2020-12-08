## This file contains the Coursera's Exploratory Data Analysis 2nd Course Project's 6th script with the question and the answer.

## Question: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

## Unzipping the files 
summarySCC <- readRDS(unzip("exdata_data_NEI_data.zip", "summarySCC_PM25.rds"))
sourceCC <- readRDS(unzip("exdata_data_NEI_data.zip", "Source_Classification_Code.rds"))

## Looking for the answer in the data sets
sourceCC_Vehicle <- sourceCC[grepl("[Vv]ehicle", sourceCC$SCC.Level.Two, ignore.case = TRUE),]
summarySCC_Total_Em_Baltimore_LA_Vehicle <- summarySCC %>% 
  filter(fips == "24510" | fips == "06037") %>%
  select(SCC, fips, Emissions, year) %>%
  inner_join(sourceCC_Vehicle, by = "SCC") %>%
  group_by(year, fips) %>%
  summarise(Total_Em_Baltimore_LA_Vehicle = sum(Emissions, na.rm = TRUE)) %>%
  select(Total_Em_Baltimore_LA_Vehicle, year, fips)
summarySCC_Total_Em_Baltimore_LA_Vehicle

## Converting county and city names
summarySCC_Total_Em_Baltimore_LA_Vehicle$fips <- gsub("24510", "Baltimore City", summarySCC_Total_Em_Baltimore_LA_Vehicle$fips)
summarySCC_Total_Em_Baltimore_LA_Vehicle$fips <- gsub("06037", "Los Angeles County", summarySCC_Total_Em_Baltimore_LA_Vehicle$fips)

summarySCC_Total_Em_Baltimore_LA_Vehicle


## Making a plot and saving to a PNG file
g <- ggplot(summarySCC_Total_Em_Baltimore_LA_Vehicle, aes(factor(year), Total_Em_Baltimore_LA_Vehicle)) + 
  geom_bar(stat = "identity", fill = c("darkgreen", "darkgreen", "darkgreen", "darkgreen", "yellow3", "yellow3", "yellow3", "yellow3")) + 
  facet_grid(. ~ fips) +
  labs(x = "Year", y = "Total Emissions of PM2.5 in tons from motor vehicles", title = "Total Emissions of PM2.5 in tons \nfrom motor vehicles  \nin Baltimore City and \nin Los Angeles County (1999-2008)", ylim = c(0, 8000)) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("plot6.png")
print(g)

## Answer: The emissions of PM2.5 from motor vehicles decreased in Baltimore City but increased in Los Angeles County from 1999 to 2008.
## Looking for the place where the change of emissions is greater.
BA_1999 <- summarySCC_Total_Em_Baltimore_LA_Vehicle %>% 
  filter(fips == "Baltimore City" & year == 1999)
BA_2008 <- summarySCC_Total_Em_Baltimore_LA_Vehicle %>% 
  filter(fips == "Baltimore City" & year == 2008)
BA_Change <- BA_1999$Total_Em_Baltimore_LA_Vehicle - BA_2008$Total_Em_Baltimore_LA_Vehicle

LA_1999 <- summarySCC_Total_Em_Baltimore_LA_Vehicle %>% 
  filter(fips == "Los Angeles County" & year == 1999)
LA_2008 <- summarySCC_Total_Em_Baltimore_LA_Vehicle %>% 
  filter(fips == "Los Angeles County" & year == 2008)
LA_Change <- LA_2008$Total_Em_Baltimore_LA_Vehicle - LA_1999$Total_Em_Baltimore_LA_Vehicle

if (BA_Change > LA_Change) {
  print("The change of total emissions of PM2.5 from 1999 to 2008 is greater in Baltimore City than in Los Angeles County.")
} else {
  print("The change of total emissions of PM2.5 from 1999 to 2008 is greater in Los Angeles County than in Baltimore City.")
}

## Answer: The change of total emissions of PM2.5 from 1999 to 2008 is greater in Los Angeles County than in Baltimore City.

