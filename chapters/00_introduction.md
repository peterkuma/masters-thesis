Introduction
============

Radiation Schemes
-----------------

*Radiation schemes* (or *radiative transfer codes*) are modules of numerical
weather prediction (NWP) models and general circulation models (GCM)
responsible for calculation of radiation fluxes in the atmosphere and the ocean.
Fluxes are neccessary to quantify diabatic heating of atmospheric or oceanic
layers. Radiation schemes contribute significantly to the accuracy of weather
prediction, but also take a large fraction of model run time. Therefore,
improvements in performance are greatly desired.

Radiation schemes are considered to be a part of model ‘physics’,
i.e. a part of the model parametrising various phenomena not covered by the
model dynamical core
(implementing the momentum equations).
