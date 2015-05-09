Basic Principles of Radiative Transfer
======================================

This chapter introduces a number of concepts related to radiative transfer
in the Earth's atmosphere, and terms necessary for understanding later chapters
unambiguously (as there are many notations in general use).
Only the most relevant parts are covered, interested reader is advised
to see @petty2006, @zdunkowski2007, @liou2002, @thomas2002 and @goody1995
for a more comprehensive development of the radiative transfer theory.

The Electromagnetic Spectrum
-----------------------------

Radiation in the atmosphere can for the most part be represented by
electromagnetic (EM) waves. In this context, EM waves
can originate from multiple
sources, most importantly the Sun, the Earth's surface and atmospheric gases and
constituents (clouds and suspended particles such as aerosols).
EM waves have different wavelength distribution
depending on the temperature of the radiating body through the Planck's law
(assuming local thermodynamic equilibrium).
Radiation is subject to different levels of absorption
and scattering depending on the wavelength when passing through the atmosphere.
Traditionally, the EM spectrum is divided into a number of *bands*
according to the wavelength (optionally divided further into *subbands*):

* Gamma radiation
* X-rays
* Ultraviolet radiation (UV-C, UV-B, UV-A)
* Visible light
* Infrared radiation (near IR, thermal IR, far IR)
* Microwaves
* Radio waves 

Most of them are not of interest to radiative transfer in NWP models and GCM,
because they are not present in the atmosphere in energies high enough to
influence the heating rates. Specifically, of interest are the
UV, visible light and IR bands.

### Ultraviolet Radiation

Ultraviolet radiation (UV) is radiated in appreciable amounts only by very hot
objects, such as the Sun. It is highly energetic, capable of releasing electrons
from atoms (*photoionisation*) and breaking up molecules
(*photodissociation*). UV radiation spans wavelengths of 10-400\ $\mathrm{nm}$.
The UV band is further divided into multiple subbands,
of which only the last three are of interest to atmospheric radiative
trasfer[^uv-definition]:

* UV-C: 100 nm–280 nm
* UV-B: 280 nm–320 nm
* UV-A: 320 nm–400 nm

Much of UV radiation is absorbed high in the atmosphere (stratosphere
and mesosphere) by ozone and oxygen, though UV-A reaches the Earth's surface
with little attenuation. UV radiation has to be considered in radiation
schemes, because it contributes sigificantly to heating rates in the
stratosphere. It is also imporant due to its influence on atmospheric chemistry
(Chapman reactions).

[^uv-definition]: The precise choice of boundaries is somewhat arbitrary,
and various definitions can be found.

### Visible Light

The visible spectrum comprises wavelengths which humans can percept
with their sight. The likely reason which gave rise to this ability is twofold:
(1) this is where the peak power of Sun's radiation is located, and (2) the
clear-sky atmosphere is almost transparent in the visible spectrum. Visible
light spans the region of about 400–700\ $\mathrm{nm}$.
In radiation models it has to be
considered due to scattering and absorption by air molecules,
clouds and aeorosols. The only significant source of visible light is the Sun.

### Infrared Radiation

Infrared radiation (IR) is emitted by objects of temperatures commonly found
in the Earth's environment.
The IR band is divided into three additional subbands:

* Near infrared: 700 nm–4.6 $\mu$m
* Thermal infrared: 4.6 $\mu$m–50 $\mu$m
* Far infrared: 50 $\mu$m–1 mm

Radiation in the near IR comes mostly from the Sun, while standard temperature
objects emit in the thermal and far IR. The atmosphere is rather opaque to
the infrared radiation. It is absorbed strongly (but not uniformly) by
greenhouse gases: water vapour,
$\mathrm{CO_2}$, $\mathrm{O_3}$, $\mathrm{CH_4}$, $\mathrm{CO}$,
$\mathrm{N_2O}$, $\mathrm{O_2}$ and CFCs, but
also by clouds and aerosols. As it is the main means of radiative energy
exchange between the surface, atmospheric layers and space, it is of paramount
importance to radiation schemes. Radiation in far infrared (approx. above
$100\ \mathrm{\mu m}$) gradually ceases to be energetically important due to low
power emitted at longer wavelengths.

### Shortwave and Longwave Spectrum
\label{sec:shortwave-and-longwave-spectrum}

For the purpose of radiation schemes, it is convenient to adopt two even broader
spectral regions -- *shortwave* (*solar*) and *longwave* (*thermal*) radiation.
Though the choice of precise boundaries is arbitrary,
we settle on the following definition:

