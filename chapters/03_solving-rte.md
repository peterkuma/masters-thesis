Approximate Solutions of the Radiative Transfer Equation
========================================================

In order to make solution of the radiative transfer equation computationally
feasible, and number of approximations are commonly taken in operational
radiation schemes.

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
dependence of quantities on (x,y) coordinates is dropped. Quantities
are therefore functions of a single spatial coordinate $z$, or an equivalent
vertical coordinate.

Alternative to the plane parallel approximation is a full three-dimensional
treatment of radiation, generally performed by Monte Carlo simulation. This
is however too computationally expensive to be done in today NWP models.

### Layers

In the plane-parallel approximation the atmosphere is often
discretised into _layers_, in which quantities such as temperature and
gaseous concentrations are constant. Layer interfaces (boundaries) are
defined by fixed vertical coordinates, usually pressure levels.

In the following text we assume that layers are numbered from top to bottom by
integer number k, where $k = 1$ is the uppermost layer, and $k = N$ the layer
just above the surface. Some quantities, such as fluxes, need to be determined
on layer interfaces. The layer interface corresponding to the top of the
atmopshere will be numered $k = 0$,
increasing down to the atmopshere-surface interface $k = N$.

### Radiative Transfer Equation in Plane Parallel Approximation

In the plane parallel approximation, the radiative transfer equation can
be expressed in terms of a single spatial coordinate $z$.
Defining $\mu \equiv |\cos(\theta)|$ and noting that
$\mathrm{ds} = \mathrm{d}z/\mu$, \eqref{eq:rte} transforms to:

\begin{align}
\mu \frac{\mathrm{d}I(\mathbf{\hat{\Omega}})}{\mathrm{d}z} =
    -\beta_\mathrm{e}I(\mathbf{\hat{\Omega}})
    + \beta_\mathrm{a} B(\mathbf{\hat{\Omega}})
    + \frac{\beta_\mathrm{s}}{4\pi}\int_{4\pi}
      p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
      I(\mathbf{\hat{\Omega}'})
      \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}'}
\end{align}

More conveniently, we can use *optical depth*
$\mathrm{d}\tau = -\beta_\mathrm{e}\mathrm{d}z$
as a verticalthe vertical coordinate, and normalize by $\beta_e$:

\begin{align}
\label{eq:plane-parallel-rte}
\mu \frac{\mathrm{d}I(\mathbf{\hat{\Omega}})}{\mathrm{d}\tau} =
    I(\mathbf{\hat{\Omega}})
    - (1 - \tilde{\omega}) B(\mathbf{\hat{\Omega}})
    - \frac{\tilde{\omega}}{4\pi}\int_{4\pi}
      p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
      I(\mathbf{\hat{\Omega}'})
      \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}'}
\end{align}

where $\tilde{\omega} \equiv \beta_\mathrm{s}/\beta_\mathrm{e}$ is the
*single scatter albedo*. This is the *radiative transfer equation
in plane parallel atmosphere*.

Delta-Two Stream Approximation
------------------------------

In the *delta-two stream approximation* radiance is assumed to be constant over
hemispheres, with the exception of a forward peak (if present) from direct
solar radiation. The forward peak is treated seperately in order to preserve
good accuracy, as direct radiation can be orders of magnitude greater than
diffuse radiation. There is no azimuthal or zenith dependence of diffuse
radiance, and the total radiance is the sum of diffuse and direct radiance:

\begin{align}
I &= I_\mathrm{diff} + I_\mathrm{dir}\\
I_\mathrm{diff}(\mu,\phi) &=
  \begin{dcases}
  I^\uparrow & \mu > 0\\
  I^\downarrow & \mu < 0
  \end{dcases}\\
I_\mathrm{dir} &= I_0
\end{align}

where $I^\uparrow$ and $I^\downarrow$ are upward and downward radiance,
and $I_0$ is solar radiance. $I^\uparrow$ and $I^\downarrow$ are functions
of position only. This allows integration over each hemisphere to be performed
analytically to get upward, downward and solar flux density:

\begin{align}
&F^\uparrow =
  \int_\uparrow I_\mathrm{diff}(\mathbf{\hat{\Omega}})\mathrm{d}\omega =
  \int_0^{2\pi}\int_0^1 I_\mathrm{diff}(\mu,\varphi) \mathrm{d}\mu \mathrm{d}\varphi =
  2\pi I^\uparrow\\
&F^\downarrow =
  \int_\downarrow I_\mathrm{diff}(\mathbf{\hat{\Omega}})\mathrm{d}\omega =
  2\pi I^\downarrow\\
&S = \int_{4\pi} I_\mathrm{dir}(\mathbf{\hat{\Omega}})\mathrm{d}\omega = 
  \int_\downarrow I_0(\mathbf{\hat{\Omega}})\mathrm{d}\omega
\end{align}

Therefore, radiance is fully represented by two diffuse
flux densities (upward and downward) and flux density of direct (solar)
radiation.
The upward and downward diffuse flux densities will be denoted as $F_\uparrow$
and $F_\downarrow$, and flux density of solar radiation as $S$. Here,
we assume that $S$ is coming from the Sun, and so always has a direction
somewhere in the bottom hemisphere.

The $\delta$-two stream approximation is justified by the fact that (1)
the solar radiation can be orders of magnitude greater that diffuse radiation
and (2) the scattering phase function of gases and atmospheric particles tends
to be uniform with direction, with the exception of a strong and narrow
forward peak.

<!-- In Reyleigh scattering regime
this holds to great accuracy, while in the Mie regime the approximation is
somewhat less sound. -->

### Radiative Transfer Equation of Direct Radiation

<!-- The scattering phase function
$p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})$
under normal conditions in the atmosphere has a very pronounced forward peak
(Figure\ ??). -->

