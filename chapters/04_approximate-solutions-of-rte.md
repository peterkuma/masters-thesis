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
Defining $\mu \equiv \cos(\theta)$[^note-cos-zenith-angle] and noting that
$\mathrm{ds} = \mathrm{d}z/\mu$, \eqref{eq:rte} transforms to:

\begin{align}
\mu \frac{\mathrm{d}I(\mathbf{\hat{\Omega}})}{\mathrm{d}z} =
    -\beta_\mathrm{e}I(\mathbf{\hat{\Omega}})
    + \beta_\mathrm{a} B(\mathbf{\hat{\Omega}})
    + \frac{\beta_\mathrm{s}}{4\pi}\int_{4\pi}
      p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
      I(\mathbf{\hat{\Omega}'})
      \mathrm{d}\omega'
\end{align}

[^note-cos-zenith-angle]: As noted by @petty2006, p. 325, some authors use the
definition $\mu_0 \equiv |\cos(\theta)|$. Here, we use
$\mu_0 \equiv \cos(\theta)$
as it leads to more straightforward equations in this situtation.

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
      \mathrm{d}\omega'
\end{align}

where $\tilde{\omega} \equiv \beta_\mathrm{s}/\beta_\mathrm{e}$ is the
*single scatter albedo*. This is the *radiative transfer equation
in plane parallel atmosphere*.

The geometry of the problem is shown schematically in
Figure\ \ref{fig:geometry}.

\begin{figure}
\centering
\includegraphics[width=\textwidth]{img/geometry.pdf}
\caption{
\label{fig:geometry}
\textbf{Geometry of the plane parallel approximation.}
Arrows indicate the direction of increase of the optical depth $\tau$ and
the vertical coordinate $z$.
}
\end{figure}

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
  \end{dcases}
\end{align}

where $I^\uparrow$ and $I^\downarrow$ are upward and downward radiance.
$I^\uparrow$ and $I^\downarrow$ are functions
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
&S = \int_{4\pi} I_\mathrm{dir}(\mathbf{\hat{\Omega}})\mathrm{d}\omega
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
    I_\mathrm{dir}(\mathbf{\hat{\Omega}'})
    \mathrm{d}\omega',\quad
    \mathbf{\hat{\Omega}} \in \delta
\end{align}

To simplify further, we define that the forward peak has the shape of
the Dirac $\delta$ function[^note]:

\begin{align}
I_\mathrm{dir}(\mathbf{\hat{\Omega}}) = S\delta(\mathbf{\hat{\Omega}}\cdot\mathbf{\hat{\Omega}}_0 - 1)
\end{align}

[^note]: Even though in reality direct solar radiation is spread over a range of
directions.

where $\mathbf{\hat{\Omega}}_0$ is a unit vector in the direction of the
radiation, and express the phase function approximately as:

\begin{align}
p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) \approx
  (1 - f)p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) +
  f\delta(\mathbf{\hat{\Omega}'}\cdot\mathbf{\hat{\Omega}} - 1)
\end{align}

where $p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})$
is the *$\delta$-scaled phase function*, and $f$ is the fraction
scattered in the direction of the forward peak, i.e. we approximate
the forward peak by an equivalent Dirac $\delta$ peak.

Integrating \eqref{eq:rte-dir} over the $\delta$ peak:

\begin{align}
\label{eq:rte-solar-raw}
- \mu_0\frac{\mathrm{d}S}{\mathrm{d}\tau} = S - \tilde{\omega}fS =
  S(1 - \tilde{\omega}f)
\end{align}

where $\mu_0$ is cosine of the zenith angle correspoding to
$\mathbf{\hat{\Omega}}_0$:
$\mu_0 = -\mathbf{\hat{\Omega}}_0\cdot\mathbf{\hat{e}_z}$.
This motivates us to introduce *delta scaling*
$\tau' \equiv \tau(1 - \tilde{\omega}f)$,
so that the radiative transfer equation for direct radiation now resembles
the Beer's law:

\begin{align}
\label{eq:rte-solar}
\frac{\mathrm{d}S}{\mathrm{d}\tau'} = -\frac{S}{\mu_0}
\end{align}

### Radiative Transfer Equations of Diffuse Radiation

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
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I_\mathrm{dir}(\mathbf{\hat{\Omega}'})
      \mathrm{d}\omega'
      \mathrm{d}\omega
  \right] =\nonumber\\
  &= F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -
  \tilde{\omega}\left[
    (1 - b) F^\uparrow +
    b F^\downarrow +
    \frac{1}{2}b_0(1 - f) S
  \right]
\end{align}

where we introduced the *backscatter fraction* $b$ and
*solar backscatter fraction* $b_0$:

\begin{align}
b &\equiv \frac{1}{4\pi}\int_\uparrow\int_\downarrow
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I_\mathrm{diff}(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
  \mathrm{d}\omega
  \bigg/
  \int_\downarrow I_\mathrm{diff}(\mathbf{\hat{\Omega}'})\mathrm{d}\omega'\nonumber\\
  &\equiv \frac{1}{4\pi}\int_\downarrow\int_\uparrow
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I_\mathrm{diff}(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
  \mathrm{d}\omega
  \bigg/
  \int_\uparrow I_\mathrm{diff}(\mathbf{\hat{\Omega}'})\mathrm{d}\omega'\\
b_0 &\equiv \frac{1}{4\pi}\int_\uparrow\int_\downarrow
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I_\mathrm{dir}(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
  \mathrm{d}\omega
  \bigg/
  \frac{1}{4\pi}
  \int_{4\pi}\int_\downarrow
    p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})(1 - f)
    I_\mathrm{dir}(\mathbf{\hat{\Omega}'})
    \mathrm{d}\omega'\mathrm{d}\omega
\end{align}

which is the fraction of scattered downward radiation scattered upward,
and, considering symmetricity of $p$, it is the same as the fraction of
scattered upward radiation scattered downward.

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
      p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
      I_\mathrm{dir}(\mathbf{\hat{\Omega}'})
      \mathrm{d}\omega'
      \mathrm{d}\omega
  \right] =\nonumber\\
  &= F^\downarrow + S -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}\left[
    (1 - b) F^\downarrow +
    b F^\uparrow +
    \frac{1}{2}(1 - b_0)(1 - f)S +
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
    \frac{1}{2}(1 - b_0)(1 - f)S
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
  \tilde{\omega}b_0(1 - f)\frac{S}{2\mu_0}\\
-\frac{1}{2}\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} &=
  F^\downarrow -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}(1 - b)F^\downarrow - \tilde{\omega}bF^\uparrow +
  \tilde{\omega}(1 - b_0)(1 - f)\frac{S}{2\mu_0}\\
\frac{\mathrm{d}S}{\mathrm{d}\tau'} &= -\frac{S}{\mu_0}
\end{align}

We can apply the delta scaling $\tau' = \tau(1 - \tilde{\omega}f)$ to the
upward and downward flux equations in addition to the direct radiation,
and maintain the same structure of the equations
by a suitable scaling of $\tilde{\omega}$ and $b$:

\begin{align}
\tilde{\omega}' &= \tilde{\omega}\left[\frac{1 - f}{1 - f\tilde{\omega}}\right]\\
b' &= b\left[\frac{1}{1 - f}\right]\\
b_0' &= b_0
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
  (\alpha_1 - \alpha_2)\pi B
  \label{eq:differential-rte-upward}\\
\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} &=
  \alpha_2 F^\uparrow -
  \alpha_1 F^\downarrow +
  \alpha_4\frac{S}{\mu_0} + (\alpha_1 - \alpha_2)\pi B
  \label{eq:differential-rte-downward}\\
\frac{\mathrm{d}S}{\mathrm{d}\tau} &= -\frac{S}{\mu_0}
  \label{eq:differential-rte-solar}
\end{align}

where:

- $\alpha_1 = 2(1 - \tilde{\omega}(1 - b))$ is diffuse transmissivity,
- $\alpha_2 = 2b\tilde{\omega}$ is diffuse reflectivity,
- $\alpha_3 = b_0\tilde{\omega}$ is solar to diffuse backscattering,
- $\alpha_4 = (1 - b_0)\tilde{\omega}$ is solar to diffuse forward scattering.

This system of equations simplifies in both shortwave and longwave parts of
the spectrum: in shortwave $B = 0$, in longwave $S = 0$.

### Integral Form of the Radiative Transfer Equation

The coupled system of linear ordinary differential equations
\eqref{eq:differential-rte-upward}–\eqref{eq:differential-rte-solar}
can be solved for a homogeneous layer by diagonalisation and subsequent
integration. While straightforward, the solution is complicated to perform,
and we list only the result here according to @masek2014. Also see e.g.
@zdunkowski2007, Sec. 6.4 for a worked out solution.

Integrated over a layer from $\tau_t$ (top) to $\tau_b$ (bottom), the diffuse
and direct fluxes have the following linear relationship:

\begin{align}
\begin{bmatrix}
S(\tau_b)\\
F^\downarrow(\tau_b)\\
F^\uparrow(\tau_t)
\end{bmatrix} = 
\begin{bmatrix}
a_1 & 0 & 0\\
a_2 & a_4 & a_5\\
a_3 & a_5 & a_4
\end{bmatrix}
\begin{bmatrix}
S(\tau_t)\\
F^\downarrow(\tau_t)\\
F^\uparrow(\tau_b)
\end{bmatrix}
\end{align}

where the *integral layer coefficients* $a_1$, ..., $a_5$ can be interpreted as:

* $a_1$: *direct transmittance*
* $a_2$: *direct to diffuse transmittance*
* $a_3$: *direct to diffuse reflectance*
* $a_4$: *diffuse transmittance*
* $a_5$: *diffuse reflectance*

The meaning of the coefficients is shown schematically
in Figure\ \ref{fig:integral-rte-scheme}.

\begin{figure}
\includegraphics[width=\textwidth]{img/integral-rte-scheme.pdf}
\caption{
\textbf{Schematic view of the integral layer coefficients.}
Full lines indicate direct radiation, dashed lines indicate diffuse radiation
passing through an atmospheric layer bounded by optical depths $\tau_t$ and
$\tau_b$.
\label{fig:integral-rte-scheme}
}
\end{figure}

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

In the simple application of two stream approximation, we assume that
diffuse radiation is hemispherically isotropic at all points along the
vertical axis $z$. When integrating verticaly over a finite path
(a slab of atmosphere), however, we can improve the accuracy if we take
into consideration that within the slab radiance may have full directional
dependence and preserve hemispheric isotrophy on the boundaries only. This
allows us to account for the fact that radiation traversing the slab at
different angles passes through different path lengths, and thus is subject to
different levels of attenuation.

It is possible to introduce a single parameter $U$,
called *diffusivity factor*, into the integral form of the
radiative transfer equation to rescale the optical depth,
and improve its accuracy significantly.

First, we consider the case of simple Beer's law, i.e. without scattering.
In the two stream approximation:

\begin{align}
\mu\frac{\mathrm{d}I}{\mathrm{d}\tau} &= -I
  \quad /\int_\downarrow (...)\mathrm{d}\omega\\
\frac{1}{2}\frac{\mathrm{d}F_\downarrow}{\mathrm{d}\tau} &= -F_\downarrow\\
F_\downarrow(\tau) &= F_\downarrow(0)\exp(-2\tau)
  \label{eq:flux-without-diffusivity-factor}
\end{align}

However, the true $F_\downarrow(\tau)$ is:

\begin{align}
F_\downarrow(\tau) = \int_\downarrow I(\tau)\mathrm{d}\omega =
  \int_\downarrow \int_0^\tau I(0)\exp(-\tau')\mathrm{d}\tau'\mathrm{d}\omega
  \label{eq:flux-exact}
\end{align}

If we instead introduce a more flexible form of
\eqref{eq:flux-without-diffusivity-factor} with the diffusivity factor:

\begin{align}
F_\downarrow(\tau) = F_\downarrow(0)\exp(-U\tau)
\end{align}

and require that such $F_\downarrow(\tau)$ is the exact flux as in
\eqref{eq:flux-exact}, we can solve for $U(\tau)$ to get a curve as in
Figure\ \ref{fig:diffusivity-factor}. The values range from 2 for $\tau \ll 1$
(*no scaling* relative to unmodified two stream approximation) to 1 for
$\tau \gg 1$.

The situation is more complicated if we consider broadband
radiation, where optical satuation modifies the level of attenuation with
respect to monochromatic radiation in a path-dependent way.
Generally, a single value of $U$ between 1 and 2 is chosen in radiation schemes,
such that good practical results are obtained.

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

One of the most comprehensive model of continuum absorption is MT_CKD produced
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

Net Exchange Rate Formulation
-----------------------------



Computational Intermittence
---------------------------

Because the temporal variability of all quantities coming as an input 
to the RTE is not the same, it is convenient to avoid repeated computation
of certain results. E.g., the rate of change of cloudiness is much higher
than that of gas concentrations. Therefore, it is possible skip or linearise
the computation of gaseous transmission functions. Other intermediate
results may also be reused, depending on the actual implementation of the
solution.

### Diminising Performance Gain of Computational Intermittence

\begin{figure}
\centering
\includegraphics[width=8cm]{img/diminishing-gain.pdf}
\caption{
\textbf{Relative model run time with computational intermittence.}
The relative run time decreases at a diminishing rate as the intermittence
period increases, eventually converging to a constant.
In this example, a full step time fraction $q = 0.5$,
and intermittent step time fraction $q' = 0.5q$ are assumed.
\label{fig:diminishing-gain}
}
\end{figure}

Computational intermittence allows us to reduce the computation time
of intermittent steps when approximate results are calculated
(e.g. by interpolation), while full steps take an unchanged
amount of time (or somewhat greater, depending on implementation details).
Radiation schemes constitute a fraction of total run time
of an NWP model, typically 20–60 % (?). Therefore, there is a limit on
the total time reduction due to performance improvements in
the radiation scheme alone. Moreover, as we increase the length of
the intermittence period
(the number of intermittent steps per the number of full steps),
there is a diminishing improvement in total run time,
to the point that intermittent steps far outnumber full steps, and the
computation time of full steps ceases to matter. The accuracy will continue
to decrease, however.

Let us assume that a model time step takes time $t_m$ to compute,
and the model initialisation/deinitialisation time is $t_0$. The total model
run time when $n$ steps are computed is then:

\begin{align}
t(n) = t_0 + t_m n
\end{align}

If a full step of our module (radiation scheme) takes a fraction $q$ of the
model time step to compute, and an intermittent step takes $q' < q$,
and we choose intermittence period of $k$ steps,
the total model run time will be:

\begin{align}
t_k'(n) = t_0 + t_m q\frac{n}{k} + t_m q'\left(n - \frac{n}{k}\right) +
  t_m(1 - q)n
\end{align}

i.e. the sum of initialisation time, time of full steps,
time of intermittent steps, and the rest of the model.
The relative model run time will be:

\begin{align}
\tau_k = \frac{t'_k(n)}{t(n)} \approx 1 - (q - q')\left(1 - \frac{1}{k}\right) =
  1 - q\left(1 - \frac{q'}{q}\right)\left(1 - \frac{1}{k}\right)
\end{align}

where we neglected the initialisation time ($t_0 \ll t(n)$).
Therefore, when $k \rightarrow \infty$, $\tau_k \rightarrow 1 - (q - q')$,
and there is a diminishing gain in performance as $k$ increases.


Figure\ \ref{fig:diminishing-gain} demonstrates $\tau_k$
for a particular choice of parameters. We can see that considering
improvement in the total model run time is important when deciding
the lenght of the intermittence period, especially considering
the detrimental effect intermittence might have the result accuracy.