#!/usr/bin/env Rscript
#
# Plot ozone absorption from Serdyuchenko data.
#

O3_AMOUNT <- 300  # dobson units.
XLIM <- c(220, 1000)  # nm.
YLIM <- c(0, 0.7)  # W/nm.
S0 <- 1361  # W/m2 (solar constant).

# O3 optical depth for amount in dobson units and cross-section sigma in cm2.
optdepth <- function(amount, sigma) {
	amount*2.69e16*sigma
}

solar <- read.table('ln840', skip=2, nrow=408, col.names=c('v', 'w', 'w2'))
o3 <- read.table('serdyuchenkogorshelev5digits.dat', skip=45)
solar$v <- solar$v*1000  # um -> nm.

o3$v <- o3$V1  # nm.
o3$sigma <- o3$V6  # cm2 (temperature 253 K).

ranges <- head(solar$v, -1) - tail(solar$v, -1)

# Approx. - ln840 does not span entire spectrum.
power <- S0*solar$w[-1]/ranges

power_fn <- approxfun(solar$v[-1], power)

absorption <- (1-exp(-optdepth(O3_AMOUNT, o3$sigma)))*power_fn(o3$v)

cairo_pdf('ozone-absorption.pdf', 14, 8)

par(cex=1.5)
par(mar=c(4,4,4,4))
plot(NULL,
    type='n',
    xlim=XLIM,
    ylim=YLIM,
    xlab='',
    ylab='',
    xaxt='n',
    yaxt='n'
)

rect(240, YLIM[1]-1, 310, YLIM[2]+1, col='#f3f3f3', border=NA)  # Hartley.
rect(310, YLIM[1]-1, 340, YLIM[2]+1, col='#dddddd', border=NA)  # Huggins.
rect(450, YLIM[1]-1, 750, YLIM[2]+1, col='#f3f3f3', border=NA)  # Chappuis.

par(new=TRUE)
plot(o3$v, absorption,
    type='l',
    xlim=XLIM,
    ylim=YLIM,
    xlab='Wavelength (nm)',
    ylab='Absorbed radiation (W/nm)',
    xaxp=c(200, 1000, 8),
    col='#d40000',
    lwd=2
)
title('Absorption by 300 DU of O3, S0 = 1361 W/m², T = 253 K')

text(277, 0.71, 'Hartley')
text(350, 0.67, 'Huggins')
text(600, 0.71, 'Chappuis')

#plot(o3$v, o3$sigma, 'l', xlim=XLIM, log='y', xlab='Wavelength (nm)', ylab='Absorption cross section (cm²)')

par(new=TRUE)
plot(o3$v, o3$sigma,
    type='l',
    xlim=XLIM,
    log='y',
    xlab='',
    ylab='',
    yaxt='n',
    col='#0169c9',
    lwd=2
)
axis(4)
mtext('Absorption cross section (cm²)',side=4,line=3, cex=1.5)

dev.off()