Let us now consider the plane parallel radiative transfer equation
\eqref{eq:plane-parallel-rte}.
In our decomposition into diffuse and direct radiation this equation
now does not have a unique solution, as $I_\mathrm{diff}$ and $I_\mathrm{dir}$
overlap
at the angle of the direct radiation, and we cannot tell how much of the value
of the right hand side is alloted to the change in diffuse radiation
$\mathrm{d}I_\mathrm{diff}$ and direct radiation $\mathrm{d}I_\mathrm{dir}$
on the left hand side. Therefore, we postulate that the change in direct
radiation is only due to extinction of direct radiation and scattering of
direct radiation in the direction of the forward $\delta$ peak:

\begin{align}
\label{eq:rte-dir}
\mu\frac{\mathrm{d}I_\mathrm{dir}(\mathbf{\hat{\Omega}})}{\mathrm{d}\tau} =
  I_\mathrm{dir}(\mathbf{\hat{\Omega}}) -
  \frac{\tilde{\omega}}{4\pi}\int_{4\pi}
    p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
    I_\mathrm{dir}(\mathbf{\hat{\Omega}})
    \mathrm{d}\omega',\quad
    \mathbf{\hat{\Omega}} \in \delta
\end{align}

To simplify further, we define that the forward peak has the shape of
the Dirac $\delta$ function[^note]:

\begin{align}
I_\mathrm{dir}(\mathbf{\hat{\Omega}}) = S\delta(\mathbf{\hat{\Omega}} - \mathbf{\hat{\Omega}}_0)
\end{align}

[^note]: Even though in reality solar radiation is spread over a range of
directions.

and express the phase function approximately as:

\begin{align}
p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) \approx
  (1 - f)p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) +
  f\delta(\mathbf{\hat{\Omega}'}\cdot\mathbf{\hat{\Omega}} - 1)
\end{align}

where $p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})$
is the *$\delta$-scaled phase function*, and $f$ is the fraction
scattered in the direction of the forward peak, i.e. we approximate
the forward peak by an equivalent Dirac $\delta$ peak.

Integrating \eqref{eq:rte-dir} over all directions:

\begin{align}
\label{eq:rte-solar-raw}
\mu_0\frac{\mathrm{d}S}{\mathrm{d}\tau} = S - \tilde{\omega}fS =
  S(1 - \tilde{\omega}f)
\end{align}

which motivates us to introduce *delta scaling*
$\tau' \equiv \tau(1 - \tilde{\omega}f)$,
so that the radiative transfer equation for direct radiation now resembles
the Beer's law:

