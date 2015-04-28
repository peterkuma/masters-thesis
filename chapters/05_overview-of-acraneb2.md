Overview of the Radiation Scheme ACRANEB2
=========================================

ACRANEB2 [@geleyn1979;@ritter1992;@geleyn2005;@masek2014] is a broadband
radiation scheme
developed as an alternative to k-distribution radiation schemes.
k-distribution schemes, in particular RRTM [@mlawer1997],
are currently one of the most popular methods of
solving the radiative transfer equation in NWP models,
thanks to their superior properties to narrow-band models. 
Their computation complexity, however,
precludes frequent recalculation of fluxes,
necessitating either reduced temporal or spatial precision.
As a result, changing cloud cover is not resolved with enough accuracy
as one might wish.
The bradband approach in ACRANEB2 allows for computational intermittency in
both shortwave and longwave parts of the spectrum by
decoupling quickly changing cloud optical depths from slowly
changing gaseous optical depths. This makes calling the radiation scheme
at every model time step feasible,
responding rapidly to the development of cloud cover.

We can characterise the ACRANEB2 scheme by the choices of methods
and approximations:

- Horizontally homogeneous (1D)
- $\delta$-two stream approximation
- Broadband model based (two bands: shortwave and longwave),
  with modified Malkmus band model transmission approximation
- Curtis-Godson approximation of inhomegeneous path transmission
- Adding method for flux computation to account for multiple scattering
  in shortwave and longwave spectrum
- Computational intermittency in longwave and shortwave spectrum

ACRANEB2 is currently available as an optional radiation scheme
in the NWP model ALADIN of the RC LACE[^rc-lace] community.

