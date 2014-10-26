setwd("exdata_data_NEI_data")

PM_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds", header=T)
SRC_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

PM2_data <- PM_data[PM_data$fips == "24510", ]

agg_totals_PM2 <- aggregate(Emissions ~ year, PM2_data, sum)

barplot(
        agg_totals_PM2$Emissions,
        names.arg=agg_totals_PM2$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From All Baltimore City Sources"
)

png(filename="plot2.png", width=480, height=480, units="px")