* Shortwave radiation (UV, visible, near IR): 0.1–4.6 $\mu$m
* Longwave radiation (thermal, far IR) : 4.6–100 $\mu$m

The justification for this choice is that the Sun emits radiation mostly between
0.1–4.6 $\mu$m, while the Earth's surface and atmosphere emit mostly at wavelengths
longer than 4.6 $\mu$m, with little overlap between the two
(Fig. \ref{fig:sun-earth-spectrum}). This coincidence allows for decoupling of
radiative transfer calculations in the two regions. The Sun can, however,
be a significant source of radiation even in the thermal IR when
considering direct solar radiation or sun glint, important to remote sensing
applications [@petty2006, Sec. 6.3].

\begin{figure}
\includegraphics[width=\textwidth]{img/shortwave-longwave.pdf}
\caption{
\textbf{Planck's function for the approximate temperature of the Sun (6000 K)
and the surface of the Earth (300 K).} The small overlap allows for decoupling
of radiative transfer calculations in the shortwave and longwave parts of the
spectrum. The value is normalised to equal areas. The vertical line
show the division at $4.6\ \mathrm{\mu m}$ (see text).
Adapted from \cite{petty2006}.
\label{fig:sun-earth-spectrum}
}
\end{figure}

Terms and Definitions
---------------------

This section summarises terms and definitions of the radiative transfer theory
used in later chapters. Especially, there is a number of different notations
in use today. We follow those of @petty2006 due to their clarity.

### Frequency, Wavelength and Wavenumber

_Frequency_ of a monochromatic EM wave will be denoted $\tilde{\nu}$. Frequency
is realted to _wavelength_ $\lambda$ via the speed of light
$c = \tilde{\nu}\lambda$. Longer wavelengths are sometimes indentified by
_wavenumber_[^frequency-vs-wavenumber]
$\nu = 1/\lambda$, which is often preferred in the infrared spectrum.

[^frequency-vs-wavenumber]: Symbols for frequency and wavenumber are
sometimes reversed, with $\tilde{\nu}$ denoting wavenumber, and $\nu$ frequency.

It is notable that wavenumbers in $\mathrm{cm^{-1}}$ can be conveniently
converted to wavelengths in $\mathrm{\mu m}$ by the expression $y = 10000/x$,
where $x$ is wavenumber and $y$ is wavelength (and vice-versa).

### Monochromatic Radiance and Radiance

*Monochromatic radiance*
(or *spectral intensity*, *radiant intensity*)
is power transmitted by an electromagnetic
wave at certain wavelength passing through a unit surface in a particular
direction. Monochromatic radiance depends on wavelength $\lambda$,
position $\mathbf{r}$ and direction given by a unit vector
$\mathbf{\hat{\Omega}}$:

\begin{align}
I_{\lambda} = I_{\lambda}(\mathbf{r}, \mathbf{\hat{\Omega}})
\end{align}

Monochromatic radiance has units $\mathrm{Wm^{-3}sr^{-1}}$. When integrated
over an interval of wavelenths, we get *radiance*:

\begin{align}
I = \int_{\Delta\lambda} I_\lambda \mathrm{d}\lambda =
  I(\mathbf{r}, \mathbf{\hat{\Omega}})
\end{align}

Radiance has units $\mathrm{Wm^{-2}sr^{-1}}$.
As *monochromatic radiance*
will be discussed freqently in this text, we will call it simply ‘radiance’
and denote $I$ and state explicitly if *radiance* is considered by calling it
*narrow-band* or *broadband radiance*. We will also assume implicit dependence
on $\mathbf{r}$ in order to make equations more readable.

### Flux Density and Net Flux Density
\label{sec:flux-density}

_Flux density_ is radiance integrated over a hemisphere. In plane parallel
geometry, depending on the hemisphere we speak of _upward_ or _downward_ flux
density:

\begin{align}
F^\uparrow = \int_\uparrow
  I(\mathbf{\hat{\Omega}})
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \mathrm{d}\omega\\
F^\downarrow = \int_\downarrow
  I(\mathbf{\hat{\Omega}})
  \mathbf{\hat{n}}\cdot\mathbf{\hat{\Omega}}
  \mathrm{d}\omega
\end{align}

where $\int_\uparrow$, $\int_\downarrow$ represent integration over the top
and bottom hemisphere (resp.).

*Net flux density* is the difference between the upward and downward flux
densities:

\begin{align}
F^\mathrm{net} = F^\uparrow - F^\downarrow
\end{align}

### Mass and Volume Absorption/Extinction Coefficients
\label{sec:mass-and-volume-absorption-coefficients}

