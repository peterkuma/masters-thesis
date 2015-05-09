Approximate Solutions of the Radiative Transfer Equation
========================================================
\label{chap:approximate-solutions-of-the-rte}

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

In the *$\delta$-two stream approximation* radiance is assumed to be constant over
hemispheres, with the exception of a peak[^peak] from direct
solar radiation (if present).
The peak is treated seperately in order to preserve
good accuracy, as direct radiance can be orders of magnitude greater than
diffuse radiance. There is no azimuthal or zenith dependence of diffuse
radiance, and the total radiance is the sum of diffuse and direct radiance:

[^peak]: Not to be confused with the forward peak of the phase function.

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
in a closed-form to get upward, downward and solar flux density (notice that
for convenience we redefine $F^\uparrow$ and $F^\downarrow$ to be
the diffuse flux only, in contrast to Sec.\ \ref{sec:flux-density}):

\begin{align}
F^\uparrow &\equiv
  \int_\uparrow I_\mathrm{diff}(\mathbf{\hat{\Omega}})
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \ \mathrm{d}\omega =
  \int_0^{2\pi}\int_0^1 I_\mathrm{diff}(\mu,\varphi)\mu
  \ \mathrm{d}\mu\mathrm{d}\varphi =
  \pi I^\uparrow\\
F^\downarrow &\equiv
  \int_\downarrow I_\mathrm{diff}(\mathbf{\hat{\Omega}})
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \ \mathrm{d}\omega =
  \pi I^\downarrow\\
S &\equiv \int_{4\pi} I_\mathrm{dir}(\mathbf{\hat{\Omega}})
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \ \mathrm{d}\omega
\end{align}

Therefore, radiance is fully represented by two diffuse
flux densities (upward and downward) and the flux density of direct (solar)
radiation.
The upward and downward diffuse flux densities will be denoted as $F_\uparrow$
and $F_\downarrow$, and the flux density of solar radiation as $S$. Here,
we assume that $S$ is coming from the Sun, and so always has a direction
somewhere in the bottom hemisphere.

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
direct radiation in the direction of the forward $\delta$ peak of the phase
function:

\begin{align}
\label{eq:rte-dir}
\mu\frac{\mathrm{d}I_\mathrm{dir}(\mathbf{\hat{\Omega}})}{\mathrm{d}\tau} \equiv
  I_\mathrm{dir}(\mathbf{\hat{\Omega}}) -
  \frac{\tilde{\omega}}{4\pi}\int_{\delta}
    p(\mathbf{\hat{\Omega}}, \mathbf{\hat{\Omega}'})
    I_\mathrm{dir}(\mathbf{\hat{\Omega}})
    \mathrm{d}\omega'
\end{align}

To simplify further, we define that the peak of solar radiance
has the shape of the Dirac $\delta$ function[^note]:

\begin{align}
I_\mathrm{dir}(\mathbf{\hat{\Omega}}) = 
  \frac{S}{\mu_0}\delta(\mathbf{\hat{\Omega}}\cdot\mathbf{\hat{\Omega}}_0 - 1)
\end{align}

[^note]: Even though in reality direct solar radiation is spread over a range of
directions.

where $\mathbf{\hat{\Omega}}_0$ is a unit vector in the direction of the
radiation, and $\mu_0 = -\mathbf{\hat{\Omega}}_0\cdot\mathbf{\hat{e}_z}$
the corresponding cosine of the zenith angle,
and express the phase function approximately as:

\begin{align}
p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) \approx
  (1 - f)p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) +
  2f\delta(\mathbf{\hat{\Omega}'}\cdot\mathbf{\hat{\Omega}} - 1)
\end{align}

where $p'(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})$
is the *$\delta$-scaled phase function*, and $f$ is the fraction
scattered in the direction of the forward peak of the phase function,
i.e. we approximate the forward peak by an equivalent Dirac $\delta$ peak.
The factor 2 in the second
term arises from the normalisation condition for the phase function
\eqref{eq:phase-function-normalisation}, assuming $p'$ satisfies the same
condition.

Integrating \eqref{eq:rte-dir} over the solar radiation $\delta$ peak:

\begin{align}
\label{eq:rte-solar-raw}
- \frac{\mathrm{d}S}{\mathrm{d}\tau} =
  \frac{S}{\mu_0} - \tilde{\omega}f\frac{S}{\mu_0} =
  \frac{S}{\mu_0}(1 - \tilde{\omega}f)
\end{align}

This motivates us to introduce *$\delta$-scaling*
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
can be integrated in a closed-form over each hemisphere to get a simplified
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
&\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau} =
  2F^\uparrow -
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
  &= 2F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -
  \tilde{\omega}\left[
    (1 - b) 2F^\uparrow +
    b 2F^\downarrow +
    b_0(1 - f)\frac{S}{\mu_0}
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
&\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} +
  \frac{\mathrm{d}S}{\mathrm{d}\tau} =
  2F^\downarrow + \frac{S}{\mu_0} -
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
  &= 2F^\downarrow + \frac{S}{\mu_0} -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}\left[
    (1 - b) 2F^\downarrow +
    b 2F^\uparrow +
    (1 - b_0)(1 - f)\frac{S}{\mu_0} +
    f\frac{S}{\mu_0}
  \right]
