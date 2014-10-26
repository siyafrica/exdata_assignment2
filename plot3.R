setwd("exdata_data_NEI_data")

PM_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds", header=T)
SRC_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

PM2_data <- PM_data[PM_data$fips == "24510", ]
library(ggplot2)

ggp <- ggplot(PM2_data,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

png(filename="plot3.png", width=449, height=380, units="px")