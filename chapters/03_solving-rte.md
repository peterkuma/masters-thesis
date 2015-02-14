Approximate Solutions of the Radiative Transfer Equation
========================================================

In order to make integration of the radiative transfer equation computationally
feasible, and number of approximations are commonly taken along each axis
of integration (spatial, zenithal/azimuthal, wavelength, time).

Plane Parallel Approximation
----------------------------

The atmopshere forms a thin envelope of the Earth with horizontal scales much
pronounced relative to vertical scales. Factors influencing radiative tranfer
include gasesous concentrations, clouds, air and surface temperature variation.
Perhaps with the exception of cumulus clouds, all of these change slowly in the
horizontal direction, and we can simplify the calculations if we treat them as
constant over relatively large areas. In NWP models, this is commonly done by
dividing the computational domain into a grid and applying _plane parallel
approximation_ within each grid cell. In plane parallel approximation, the
dependence of quantities on (x,y) coordinates is dropped, although dependence on
zenithal and azimuthal angles can still be taken into consideration (e.g. via
path length and diffusivity factor). Because plane parallel approximation leaves
convective cloud structures unresolved, it is necessary to parametrise their
influence by a special cloud overlap treatment.

Alternative to the plane parallel approximation is a full three-dimensional
treatment of radiation, generally performed by Monte Carlo simulation. This
is however too computationally expensive to be done in today NWP models.

### Layers

In the plane-parallel approximation the atmosphere is often
discretized into _layers_, in which quantities such as temperature or
gaseous concentrations are constant. Layer interfaces (boundaries) are
defined by fixed vertical coordinates, usually pressure levels.

In the following text we assume that layers are numbered from top to bottom by
integer number k, where $k = 1$ is the uppermost layer, and $k = N$ the layer
just above the surface. Some quantities, such as fluxes, need to be determined
on layer interfaces. The layer interface corresponding to the ToA will be numered
$k = 0$, increasing down to the atmopshere-surface interface $k = N$.

### 1-D Form of the Radiative Transfer Equation

The radiative tranfer equation can be written in one dimensional form by
defining $\mu = |\cos(\theta)|$, and noting that $\mathrm{ds} = \mathrm{d}z/\mu$:

$$
\mu \frac{\mathrm{d}I(\theta,\phi)}{\mathrm{d}z} =
    -\beta_\mathrm{e}I(\theta,\phi)
    + \beta_\mathrm{s} \int_{4\pi} I(\theta,\phi) p(\theta,\phi,\theta',\phi') \mathrm{d}\theta' \mathrm{d}{\phi}'
    + \beta_\mathrm{a} B(\phi,\theta)
$$

Delta-Two Stream Approximation
------------------------------

In the δ-two stream approximation radiance is assumed to be constant over
hemispheres, with the forward peak (from direct light sources) treated
seperately. Therefore, radiance is fully represented by two diffuse
flux densities (upward and downward) and flux density of parallel radiation.
The upward and downward diffuse flux densities will be denoted as $F_\uparrow$
and $F_\downarrow$, and flux density of parallel (solar) radiation as S.

The δ-two stream approximation is justified by the fact that the scattering
phase function of gases and atmospheric particles tends to be uniform with
direction, with the exception of the forward peak. In Reyleigh scattering regime
this holds to great accuracy, while in the Mie regime the approximation is
somewhat less sound.

### Diffusivity Factor

### RTE in Delta-Two Stream Approximation

The differential form of the RTE can be integrated over the azimuthal angle
and both hemispheres two give two simplified ordinary differenential equations
valid for the two-stream approximation.



Band Models
-----------

Radiatively active gases usually have many more absorption lines than can
be integrated over in NWP models in a time-effective manner.
A number of statistical approaches to this problem have been invented.
One well-established approach is _band models_, whereby
line strengths are given by a statistical distribution specified by a limited
number of parameters in each band (range of walengths). For suitably
chosen distributions, the integration can be done analytically, leading
to an expression for broadband transmissivity as a function of path length
and distribution parameters. Traditionally, the band size has to be small
enough that radiant power (Planck function) can be assumed constant
within the band. With some effort this restriction can be lifted, at the
cost of more complicating matters such as secondary saturation.

### Malkmus Model

One of the most popular _narrow-band_ models is the _Malkmus model_. It is
based on the assumption that there is a given number of randomly
distributed absorption lines in each band, and their stength has
probability density:

$$
p(S) = \frac{1}{S} e^{-S/S_0}
$$

where $S_0 = \int_0^\infty{Sp(S)dS}$ is the mean line strength.

Optical depth at wavenumber ν is the sum of contributions of all lines:

$$
\tau = ku = \sum_{n=0}^N S_i u f(\nu) = \sum_{n=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}
$$

and narrow-band transmissivity

$$
\mathcal{T} = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} e^{-\tau}d\nu
            = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} \exp\left(-\sum_{n=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}\right) d\nu
$$

The above expression is a random variable (because S~i~ and ν~i~ are random
variables). Therefore, we have to compute mean transmissivity to be useful:

$$
\bar{\mathcal{T}} = \int_\mathbf{S} \int_\mathbf{\nu} \mathcal{T} p(\mathbf{\nu})p(\mathbf{S}) d\mathbf{\nu}d{\mathbf{S}}
$$

where $\mathbf{S} = (S_1,...,S_N)$ and $\mathbf{\nu} = (\nu_1,...,\nu_N)$
are vectors of line strengths and line positions.
This integration can be performed analytically [see e.g. @zdunkowski2007],
leading to the _Malkmus formula_ for optical depth:

$$
\tau_M = -\frac{\pi\alpha}{2\delta}\left(\sqrt{1+\frac{4\bar{S}u}{\pi\alpha}} - 1\right)
$$

This formula can be adapted to the case of non-uniform line width α by comparing
two limiting cases of small and large mass paths to the weak and strong line
limits derived in Sec. ?. The formula is first written in terms of parameters
a and b:

$$
\tau_M = -\frac{a}{2b}\left(\sqrt{1+4bu} - 1\right)
$$

By making approximations for $4bu \ll 1$ and $4bu \gg 1$ match the
weak and strong line limits, one can show that

$$
a = \sum S_i
$$
$$
b = a^2/\left(\sum 2\sqrt{S_i\alpha_i})\right)^2
$$

### Curtis-Godson Approximation

The Malkmus formula has a number of drawbacks. One of the more serious is
that the line width α is assumed to be constant over the path. In reality,
we often need to compute transmissivity over large parts of the atmosphere,
where α varies with pressure and temperature due to line broadening. This
situation is handled by the _Curtis-Godson approximation_  for inhomogeous
atmospheres.

k-distribution Method
---------------------

Continuum
---------

### MT_CKD

Perhaps the most comprehensive model of continuum absorption is MT_CKD produced
by AER [@mlawer2012]. It includes continuum absorption by water vapor, nitrogen,
oxygen, carbon dioxide and ozone. The model uses a semi-empirical approach in
which theoretical imact line shape modified by a χ-function
is fitted by measured values.

Adding Method
-------------

The _adding method_ is a method of finding a solution to fluxes for given
optical depths and temperature of layers. The adding method assumes that the
plane parallel approximation, δ-two stream approximation and layer
discretization have been made.

A relationship between fluxes at the top and bottom interfaces of a layer
can be found from the δ-two-stream differential equations.

$$
\begin{pmatrix}
S_k\\
F^\downarrow_k\\
F^\uparrow_{k-1}
\end{pmatrix}
=
\begin{pmatrix}
a_1  &0    &0\\
a_2  &a_3  &a_4\\
a_5  &a_6  &a_7
\end{pmatrix}
\begin{pmatrix}
S_{k-1}\\
F^\downarrow_{k-1}\\
F^\uparrow_k    
\end{pmatrix}
$$

The equations for all layers can be consolidated into a system of linear
equations:

$$
\mathbb{A}\mathbf{F} = \mathbf{S}
$$

where $\mathbb{A}$ is a matrix of coefficients (layer transmissivities and
reflectivities), $\mathbf{F}$ is a vector of fluxes and $\mathbf{S}$ is a
vector of sources. This system can then be solved for $\mathbf{F}$, which
is the desired outcome of the adding method.

Net Exchange Rate
-----------------

Time Intermittence
------------------

Because the temporal variability of all quantities coming as an input 
to the RTE is not the same, it is convenient to avoid repeated computation
of certain results. E.g., the rate of change of cloudiness is much higher
than that of gas concentrations. Therefore, it is possible skip or linearise
the computation of gaseous transmission functions. Other intermediate
results may also be reused, depending on the actual implementation of the
solution.
