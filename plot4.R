setwd("exdata_data_NEI_data")

PM_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds", header=T)
SRC_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

combustionData <- grepl("comb", SRC_data$SCC.Level.One, ignore.case=TRUE)
coalData <- grepl("coal", SRC_data$SCC.Level.Four, ignore.case=TRUE)
coalCombustion <- (combustionData & coalData)
combustionSCC <- SRC_data[coalCombustion,]$SCC
combustionNEI <- PM_data[PM_data$SCC %in% combustionSCC,]

library(ggplot2)

ggp <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

png(filename="plot4.png", width=449, height=380, units="px")