[^rc-lace]: Regional Cooperation for Limited Area modeling in Central Europe
(\url{http://www.rclace.eu/}).

Operation Overview
------------------

The ACRANEB2 scheme performs calculations independently for every
column in the model grid[^vectorisation].
Vertically, the atmosphere is split into layers, on which the computation
is discretised. In the ALADIN model, layers are defined in hybrid
_eta cooridates_, transitioning smoothly from
$\sigma$ coordinates near the surface
to pressure coordinates in the free atmosphere. Therefore, boundary layers
follow the ground, while upper layers follow isobaric surfaces.
Apart from an NWP model, ACRANEB2 can be run in isolation inside a
single column model. This is useful mostly for diagnostic purposes.

[^vectorisation]: Thugh in parallel, in order to allow for vectorisation.

### Input and Output

The input to the radiation scheme consists of:

* Pressure profile (definition of layers)
* Temperature profile
* Concentration of gases
  (water vapour, $\mathrm{O_3}$, $\mathrm{CO_2+}$ composite)
* Cloud fraction and cloud water/ice content
* Aerosol fraction and properties
* Surface temperature, albedo and emissivity
 Solar constant and the solar zenith angle

The output of the scheme are shortwave and longwave fluxes at layer interfaces,
from which the heating rate of layers can be calculated by the NWP model.

### Broadband Regions

The ACRANEB2 scheme operates in two spectral regions, matching closely the
common distinction between shortwave in longwave spectrum
(Sec.\ \ref{sec:shortwave-and-longwave-spectrum}):

* Shortwave: $245\ \mathrm{nm}$ – $4.642\ \mathrm{\mu m}$
* Longwave: $4.642\ \mathrm{\mu m}$ – $105.000\ \mathrm{\mu m}$

In the shortwave spectrum, there is a single source of radiation (the Sun),
whereas in the longwave spectrum, the surface and every layer is a source
of radiation
through thermal emission, but this complexity is somewhat reduced by the fact
that scattering of longwave radiation by gases in the atmosphere is weak enough
to be neglected, although scattering of longwave radiation by clouds and
aerosols still needs to be taken into account.

### General Principle of Operation

The general operation of the scheme can be summarised as follows:

1. Optical thickness and transmittance/reflectance coefficients of layers are
calculated. These are due to gases, clouds and aerosols. The resulting
layer coefficients are a weighted sum of layer coefficients for the particular
processes, weighted by optical thickness [@masek2014]:

    \begin{align}
    \alpha_i = \frac{1}{\tau}\sum_j \alpha_{i,j}\tau_j, \quad \tau = \sum_j \tau_j
    \end{align}

2. Integral layer coefficients $a_1, ..., a_4$ are calculated from
$\alpha_1, ..., \alpha_4$.

3. Fluxes are calculated using the adding method, taking the integral layer
coefficients as an input.

    **Longwave:** The adding method is performed in total five times with
    different choices of ‘idealised’ optical thickess, i.e. thickness assuming
    radiation exchanged with the surface, space, or neighouring layers (resp.).

Gaseous Transmission
--------------------

### Representation of Gases in ACRANEB2

ACRANEB2 contain representation of all atmospheric gases which contribute
significantly to the radiative energy budget in the shortwave and longwave
spectrum:

* Water vapour
* $\mathrm{O_3}$
* ‘CO2+’ ($\mathrm{CO_2}$, $\mathrm{CH_4}$,
  $\mathrm{N_2O}$, $\mathrm{O_2}$)

where $\mathrm{CO_2}$, $\mathrm{CH_4}$, $\mathrm{N_2O}$ and $\mathrm{O_2}$
are treated as a single composite gas
(‘CO2+’), because they are well-mixed, and their concentration in the atmosphere
is relatively constant[^gases-concentration].

[^gases-concentration]: This is not neccessrily true for all conditions,
because some of these gases have sources near the surface, e.g. CO~2~
is released by vegetation and exhibits both spatial and seasonal variability.
Nevertheless, this simplification is justified, because the impact on
atmospheric heating rate is small.


### Modified Malkmus Model

The radiation scheme depends on the ability to calculate gaseous optical
paths between arbitrary layers. Broadband optical paths are approximated by a
*modified Malkmus model*. The scheme uses the narrow-band Malkmus band model
as its bases, but adding additional parameters in order to account for
secondary saturation and Voigt line shape, and increase accuracy over a range
of common atmospheric conditions (temperature and pressure).

The modified Malkmus band model is defined as follows [@masek2014]:

\begin{align}
\tau_\mathrm{I} &= \frac{a}{2b}(\sqrt{1 + X(B,Z) + 4bu} - 1)\nonumber\\
\tau_\mathrm{II} &= \frac{\tau_\mathrm{crit}}{\alpha}\left(
  \left(1 + \frac{\tau_\mathrm{M}}{\tau_\mathrm{crit}}\right)^\alpha - 1
\right)\\
\tau_\mathrm{III} &= \tau_\mathrm{II}\max\left(0,
  P_{00}(T) +
  \frac{\tau_\mathrm{II}}{\tau_\mathrm{II} + D}
  \sum_{j = 0}^5 P_j(T)(\ln\tau_\mathrm{II})^j
\right)\\
\tau_\mathrm{gas} &= \tau_\mathrm{III}\max\left(0,
  1 + \frac{Q(p)}{1 + \tau_\mathrm{III}}
\right)
\end{align}

where:

- $\tau_\mathrm{I}$ is the narrow-band Malkmus model
\eqref{eq:malkmus-model} with an additional
term $X(B,Z)$, $B = 4bu\alpha_L/\alpha_D$, $Z = \alpha_D/\alpha_L$,
in order to account for Doppler broadening of line shape [@geleyn2005].

- $\tau_\mathrm{II}$ is an expression to modify the asymptotic power behaviour 
  of $\tau_\mathrm{I}$ with respect to $u$ to $u^{\alpha/2}$.

- $\tau_\mathrm{III}$ and $\tau_\mathrm{gas}$ are secondary corrective fits,
  in order to obtain greater accuracy in heating rates. $P$ and $Q$ are
  second order polynomials in temperature and pressure (resp.).

The final formula $\tau_\mathrm{gas}$ involves 33 parameters,
which need to be fitted for a broad range of atmospheric conditions
to a reference model. The reference model is a narrow-band model with
408 bands. Reference broadband optical paths are calculated for a set of
$(u, p, T)$ combinations by a
weighted average of the narrow-band optical paths, weighted by the spectral
composition of the incoming solar flux.

Solving the RTE
---------------

The solution for broadband flux densities at layer interfaces is found by
multiple passes of the adding method outlined in the previous chapter.
The adding method allows for only single absorption and scattering coefficient
to be specified per layer.
While this is sufficient for monochromatic calculations when the absorption
and scattering coefficients are independent from the flux density,
in broadband calculations the power distribution of the flux needs to be
taken into account. This is however not possible when fluxes combine
contributions from multiple sources, with radiation having traversed
different paths through the atmosphere.

One solution to the problem would be to carry out the adding method for every
radiation source independently, and summing up the resulting fluxes
(which can be done thank to linearity of the RTE). The power distribution
of a broadband flux at a layer interface can then be known, because it is
determined by
the power distribution of the emitting source and the extinction along the path
between the source and the layer. To be precise, the path traversed by radiation
between the source and the layer is not known with full accuracy, because
apart from the direct path, a fraction of the radiation can be scattered
multiple times, taking a longer path before arriving at the layer.

While the method outlined above is feasible and relatively accurate, it is too
computationally demanding to be performed at every time step, because the
adding method would have to be repeated for each layer in the thermal spectrum
(every layer is a source of radiation). The number of passes can be reduced
when we consider the net exchange rate formulation:

i.e. when we compute the flux divergence R_k by the adding method, it is
equal to the sum of CTS, EWS and EBL terms. For a suitable choice of sources,

Longwave Solution
-----------------

In the longwave spectrum, there are many sources of
radiation: the Earth's surface and each atmospheric layer. This fact
makes the situation more complicated than in the shortwave spectrum,
as the broadband optical thickness of layers depends on the path travelled by
radiation, which is ambiguous. The adding method can accomodate only a
single choice of optical thickness per layer. However, it is possible to
overcome this problem with improved accuracy
(over making a single arbitrary choice of optical thickness)
by repeating the adding method
with different choices of optical thickness and combining the results.

Firstly, we should observe that most of the radiation is exchanged with
space by cooling to space (CTS). Second to that, significant amount of radiation
is exchanged with surface (EWS). In the third place, radiation is exchanged
between neighbouring layers and layers further away (EBL).

### Simple Net Exchange Rate Formulation

Consider the following combination of fluxes obtained by the adding method
with different choices of optical thickness and temperature profile:

\begin{align}
\mathbf{F} = \mathbf{F}_{0} + (\mathbf{F}_\mathsf{CTS} - \mathbf{F}_{0,\mathsf{CTS}}) + (\mathbf{F}_\mathsf{EWS} - \mathbf{F}_{0,\mathsf{EWS}})
\end{align}

where $\mathbf{F}$ is a vector of fluxes at all layer interfaces, and:

- $\mathbf{F}_0$ is a vector of fluxes for the real temperature profile
and optical thickness of each layer chosen to be the minimum of
optical thickness as viewed from space
and optical thickness as viewed the surface, i.e.
$\tau_i = \min(\tau_{i,\mathsf{surface}}, \tau_{i,\mathsf{space}})$.

- $\mathbf{F}_\mathsf{CTS}$ is obtained from $\mathbf{F}_\mathsf{CTS}'$,
which is a vector of fluxes for a temperature profile in which the surface
and all layers
have unit temperature and space has temperature of 0\ K. 
Optical thickness of layers is chosen as viewed from space.
$\mathbf{F}_\mathsf{CTS}$ is calculated from
$\mathbf{F}_\mathsf{CTS}'$ in such a way that fluxes are turned into NER exchanges,
each multiplied by the real thermal emission ($\sigma T^4$)
of the respective layer, and turned back into fluxes.

- $\mathbf{F}_\mathsf{EWS}$ is obtained from $\mathbf{F}_\mathsf{EWS}'$,
which is a vector of fluxes for a temperature profile
in which all layers and space
have temperature of 0\ K and surface has temperature of unity. Optical thickness
of layers is chosen as viewed from the surface.
$\mathbf{F}_\mathsf{EWS}$ is calculated from
$\mathbf{F}_\mathsf{EWS}'$ in such a way that fluxes are turned into NER exchanges,
each multiplied by the real thermal emission ($\sigma T^4$)
of the respective layer, and turned back into fluxes.

- $\mathbf{F}_{0,\mathsf{CTS}}$ is obtained from $\mathbf{F}_{0,\mathsf{CTS}}'$,
which is a vector of fluxes for a temperature profile as in
$\mathbf{F}_\mathsf{CTS}$ and optical thickness as in $\mathbf{F}_0$.
$\mathbf{F}_{0,\mathsf{CTS}}$ is calculated from $\mathbf{F}_{0,\mathsf{CTS}}'$
by multiplying exchanges by real emission of layers as in
$\mathbf{F}_\mathsf{CTS}$.

- $\mathbf{F}_{0,\mathsf{EWS}}$ is obtained from $\mathbf{F}_{0,\mathsf{EWS}}$,
which is a vector of fluxes for a temperature profile as in
$\mathbf{F}_\mathsf{EWS}$ and optical thickness as in $\mathbf{F}_0$.
$\mathbf{F}_{0,\mathsf{EWS}}$ is calculated from $\mathbf{F}_{0,\mathsf{EWS}}'$
by multiplying exchanges by real emission of layers as in
$\mathbf{F}_\mathsf{EWS}$.

Here, we used the 1:1 correspondence between the flux and NER representations.
This seemingly complicated combination has a simple purpose: to remove
CTS and EWS exchanges from $\mathbf{F}_0$ and replace them with CTS and EBW
exchanges calculated with a more suitable choice of optical thickness.
$\mathbf{F}_{0,\mathsf{CTS}}$ and $\mathbf{F}_{0,\mathsf{EWS}}$
are the terms which remove
the CTS and EWS exchanges from $\mathbf{F}_0$, and $\mathbf{F}_\mathsf{CTS}$
and $\mathbf{F}_\mathsf{EWS}$ are the ‘replacements’ with the more suitable
choices of optical thickness.

The ‘simple’ formulation described here was used in a previous version of
ACRANEB, and has been superseded by an extended formulation
with a greater accuracy (see below). The choice of
$\tau_i = \min(\tau_{i,\mathsf{surface}}, \tau_{i,\mathsf{space}})$
in $\mathbf{F}_0$ is pragmatic: it minimises exchanges between layers,
which is assumed to lead to a better model stability
(J. Mašek, personal communication, November 13, 2013).

### Net Exchange Rate Formulation with ‘Bracketing’

The formulation outlined in the previous section still does not represent
exchanges between layers accurately. Especially, optical thickness
used in the calculation of $\mathbf{F}_0$ is an extreme case. 
An improved formulation takes into the account the fact that optical thickness
in EBL (exchange between layers) terms should be between two extreme values:

\begin{align}
\mathbf{F} &= (1 - \alpha)(\mathbf{F}_1 - \mathbf{F}_{1,\mathsf{CTS}} - \mathbf{F}_{1,\mathsf{EWS}}) +
\alpha(\mathbf{F}_2 - \mathbf{F}_{2,\mathsf{CTS}} - \mathbf{F}_{2,\mathsf{EWS}}) +\nonumber\\
&+ \mathbf{F}_\mathsf{CTS} + \mathbf{F}_\mathsf{EWS}
\end{align}

where:

- $\mathbf{F}_1$ is a vector of fluxes  for the real temperature profile
and optical thickness of each layer chosen to be the *minimum* of
optical thickness as viewed from space
and optical thickness as viewed the surface, i.e.
$\tau_i = \min(\tau_{i,\mathsf{surface}}, \tau_{i,\mathsf{space}})$.

- $\mathbf{F}_2$ is a vector of fluxes  for the real temperature profile
and optical thickness of each layer chosen to be the *maximum* of
optical thickness as viewed from space
and optical thickness as viewed the surface, i.e.
$\tau_i = \max(\tau_{i,\mathsf{surface}}, \tau_{i,\mathsf{space}})$.

- $\mathbf{F}_{1,\mathsf{CTS}}$ and $\mathbf{F}_{1,\mathsf{EWS}}$
are obtained in analogy to
$\mathbf{F}_{0,\mathsf{CTS}}$ and $\mathbf{F}_{0,\mathsf{EWS}}$ (resp.)
of the ‘simple’ NER formulation, but with
optical thickness as in $\mathbf{F}_1$.

- $\mathbf{F}_{2,\mathsf{CTS}}$ and $\mathbf{F}_{2,\mathsf{EWS}}$
are obtained in analogy to
$\mathbf{F}_{0,\mathsf{CTS}}$ and $\mathbf{F}_{0,\mathsf{EWS}}$ (resp.)
of the ‘simple’ NER formulation, but with
optical thickness as in $\mathbf{F}_2$.

- $\mathbf{F}_\mathsf{CTS}$ and $\mathbf{F}_\mathsf{EWS}$ are the same as 
in the ‘simple’ NER formulation.

The idea behind this complicated formulation is that
$\mathbf{F}_{1,\mathsf{CTS}}$ and $\mathbf{F}_{1,\mathsf{EWS}}$
remove CTS and EWS exchanges from $\mathbf{F}_1$,
\ $\mathbf{F}_{2,\mathsf{CTS}}$ and $\mathbf{F}_{2,\mathsf{EWS}}$
remove CTS and EWS exchanges from $\mathbf{F}_2$,
their linear combination is taken according to a real parameter $\alpha$,
and CTS and EWS exchanges are supplied by $\mathbf{F}_\mathsf{CTS}$ and
$\mathbf{F}_\mathsf{EWS}$.