\begin{align}
\label{eq:rte-solar}
\mu_0 \frac{\mathrm{d}S}{\mathrm{d}\tau'} = S
\end{align}

### Radiative Transfer Equation of Diffuse Radiation

In the $\delta$-two stream approximation, the plane parallel
radiative transfer equation \eqref{eq:plane-parallel-rte}
can be integrated analytically over each hemisphere to get a simplified
set of differential equations expressed in terms of upward and downward
flux density. Integration over the top hemisphere is:

\begin{align}
\label{eq:delta-two-stream-rte}
\bigints_{\uparrow}
  \mu\frac{\mathrm{d}I(\mathbf{\hat{\Omega}})}{\mathrm{d}\tau} \mathrm{d}\omega &=
  \bigints_{\uparrow}\left[
    I(\mathbf{\hat{\Omega}}) -
    (1 - \tilde{\omega})B(\mathbf{\hat{\Omega}}) -
    \frac{\tilde{\omega}}{4\pi}\int_{4\pi}
    p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
    I(\mathbf{\hat{\Omega}'})
    \mathrm{d}\omega'
  \right]\mathrm{d}\omega\nonumber
\end{align}

\begin{align}
&\frac{1}{2}\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau} =
  F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -\nonumber\\
  &-\frac{\tilde{\omega}}{4\pi}\left[
    \int_{\uparrow}\int_\uparrow
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I^\uparrow
      \mathrm{d}\omega'\mathrm{d}\omega +
    \int_{\uparrow}\int_\downarrow
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I^\downarrow
      \mathrm{d}\omega'
      \mathrm{d}\omega +
    \int_{\uparrow}\int_\downarrow
      p_0(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I_0(\mathbf{\hat{\Omega}'})
      \mathrm{d}\omega'
      \mathrm{d}\omega
  \right] =\nonumber\\
  &= F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -
  \tilde{\omega}\left[
    (1 - b) F^\uparrow +
    b F^\downarrow +
    b_0 S
  \right]
\end{align}

where we introduced the *backscatter fraction* $b$:

\begin{align}
b &\equiv \frac{1}{4\pi}\int_\uparrow\int_\downarrow
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
  \mathrm{d}\omega
  \bigg/
  \int_\downarrow I(\mathbf{\hat{\Omega}'})\mathrm{d}\omega'\nonumber\\
  &\equiv \frac{1}{4\pi}\int_\downarrow\int_\uparrow
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
  \mathrm{d}\omega
  \bigg/
  \int_\uparrow I(\mathbf{\hat{\Omega}'})\mathrm{d}\omega'
\end{align}

which is the fraction of downward radiation scattered upward, and, considering
symmetricity of $p$, it is the same as the fraction of upward radiation
scattered downward. The *solar backscatter fraction* $b_0$ is defined
correspondingly.

Integration over the bottom hemisphere can be performed analogously to the 
top hemisphere:

\begin{align}
\label{eq:delta-two-stream-rte}
\bigints_{\downarrow}
  \mu\frac{\mathrm{d}I(\mathbf{\hat{\Omega}})}{\mathrm{d}\tau} \mathrm{d}\omega &=
  \bigints_{\downarrow}\left[
    I(\mathbf{\hat{\Omega}}) -
    (1 - \tilde{\omega})B(\mathbf{\hat{\Omega}}) -
    \frac{\tilde{\omega}}{4\pi}\int_{4\pi}
    p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
    I(\mathbf{\hat{\Omega}'})
    \mathrm{d}\omega'
  \right]\mathrm{d}\omega\nonumber
\end{align}

\begin{align}
&\frac{1}{2}\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} +
  \mu_0\frac{\mathrm{d}S}{\mathrm{d}\tau} =
  F^\downarrow + S -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -\nonumber\\
  &-\frac{\tilde{\omega}}{4\pi}\left[
    \int_{\downarrow}\int_\uparrow
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I^\uparrow
      \mathrm{d}\omega'\mathrm{d}\omega +
    \int_{\downarrow}\int_\downarrow
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I^\downarrow
      \mathrm{d}\omega'
      \mathrm{d}\omega +
    \int_{\downarrow}\int_\downarrow
      p_0(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I_0(\mathbf{\hat{\Omega}'})
      \mathrm{d}\omega'
      \mathrm{d}\omega
  \right] =\nonumber\\
  &= F^\downarrow + S -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}\left[
    (1 - b) F^\downarrow +
    b F^\uparrow +
    (1 - b_0) S +
    fS
  \right]
\end{align}

from which we can subtract the equation for direct radiation
\eqref{eq:rte-solar-raw} to get:

\begin{align}
\label{eq:rte-diff-bottom}
\frac{1}{2}\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} =
  F^\downarrow -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}\left[
    (1 - b) F^\downarrow +
    b F^\uparrow +
    (1 - b_0) S
  \right]
\end{align}

### Delta Scaling

Putting together the derived equations from the previous two sections
\eqref{eq:rte-solar}, \eqref{eq:rte-diff-top}, \eqref{eq:rte-diff-bottom},
the final radiative transfer equations in the $\delta$-two stream approximation
are:

\begin{align}
\frac{1}{2}\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau} &=
  F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -
  \tilde{\omega}(1 - b)F^\uparrow - \tilde{\omega}bF^\downarrow -
  \tilde{\omega}b_0\frac{S}{2\mu_0}\\
-\frac{1}{2}\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} &=
  F^\downarrow -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}(1 - b)F^\downarrow - \tilde{\omega}bF^\uparrow +
  \tilde{\omega}(1 - b_0)\frac{S}{2\mu_0}\\
\frac{\mathrm{d}S}{\mathrm{d}\tau'} &= -\frac{S}{\mu_0}
\end{align}

We can apply the delta scaling $\tau' = \tau(1 - \tilde{\omega}f)$ to the
upward and downward flux equations in addition to the direct radiation,
and maintain the same structure of the equations
by a suitable scaling of $\tilde{\omega}$ and $b$:

\begin{align}
\tilde{\omega}' &= \tilde{\omega}\left[\frac{1 - f}{1 - f\tilde{\omega}}\right]\\
b' &= b\left[\frac{1}{1 - f}\right]\\
b_0' &= b_0\left[\frac{1}{1 - f}\right]
\end{align}

after which the equations for diffuse radiation become:

\begin{align}
\frac{1}{2}\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau'} &=
  F^\uparrow -
  (1 - \tilde{\omega}') 2\pi B^\uparrow -
  \tilde{\omega}'(1 - b')F^\uparrow - \tilde{\omega}'b'F^\downarrow -
  \tilde{\omega}'b_0'\frac{S}{2\mu_0}\\
-\frac{1}{2}\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau'} &=
  F^\downarrow -
  (1 - \tilde{\omega}') 2\pi B^\downarrow -
  \tilde{\omega}'(1 - b')F^\downarrow - \tilde{\omega}'b'F^\uparrow +
  \tilde{\omega}'(1 - b_0')\frac{S}{2\mu_0}
\end{align}


### Differential Form of the Radiative Transfer Equation

More concisely, these can be expressed using
*differential layer coefficients* $\alpha_1$, ..., $\alpha_4$:

\begin{align}
\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau} &=
  \alpha_1 F^\uparrow -
  \alpha_2 F^\downarrow -
  \alpha_3\frac{S}{\mu_0} -
  (\alpha_1 - \alpha_2)\pi B\\
\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} &=
  \alpha_2 F^\uparrow -
  \alpha_1 F^\downarrow +
  \alpha_4\frac{S}{\mu_0} + (\alpha_1 - \alpha_2)\pi B\\
\frac{\mathrm{d}S}{\mathrm{d}\tau} &= -\frac{S}{\mu_0}
\end{align}

where:

- $\alpha_1 = 2(1 - \tilde{\omega}(1 - b))$ is diffuse transmissivity,
- $\alpha_2 = 2b\tilde{\omega}$ is diffuse reflectivity,
- $\alpha_3 = b_0\tilde{\omega}$ is solar to diffuse backscattering,
- $\alpha_4 = (1 - b_0)\tilde{\omega}$ is solar to diffuse forward scattering.

### Integral Form of the Radiative Transfer Equation

### Diffusivity Factor

\begin{figure}
\centering
\includegraphics[height=8cm]{img/diffusivity-factor.pdf}
\caption{
\label{fig:diffusivity-factor}
\textbf{Dependence of monochromatic diffusivity factor on optical
thickness.}
Diffusivity factor ranges from 2 for very small optical thickness
to 1 for large optical thickness.
}
\end{figure}

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

Optical depth at wavenumber $\nu$ is the sum of contributions of all lines:

$$
\tau = ku = \sum_{n=0}^N S_i u f(\nu) = \sum_{n=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}
$$

where $f(\nu)$ is the Voigt line shape, and narrow-band transmissivity

$$
\mathcal{T} = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} e^{-\tau}d\nu
            = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} \exp\left(-\sum_{n=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}\right) d\nu
$$

The above expression is a random variable (because $S_i$ and $\nu_i$ are random
variables). Therefore, we have to compute mean transmissivity to be useful:

$$
\bar{\mathcal{T}} = \int_\mathbf{S} \int_\mathbf{\nu} \mathcal{T} p(\mathbf{\nu})p(\mathbf{S}) d\mathbf{\nu}d{\mathbf{S}}
$$

where $\mathbf{S} = (S_1,...,S_N)$ and $\mathbf{\nu} = (\nu_1,...,\nu_N)$
are vectors of line strengths and line positions.
This integration can be performed analytically [see e.g. @zdunkowski2007],
leading to the _Malkmus formula_ for optical depth:

$$
\tau_M = \frac{\pi\alpha}{2\delta}\left(\sqrt{1+\frac{4\bar{S}u}{\pi\alpha}} - 1\right)
$$

where $\delta$ is the average line spacing.
This formula can be adapted to the case of non-uniform line width $\alpha$
by comparing
two limiting cases of small and large mass paths to the weak and strong line
limits derived in Sec. ?. The formula is first written in terms of two
parameters $a$ and $b$:

$$
\label{eq:malkmus-model}
\tau_M = \frac{a}{2b}\left(\sqrt{1+4bu} - 1\right)
$$

By making approximations for $4bu \ll 1$ and $4bu \gg 1$ match the
weak and strong line limits, one can show that:

$$
a = \sum S_i
$$
$$
b = a^2/\left(\sum 2\sqrt{S_i\alpha_i})\right)^2
$$

\begin{figure}
\includegraphics[width=\textwidth]{img/optical-saturation.pdf}
\caption{
\label{fig:optical-saturation}
\textbf{Monochromatic and narrow band optical depth.}
In the monochromatic case (\textbf{left}), the increase in optical depth is linear,
whereas in a narrow band model (\textbf{right}) optical saturation causes
increase to be progressively more sublinear. Shown is a Malkmus model as in
\eqref{eq:malkmus-model}.
}
\end{figure}

### Optical saturation

From the equation for Malkmus model \eqref{eq:malkmus-model} we can see
that the increase of optical depth with absorber amount $u$ is nonlinear.
This phenomenon is sometimes called *optical saturation*,
i.e. absorption by an absorption line can contribute to narrow band optical
depth only until substantial
fraction of radiation at the wavelength is depleted. After that,
the radiation no longer contains certain wavelengths and optical depth
increases more slowly.
This is in contrast with monochromatic absorption
and gray broadband absorption, when optical depth increases linearly
with absorber amount at all times (Figure\ \ref{fig:optical-saturation}).

We should note that the asymptotic behaviour of the narrow band Malkmus model
is:

- $\tau \propto u$ for relatively small absorber amount (weak limit)
- $\tau \propto \sqrt{u}$ for relatively large absorber amount (strong limit)

When considering optical depth of larger spectral intervals (where narrow band
approximation no longer applies), we can observe *secondary saturation*,
when diminising rate of optical depth increase is caused by variability
of extinction with wavelength such as in Rayleigh scattering, and in cloud
absorption and scattering. While this is not an issue to narrow band model
radiation schemes, it has to be taken into account in broadband model
radiation schemes *in addition* to optical saturation.

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
discretisation have been made.

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
