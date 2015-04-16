#!/usr/bin/env Rscript

h <- 6.62607e-34
c <- 2.998e8 # m/s.
k_B <- 1.38065e-23 # J/K.
sigma <- 5.6704e-8 # W/(m^2 K^4).

planck.function <- function(lambda, T) {
    2*h*c**2/(lambda**5*(exp(h*c/(k_B*lambda*T)) - 1))
}

cairo_pdf('shortwave-longwave.pdf', width=14.5/cm(1), height=6/cm(1))
par(mar=c(4,4,1,1))
par(cex=0.8, lwd=0.8)

lambda <- seq(0.1e-6, 100e-6, length.out=10000)

plot(
    lambda*1e6,
    lambda*planck.function(lambda, 6000)/(sigma*6000**4),
    type='l',
    log='x',
    xlab='Wavelength (𝜇m)',
    ylab='Planck\'s function (normalised)',
    col='#0169c9',
    lwd=1,
    ylim=c(0, 0.3)
)
polygon(
    c(
        min(lambda)*1e6,
        lambda*1e6,
        max(lambda)*1e6
        
    ),
    c(
        0,
        lambda*planck.function(lambda, 6000)/(sigma*6000**4),
        0
    ),
    col='#0169c920',
    border=NA,
)

lines(
    lambda*1e6,
    lambda*planck.function(lambda, 300)/(sigma*300**4),
    col='#d40000',
    lwd=1
)
polygon(
    c(
        min(lambda)*1e6,
        lambda*1e6,
        max(lambda)*1e6
    ),
    c(
        0,
        lambda*planck.function(lambda, 300)/(sigma*300**4),
        0
    ),
    col='#d4000020',
    border=NA
)

text(0.65, 0.1, '6000 K')
text(13, 0.1, '300 K')

abline(v=4.6, lty=2)

y <- 0.25
text(0.2, y, 'UV', pos=3)
arrows(0.100, y, 0.400, y, code=3, length=0.04, angle=30)
text(0.53, y, 'VIS', pos=3)
arrows(0.400, y, 0.700, y, code=3, length=0.04, angle=30)
text(2, y, 'Near IR', pos=3)
arrows(0.700, y, 4.6, y, code=3, length=0.04, angle=30)
text(15, y, 'Thermal IR', pos=3)
arrows(4.6, y, 50, y, code=3, length=0.04, angle=30)
text(72, y, 'Far IR', pos=3)
arrows(50, y, 100, y, code=3, length=0.04, angle=30)

dev.off()