The fractional loss in radiance $\mathrm{d}I$ due to absorption
over a path $\mathrm{d}s$ can be expressed with the
*volume absorption coefficient* $\beta_a$:

\begin{align}
\mathrm{d}I = -I\beta_a\mathrm{d}s
\label{eq:volume-absorption-coefficient}
\end{align}

In gases, this process depends only on the amount of absorber per unit
area along the path $\mathrm{d}u = \rho\mathrm{d}s$, and
\ref{eq:volume-absorption-coefficient}
can be expresses equivalently with the *mass absorption coefficient*
$k_a = \beta_a/\rho$:

\begin{align}
\mathrm{d}I = -Ik_a\mathrm{d}u
\end{align}

Both $k_a$ and $\beta_a$ depend on the type of absorber and are functions
of wavelength. In addition, they may depend on pressure and temperature,
which determine absorption line properties:

\begin{align}
k_a &= k_{a,\lambda,\mathrm{absorber}}(\mathbf{r}, p, T),\\
\beta_a &= \beta_{a,\lambda,\mathrm{absorber}}(\mathbf{r}, p, T).
\end{align}

Note that while $\beta_a$ depends on the absorber density $\rho$,
$k_a$ generally does not.

*Volume extinction coefficient* $\beta_e$ and *mass extinction coefficient*
$k_e$ are defined in the same manner, but here we consider total loss of
radiance due to absorption and scattering to all directions,
as discussed in the section on radiative transfer equation
(Sec.\ \ref{sec:rte}).

### Emissivity and Albedo

### Optical Path, Optical Depth, Optical Thickness and Transmittance

*Optical path* $\tau$ is defined as the integral of volume extinction
coefficient over a finite path through an absorbing medium:

\begin{align}
\tau(s_1, s_2) \equiv \int_{s_1}^{s_2} \beta_e(s)\mathrm{d}s
\end{align}

*Optical depth* is denoted by the same symbol $\tau$, and is the vertical
optical path between the top of the atmosphere and a height $z$:

\begin{align}
\tau(z) \equiv \int_z^\infty \beta_e(z')\mathrm{d}z
\end{align}

*Optical thickness* $\tau$ (again denoted by the same symbol)
is the vertical optical path between two levels
$z_1$ and $z_2$:

\begin{align}
\tau \equiv \tau(z_2) - \tau(z_1)
\end{align}

*Transmittance* (or *transmissivity*) $t$ is the fraction of radiance passing
through a layer of absorber. In a non-scattering medium with no sources,
it is related to optical thickness $\tau$ by:

\begin{align}
t = \exp(-\tau)
\end{align}

### Heating Rate

Heating rate of a layer of atmosphere by radiation is given by the difference
of net flux density between its top and bottom interfaces, which is
a consequence of energy conservation – the energy is transferred from radiation
to air molecules and airborne particles in the layer.

The Radiative Transfer Equation
-------------------------------
\label{sec:rte}

Fundamentally, radiative tranfer is governed by the Maxwell equations and
quantum mechanical principles. However, it is often not neccessary to be
concerned with the details of the electromagnetic field in the context of energy
budget calculations, perhaps with the exception of Mie theory of scattering.

There are three energetically important processes in which radiation interacts
with matter in the atmopshere: _scattering_, _absorption_ and _emission_. Put
together they form the radiative transfer equation.

### Scattering

Scattering of radiation occurs when a charged particle is made to oscillate in
a passing electromagnetic wave, generating new electromagnetic radiation,
which modifies the original field. There is no net exchange of energy between
the particle and the field at the end of the process.

We will define the *scattering phase function* to be a function of two
unit vectors $\mathbf{\hat{\Omega}}'$ and $\mathbf{\hat{\Omega}}$
(in addition to the implicit dependence on the position $\mathbf{r}$),
giving the fraction of radiance scattered from the direction of
$\mathbf{\hat{\Omega}}'$ in the of $\mathbf{\hat{\Omega}}$:

\begin{align}
p = p(\mathbf{\hat{\Omega}}', \mathbf{\hat{\Omega}})
\end{align}

subject to normalisation condition (energy conservation):

\begin{align}
\frac{1}{4\pi}\int_{4\pi} p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}}) \mathrm{d}\omega = 1
\label{eq:phase-function-normalisation}
\end{align}

In the presence of scattering only, the differential change in radiance is:

\begin{align}
\mathrm{d}I(\mathbf{\hat{\Omega}}) =
  -I(\mathbf{\hat{\Omega}})\beta_s\mathrm{d}s +
  \beta_s\mathrm{d}s
  \frac{1}{4\pi}\int_{4\pi}
  p(\mathbf{\hat{\Omega}'}, \mathbf{\hat{\Omega}})
  I(\mathbf{\hat{\Omega}'})
  \mathrm{d}\omega'
\end{align}

i.e. the change in radiance is equal to the amount removed by scattering
in all directions, compensated by radiation scattered into the direction of
$\mathbf{\hat{\Omega}}$ from all other directions.


### Absorption and Beer's Law

Radiation passing through the atmosphere can be absorbed by air molecules
and larger objects present in the atmosphere (such as cloud droplets and
aerosol particles). In the process, the energy of a photon is absorbed
to cause an electronic, vibrational or rotational transition in an atom or
molecule. This can be later turned into kinetic energy,
causing an increase in temperature.
The photon is lost in the process, and radiance is reduced by the corresponding
amount of energy.

The influence of absoprtion on radiance is described by the volume
absorption coefficient $\beta_a$ (discussed in
Sec.\ \ref{sec:mass-and-volume-absorption-coefficients}):

\begin{align}
\mathrm{d}I = -I\beta_a\mathrm{d}s
\end{align}

If we integrate this equation over a finite path, assuming $\beta_a$
is constant, we get the *Beer's law*:

\begin{align}
I(s) &= I(0)\exp(-\beta_a s)
\end{align}

i.e. monochromatic radiance falls of
exponentially in a homegeneous, absorbing, non-scattering medium.
The same relationship applies to absorbers whose volume absorption coefficient
is independent of wavelength (over the interval of interest),
also called *gray bodies*[^gray-body].

[^gray-body]: In analogy to visible light, in which they appear gray.

### Emission

Thermal emission of radiation by a body is bounded by the *Planck's law*:

\begin{align}
B_\lambda(T) = \frac{2hc^2}{\lambda^5(e^{hc/k_B\lambda T} - 1)}
\end{align}

where $B_\lambda(T)$ is radiance emitted by a *blackbody* with temperature $T$.
Bodies which are not perfectly black emit less radiation according to their
*emissivity*.
In the case of bodies which are not a surface, such the air, the volume
absorption coefficient $\beta_a$ has the role of emissivity, and the true
radiance emitted by such a body over a path $\mathrm{d}s$ in the direction
of $\mathrm{d}s$ is:

\begin{align}
\mathrm{d}I_\mathrm{emit} = \beta_a B\mathrm{d}s
\end{align}

We do not need to introduce any volume emission coefficient, as by
the *Kirchoff's law* under the condition of a local thermodynamic equilibrium
(LTE) absorbitivy is equal to emissivity. This condition is satisfied in parts
of the atmosphere where radiative energy budget calculations are important
to NWP (troposhere and stratosphere).

### Radiative Transfer Equation

The full form of the *radiative transfer equation* (RTE) combines the
contributions of extinction, emission and scattering in a single equation:

\begin{align}
\label{eq:rte}
\mathrm{d}I &= - \mathrm{d}I_\mathrm{ext} + \mathrm{d}I_\mathrm{emit} + \mathrm{d}I_\mathrm{scat}\nonumber\\
\mathrm{d}I(\mathbf{\hat{\Omega}}) &=
- \beta_\mathrm{e}\mathrm{d}s I(\mathbf{\hat{\Omega}})
+ \beta_\mathrm{a}\mathrm{d}s B(\mathbf{\hat{\Omega}})
+ \beta_\mathrm{s}\mathrm{d}s \frac{1}{4\pi}\int_{4\pi}
    p(\mathbf{\hat{\Omega}'},\mathbf{\hat{\Omega}})
    I(\mathbf{\hat{\Omega}'})
    \mathbf{\hat{n}}\cdot\mathrm{d}\mathbf{\hat{\Omega}'}
\end{align}

where $\mathrm{d}s$ is in the direction of $\mathbf{\hat{\Omega}}$.

It is the purpose of radiation schemes to find an approximate solution to
the radiative transfer equation. Before this task becomes computationally
feasible in operational NWP models, the equation has to be simplified in a
number ways, as discussed in
Chapter\ \ref{chap:approximate-solutions-of-the-rte}.

<!--
\mathrm{d}I(\theta,\phi) = 
    -\beta_\mathrm{e}\mathrm{d}sI(\theta,\phi)
    + \beta_\mathrm{s}\mathrm{d}s \int_{4\pi} I(\theta,\phi) p(\theta,\phi,\theta',\phi') \mathrm{d}\theta' \mathrm{d}{\phi}'
    + \beta_\mathrm{a}\mathrm{d}s B(\phi,\theta)
-->
