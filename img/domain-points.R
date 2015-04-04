#!/usr/bin/Rscript

library(RNetCDF)
library(maptools)
library(maps)
library(methods)
#library(geomapdata)

filename <- '../analysis/radiation-E194-24h.nc'

nc <- open.nc(filename)

longitude <- var.get.nc(nc, 'longitude')
latitude <- var.get.nc(nc, 'latitude')

proj4string <- CRS("+proj=longlat")
world <- readShapePoly("natural-earth/ne_50m_land/ne_50m_land.shp", proj4string=proj4string)
countries <- readShapePoly("natural-earth/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp", proj4string=proj4string)

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
