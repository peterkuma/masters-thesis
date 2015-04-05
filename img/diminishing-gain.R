#!/usr/bin/env Rscript

q <- 0.5
q_prime <- q*0.5

tau <- function(k) {
    1 - q*(1 - q_prime/q)*(1 - 1/k)
}

cairo_pdf('diminishing-gain.pdf', width=8/cm(1), height=8/cm(1))
par(mar=c(4,4,1,1))
par(cex=0.8, lwd=0.8)

plot(
    k <- 1:20,
    tau(k),
    type='o',
    pch=20,
    ylim=c(0,1),
    col='#0169c9',
    lwd=1,
    xlab='Intermittence period (steps)',
    ylab='Relative time (1)'
)

abline(1 - (q - q_prime), 0,
    lty='dashed'
)

dev.off()
