#!/usr/bin/env Rscript

diffusivity.factor <- function(delta) {
    -log(integrate(function(mu) { 2*exp(-delta/mu)*mu }, 0, 1)$value)/delta
}

cairo_pdf('diffusivity-factor.pdf', width=8/cm(1), height=8/cm(1))
par(mar=c(4,4,1,1))

plot(
    delta <- seq(0,20,0.001),
    sapply(delta, diffusivity.factor),
    type='l',
    xlab='Optical thickness (1)',
    ylab='Diffusivity Factor (1)',
    col='#0169c9',
    lwd=2
)

dev.off()
