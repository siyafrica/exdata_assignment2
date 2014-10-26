#First I set the working directory
setwd("exdata_data_NEI_data")

#Then I download the data into R objects
PM_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds", header=T)
SRC_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#comparing vehicle emissions in Baltimore to vehicle emissions in LA
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

#load the ggplot library
library(ggplot2)

ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

#Save as PNG
png(filename="plot6.png", width=449, height=380, units="px")