\end{align}

from which we can subtract the equation for direct radiation
\eqref{eq:rte-solar-raw} to get:

\begin{align}
\label{eq:rte-diff-bottom}
\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} =
  2F^\downarrow -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}\left[
    (1 - b) 2F^\downarrow +
    b 2F^\uparrow +
    (1 - b_0)(1 - f)\frac{S}{\mu_0}
  \right]
\end{align}

### Delta Scaling

Putting together the derived equations from the previous two sections
\eqref{eq:rte-solar}, \eqref{eq:rte-diff-top}, \eqref{eq:rte-diff-bottom},
the final radiative transfer equations in the $\delta$-two stream approximation
are:

\begin{align}
\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau} &=
  2F^\uparrow -
  (1 - \tilde{\omega}) 2\pi B^\uparrow -
  \tilde{\omega}(1 - b)2F^\uparrow - \tilde{\omega}b2F^\downarrow -
  \tilde{\omega}b_0(1 - f)\frac{S}{\mu_0}\\
-\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau} &=
  2F^\downarrow -
  (1 - \tilde{\omega}) 2\pi B^\downarrow -
  \tilde{\omega}(1 - b)2F^\downarrow - \tilde{\omega}b2F^\uparrow +
  \tilde{\omega}(1 - b_0)(1 - f)\frac{S}{\mu_0}\\
