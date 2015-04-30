#!/usr/bin/Rscript

args <- commandArgs(TRUE)
if (length(args) != 2) {
    cat(sprintf('Usage: domain-points.R <file> <natural-earth>\n'))
    quit(status=1)
}
filename <- args[1]
natural.earth.dirname <- args[2]
land.filename <- sprintf('%s/ne_50m_land/ne_50m_land.shp', natural.earth.dirname)
countries.filename <- sprintf('%s/ne_50m_land/ne_50m_land.shp', natural.earth.dirname)

library(RNetCDF)
library(maptools)
library(maps)
library(methods)

nc <- open.nc(filename)

longitude <- var.get.nc(nc, 'longitude')
latitude <- var.get.nc(nc, 'latitude')

proj4string <- CRS("+proj=longlat")
world <- readShapePoly(land.filename, proj4string=proj4string)
countries <- readShapePoly(countries.filename, proj4string=proj4string)

cairo_pdf('domain-points.pdf', width=9/cm(1), height=8/cm(1))
par(mar=c(2,2,1,1))
par(cex=0.8, lwd=0.8)
plot(world,
    xlim=c(-3, 35),
    ylim=c(40, 55),
    axes=TRUE,
    col='#f3f3f3',
    lwd=0.1,
    lty=0,
    xpd=FALSE
)
plot(countries,
    add=TRUE,
    lwd=0.1,
    border='#bbbbbb'
)
points(longitude, latitude, cex=0.7, pch=20, col='#0169c9')
dev.off()
