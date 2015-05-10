Abstrakt{-}
========


Abstract{-}
========

The computational complexity of radiation schemes in NWP models
precludes full radiative transfer calculations in every time step
and every grid point of the model. Traditionally, models resort to calling
a radiation scheme on a reduced temporal or spatial resolution, optionally
interpolating resulting fluxes for the change in temperature profile
and the solar zenith angle. As a result, the variability of cloud cover is
neglected, leading to a considerable error. In the shortwave spectrum,
relatively slowly changing gaseous optical properties are one of the most
expensive parts to calculate. We propose a modification to the shortwave solver
of the ACRANEB2 broadband radiation scheme to interpolate gaseous optical
thickness of layers with respect to the solar zenith angle within
a chosen intermittency period, while still accounting for cloudiness
by recalculating fluxes via the adding method in every model time step.
In this work we use a single column model to study the dependence
of shortwave gaseous optical thickness on the solar zenith angle,
we show that this dependence can be approximated with good accuracy,
implement this approximation in the ACRANEB2 radiation scheme
and assess the impact on accuracy of heating rates and model run time
in 24-h simulations of the limited-area NWP model ALADIN. We show that
the modification results in time saving of up to 4\ % of total model run time
and incur error on shortwave heating rates up to ±0.4 K/day at noon (90\ % CI)
and 0.06 K/day (MAE) over the whole domain and time period,
and that both performance and accuracy scale with the length of the
intermittency period. This relationship is summarised in
a cost vs. accuracy comparison, giving potential users a guide on choosing
the optimal intermittency period in their circumstances. The proposed
modification is now in operational use of the ACRANEB2 radiation scheme.

**Keywords:** broadband radiation scheme, radiative transfer,
gaseous optical thickness, temporal subsampling, shortwave intermittency
