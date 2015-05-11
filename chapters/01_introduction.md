Introduction{-}
============

*Radiation schemes* (or *radiative transfer codes*) are modules in numerical
weather prediction (NWP) models and general circulation models (GCM)
responsible for calculation of radiation fluxes in the atmosphere and the ocean.
Fluxes are necessary to quantify diabatic heating of atmospheric and oceanic
layers. Radiation schemes contribute significantly to the accuracy of NWP
models, but also take a large fraction of model run time. Due to the
computational complexity of the problem, numerous approximations have to be
made (most radically the *two-stream approximation*), but even then it is not
possible to perform full radiative transfer calculations in every domain point
and every time step in operational settings. Therefore, most models resort to
temporal or spatial subsampling of radiative transfer calculations.
In the most simple
implementation, fluxes calculated by the radiation scheme are kept constant
across multiple model time steps, or a single calculation is performed for
blocks of neighbouring domain points. More complex implementations
scale the resulting fluxes with respect to changes in temperature profile
and the solar zenith angle [@morcrette2008].
In such a case, the information about
temporal or spatial variability is not fully taken into account. The situation
is the most serious with cloud cover, which changes rapidly and can have
a paramount impact on radiative fluxes. In order to address this issue,
the radiation scheme ACRANEB2 was developed, whose aim is to decouple
calculation of optical thickness of layers due to gases from one due to
clouds and aerosols. The former (more expensive to compute)
can then be performed with reduced temporal frequency,
while the latter can be performed at every time step. The ACRANEB2
radiation scheme utilises only two spectral intervals: shortwave and longwave.
The implementation of temporal subsampling (‘intermittency’)
in the longwave spectrum had already been done,
while it was one of the objectives of this work to implement temporal
subsampling in the shortwave spectrum. Similar efforts with other
radiation schemes include ones of @manners2009 and @schomburg2012.


While in the longwave spectrum gaseous optical thickness can be assumed
constant over multiple time steps without a significant loss of accuracy,
in the shortwave spectrum it depends on the solar zenith angle, whose
change cannot be neglected. Therefore, one of the challenges was to find
a suitable interpolation method in order to account for this dependency.

In summary, the objectives of this work were:

1. Find and investigate a suitable time subsampling (‘intermittency’) method
in the shortwave band of the radiation scheme ACRANEB2.

2. Implement the shortwave intermittency method in the code of the scheme.

3. Determine the performance and accuracy of various
shortwave intermittency periods in the context of the
limited-area NWP model ALADIN.
