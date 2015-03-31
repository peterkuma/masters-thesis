#!/usr/bin/env Rscript

k <- 1
a <- 1
b <- 1
u <- seq(0, 1, 1e-3)

cairo_pdf('optical-saturation.pdf', width=21/c(1), height=8/c(1))
par(mfrow=c(1,2))
par(mar=c(4,4,1,1))
par(cex=2.5)

tau <- k*u
plot(u, tau,
    type='l',
    ylim=c(0,1),
    xlab=expression('Absorber amount (kg/m²)'),
    ylab=expression('Optical depth (1)'),
    lwd=4,
    col='#0169c9'
)

tau <- a/(2*b)*(sqrt(1 + 4*b*u) - 1)
plot(u, tau,
    type='l',
    ylim=c(0,1),
    xlab=expression('Absorber amount (kg/m²)'),
    ylab=expression('Optical depth (1)'),
    lwd=4,
    col='#0169c9'
)

dev.off()
