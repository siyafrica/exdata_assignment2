#First I set the working directory
setwd("exdata_data_NEI_data")

#Then I download the data into R objects
PM_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds", header=T)
SRC_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Now I subset the datasets that I need
vehicles <- grepl("vehicle", SRC_data$SCC.Level.Two, ignore.case=TRUE)
vehiclesSRC <- SRC_data[vehicles,]$SCC
vehiclesNEI <- PM_data[PM_data$SCC %in% vehiclesSCC,]

#I further subsetted the vehicle data for Baltimore
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

#Then I call the ggplot library
library(ggplot)

#Now I construct the ggplot plot
ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

#Then I save it as a PNG
png(filename="plot5.png", width=449, height=380, units="px")