\frac{\mathrm{d}S}{\mathrm{d}\tau'} &= -\frac{S}{\mu_0}
\label{eq:delta-scaled-solar-flux}
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
\frac{\mathrm{d}F^\uparrow}{\mathrm{d}\tau'} &=
  2F^\uparrow -
  (1 - \tilde{\omega}') 2\pi B^\uparrow -
  \tilde{\omega}'(1 - b')2F^\uparrow - \tilde{\omega}'b'2F^\downarrow -
  \tilde{\omega}'b_0'\frac{S}{\mu_0}
  \label{eq:delta-scaled-upward-flux}\\
-\frac{\mathrm{d}F^\downarrow}{\mathrm{d}\tau'} &=
  2F^\downarrow -
  (1 - \tilde{\omega}') 2\pi B^\downarrow -
  \tilde{\omega}'(1 - b')2F^\downarrow - \tilde{\omega}'b'2F^\uparrow +
  \tilde{\omega}'(1 - b_0')\frac{S}{\mu_0}
  \label{eq:delta-scaled-downward-flux}
\end{align}


### Differential Form of the Radiative Transfer Equation

The equations \ref{eq:delta-scaled-upward-flux},
\ref{eq:delta-scaled-downward-flux} and
\ref{eq:delta-scaled-solar-flux} can be expressed more concisely
using a set of *differential layer coefficients*
$\alpha_1$, ..., $\alpha_4$ (the $\delta$-scaling prime index was dropped
for brevity):

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

- $\alpha_1 = 2(1 - \tilde{\omega}(1 - b))$
- $\alpha_2 = 2b\tilde{\omega}$
- $\alpha_3 = b_0\tilde{\omega}$
- $\alpha_4 = (1 - b_0)\tilde{\omega}$

This system of equations simplifies in both the shortwave and longwave spectrum:
in shortwave $B = 0$, in longwave $S = 0$.

### Integral Form of the Radiative Transfer Equation for a Homogeneous Layer

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

where the *integral layer coefficients* $a_1$, ..., $a_5$:

\begin{align}
&a_1 = \exp\left(-\frac{\tau}{\mu_0}\right), \quad \tau = \tau_b - \tau_t \\
&a_2 = -a_4\gamma_2 - a_5\gamma_1 a_1 + \gamma_2 a_1\\
&a_3 = -a_5\gamma_2 - a_4\gamma_1 a_1 + \gamma_1\\
&a_4 = \frac{E(1 - M^2)}{1 - E^2M^2}\\
&a_5 = \frac{M(1 - E^2)}{1 - E^2M^2}\\
&\gamma_1 = \frac{\alpha_3 - \mu_0(\alpha_1\alpha_3 + \alpha_2\alpha_4)}{1 - \epsilon^2\mu_0^2}\\
&\gamma_2 = \frac{-\alpha_4 - \mu_0(\alpha_1\alpha_4 + \alpha_2\alpha_3)}{1 - \epsilon^2\mu_0^2}\\
&E = \exp(-\epsilon\tau), \quad
M = \frac{\alpha_2}{\alpha_1 + \epsilon}, \quad
\epsilon = \sqrt{\alpha_1^2 - \alpha_2^2}
\end{align}

The integral layer coefficients can be interpreted as:

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
\frac{\mathrm{d}F_\downarrow}{\mathrm{d}\tau} &= -2F_\downarrow\\
F_\downarrow(\tau) &= F_\downarrow(0)\exp(-2\tau)
  \label{eq:flux-without-diffusivity-factor}
\end{align}

However, the true $F_\downarrow(\tau)$ is:

\begin{align}
F_\downarrow(\tau) =
  \int_\downarrow I(\tau)
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \ \mathrm{d}\omega =
  \int_\downarrow \int_0^\tau I(0)\exp(-\tau')\mathrm{d}\tau'
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \ \mathrm{d}\omega
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
line strengths are assumed to have a particular statistical distribution
with a limited number of parameters in each band (walength interval).
For suitably chosen distributions,
the integration over wavelength and a finite path can be done in a closed-form,
leading to an expression for band-averaged transmittance
as a function of path length and distribution parameters.
Traditionally, the band interval has to be small
enough, so that radiance (given by the Planck's law) can be assumed constant
within the band. Such bands are called *narrow-band*.
As discussed later, with some effort this restriction can be lifted,
and band models can be applied to much larger *broadband* intervals,
such as the entire shortwave or longwave spectrum.

### Malkmus Model

One of the most popular narrow-band models is the *Malkmus model*. It is
based on the assumption that there is a given number of randomly
distributed absorption lines in each band, and their stength has
the probability density:

$$
p(S) = \frac{1}{S} e^{-S/S_0}
$$

where $S_0 = \int_0^\infty{Sp(S)dS}$ is the mean line strength.

Optical depth at wavenumber $\nu$ is the sum of contributions of all lines:

$$
\tau = ku = \sum_{i=0}^N S_i u f(\nu) = \sum_{i=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}
$$

where $f(\nu)$ is the Voigt line shape, and narrow-band transmittance:

$$
\mathcal{T} = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} e^{-\tau}d\nu
            = \frac{1}{\Delta\nu} \int_{\nu_1}^{\nu_2} \exp\left(-\sum_{i=0}^N \frac{S_i u\alpha}{\pi[(\nu-\nu_i)^2 + \alpha^2]}\right) d\nu
$$

The above expression is a random variable (because $S_i$ and $\nu_i$ are random
variables).
Therefore, we have to compute the mean to be useful:

$$
\bar{\mathcal{T}} = \int_\mathbf{S} \int_\mathbf{\nu} \mathcal{T} p(\mathbf{\nu})p(\mathbf{S}) d\mathbf{\nu}d{\mathbf{S}}
$$

where $\mathbf{S} = (S_1,...,S_N)$ and $\mathbf{\nu} = (\nu_1,...,\nu_N)$
are vectors of line strengths and line positions,
and $p$ denotes the probability density function.
This integration can be performed in a closed-form [see e.g. @zdunkowski2007],
leading to the *Malkmus formula* for narrow-band optical thickness:

$$
\tau_\mathrm{M} =
\frac{\pi\alpha}{2\delta}\left(\sqrt{1+\frac{4\bar{S}u}{\pi\alpha}} - 1\right)
$$

where $\delta$ is the average line spacing.
This formula can be adapted to the case of non-uniform line width $\alpha$
by comparing
two limiting cases of small and large mass paths to the weak and strong line
limits derived in Sec. ?. The formula is first written in terms of two
parameters $a$ and $b$:

$$
\label{eq:malkmus-model}
\tau_\mathrm{M} = \frac{a}{2b}\left(\sqrt{1+4bu} - 1\right)
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
\textbf{Monochromatic and narrow-band optical depth.}
In the monochromatic case (\textbf{left}), the increase in optical depth is linear,
whereas in a narrow-band model (\textbf{right}) optical saturation causes
increase to be progressively more sublinear. Shown is a Malkmus model as in
\eqref{eq:malkmus-model}.
}
\end{figure}

### Optical Saturation

From the equation for Malkmus model \eqref{eq:malkmus-model} we can see
that the increase of optical depth with absorber amount $u$ is nonlinear.
This phenomenon is sometimes called *optical saturation*,
i.e. absorption by an absorption line can contribute to narrow-band optical
depth only until substantial
fraction of radiation at the wavelength is depleted. After that,
the radiation no longer contains certain wavelengths and optical depth
increases more slowly.
This is in contrast with monochromatic absorption
and gray broadband absorption, when optical depth increases linearly
with absorber amount at all times (Figure\ \ref{fig:optical-saturation}).

We should note that the asymptotic behaviour of the narrow-band Malkmus model
is:

- $\tau \propto u$ for relatively small absorber amount (weak limit)
- $\tau \propto \sqrt{u}$ for relatively large absorber amount (strong limit)

When considering optical depth of larger spectral intervals (where narrow-band
approximation no longer applies), we can observe *secondary saturation*,
when diminising rate of optical depth increase is caused by variability
of extinction with wavelength such as in Rayleigh scattering, and in cloud
absorption and scattering. While this is not an issue to narrow-band model
radiation schemes, it has to be taken into account in broadband model
radiation schemes *in addition* to optical saturation.

Adding Method
-------------

The *adding method* is a method of finding a solution to fluxes for given
optical depths and temperature of layers. The adding method assumes the
$\delta$-two stream approximation and layer discretisation.

A relationship between fluxes at the top and bottom interfaces of a layer
can be found from the $\delta$-two stream differential equations.

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

where $\mathbb{A}$ is a matrix of coefficients (layer transmittances and
reflectances), $\mathbf{F}$ is a vector of fluxes and $\mathbf{S}$ is a
vector of sources. This system can then be solved for $\mathbf{F}$, which
is the desired outcome of the adding method.

Temporal Subsampling
--------------------
\label{sec:computational-intermittency}

Because the temporal variability of all quantities coming as an input 
to the RTE is not the same, it is convenient to avoid repeated computation
of certain results. E.g., the rate of change of cloud cover is much higher
than that of gas concentrations. Therefore, it is possible skip or
interpolate gaseous optical thickness. Other intermediate
results may also be reused, depending on the actual implementation of the
solution.

### Diminising Performance Gain of Temporal Subsampling

\begin{figure}
\centering
\includegraphics[width=8cm]{img/diminishing-gain.pdf}
\caption{
\textbf{Relative model run time with temporal subsampling.}
The relative run time decreases at a diminishing rate as the intermittency
period increases, eventually converging to a constant.
In this example, a full step time fraction $q = 0.5$,
and intermittent step time fraction $q' = 0.5q$ are assumed.
\label{fig:diminishing-gain}
}
\end{figure}

Temporal subsampling allows us to reduce the computation time
of intermittent steps when approximate results are calculated
(e.g. by interpolation), while full steps take an unchanged
amount of time (or somewhat greater, depending on implementation details).
Radiation schemes constitute a fraction of total run time
of an NWP model, typically 20–60 % (?). Therefore, there is a limit on
the total time reduction due to performance improvements in
the radiation scheme alone. Moreover, as we increase the length of
the intermittency period
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
and we choose intermittency period of $k$ steps,
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
the lenght of the intermittency period, especially considering
the detrimental effect intermittency might have the result accuracy.
