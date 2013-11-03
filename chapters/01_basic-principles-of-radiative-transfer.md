Basic Principles of Radiative Transfer
======================================

The Electromagnetic Spectrum
-----------------------------

Radiation in the atmosphere is for the most part well represented by
electromagnetic waves. These waves originate from multiple sources, most
importantly the Sun, the Earth's surface and atmospheric gases and continutents
(clouds and suspended particles). They have different wavelengths
depending on the temperature of the radiating object through the
Planck's law. Radiation of different wavelenghts is subject to different levels
of absorption and scattering when passing through the atmosphere. Traditionally,
the electromagnetic spectrum is split into a number of regions
(Fig. \ref{fig:em-spectrum}):

* Gamma radiation
* X-rays
* Ultraviolet radiation (UV-C, UV-B, UV-A)
* Visible light
* Infrared radiation (near IR, thermal IR, far IR)
* Microwaves
* Radio waves 

Not all of them will be of our interset, because they are not represented in the
atmosphere in energies high enough to influence its thermal structure.
Specifically, our interest will be on everything between UV-C and far infrared.

### Ultraviolet Radiation

Ultraviolet radiation (UV) is radiated in appreciable amounts only by very hot
objects, such as the Sun. It is highly energetic, capable of causing electrons
to be released from atoms (photoionisation) and breaking up molecules
(photodissociation). Ultraviolet radiation is further split into three
subregions[^uv-definition]:

* UV-C: 100 nm–280 nm
* UV-B: 280 nm–320 nm
* UV-A: 320 nm–400 nm

Much of ultraviolet radiation is absorbed high in the atmosphere (stratosphere
and mesosphere) by ozone and oxygen, though UV-A reaches the Earth's sufrace
with little attenuation. Ultraviolet radiation has to be considered in radiation
schemes, because it contributes sigificantly to heating of stratosphere. It is
also imporant due to its influence on atmospheric chemistry (Chapman reactions).

[^uv-definition]: The precise choice is somewhat arbitrary, and various
definitions can be found.

### Visible Light

The visible part of the spectrum comprises wavelengths which humans can percept
with their sight. The likely reason which gave rise to this ability is twofold.
(1) This is where the peak power of Sun's radiation is located, and (2) the
clear-sky atmosphere is almost transparent in the visible spectrum. Visible
light spans the region of about 400 nm–700 nm. In radiation models it has to be
considered due to its scattering and absorption by clouds and aerosols, but also
due to relatively weak absorption by oxygen and ozone in a number of bands.

### Infrared Radiation

Infrared radiation (IR) is emitted by objects of temperatures commonly found on
Earth. Infrared spectrum can be split into three additional subregions:

* Near infrared: 700 nm–4.6 μm
* Thermal infrared: 4.6 μm–50 μm
* Far infrared: 50 μm–1 mm

Radiation in near infrared comes mostly from the Sun, while standard temperature
objects emit in the thermal and far infrared. The atmosphere is rather opaque to
the infrared radiation. It is absorbed strongly (but not uniformly) by
greenhouse gases: water vapour, CO~2~, O~3~, CH~4~, CO, N~2~O~ and CFCs, but
also by clouds and aerosols. As it is the main means of radiative energy
exchange between the surface, atmospheric layers and space, it is of paramount
importance to radiation models. Radiation in far infrared approx. above 100 μm
gradually ceases to be energetically important due to low power emitted at
longer wavelengths.

### Shortwave and Longwave Spectrum

For the purpose of radiation models, it is convenient to adopt two even broader
spectral regions -- _shortwave_ and _longwave_ radiation. Though the choice of
precise values is arbitrary, we will settle on the following definition:

* Shortwave radiation (UV, visible, near IR): 0–4.6 μm
* Longwave radiation (thermal and far IR) : 4.6 μm–100 μm

The justification for this choice is that the Sun emits radiation mostly between
0.2–4.6 μm, while the Earth's surface and atmosphere emit mostly at wavelengths
longer than 4.6 μm, with little overlap between the two
(Fig. \ref{fig:sun-earth-spectrum}). As discussed later, this exceptionally
lucky coincidence allows for decoupling of radiative transfer calculations
in these two regions.


Fundamentals
------------

This section summarises the basic theory of radiative transfer and notation used
later in the text.

### Frequency, Wavelength and Wavenumber

_Frequency_ of a monochromatic EM wave will be denoted $\tilde{\nu}$. Frequency
relates to _wavelength_ λ via the speed of light $c = \tilde{\nu}\lambda$.
Longer wavelengths are sometimes indentified by _wavenumber_[^frequency-vs-wavenumber]
$\nu = 1/\lambda$, esp. preferred in the infrared spectrum. It is
notable that wavenumbers in cm^-1^ can be conveniently converted to wavelengths
in μm by the expression $y = 10000/x$, where x is wavenumber and y wavelength
(and vice-versa).

[^frequency-vs-wavenumber]: Symbols for frequency and wavenumber are
sometimes reversed, with $\tilde{\nu}$ denoting wavenumber, and ν frequency.

### Radiance and Flux Density

_Radiance_[^radiance] is power transmitted by an EM wave passing through a unit
surface in a particular direction. Radiance is denoted as $I_\lambda(\vec{r},
\vec{\Omega})$, where $\vec{r}$ and $\vec{\Omega}$ determine the location and
direction of interest (resp.). Radiance is sometimes denoted more specifically
as _monochromatic radiance_ to distinguish it from broadband radiance
(integrated over wavelength). The units of radiance are Wm^-2^sr^-1^, and
monochromatic radiance Wm^-3^sr^-1^.

_Flux density_ F is radiance integrated over a hemisphere. In plane parallel
geometry, depending on the hemisphere we speak of _upward_ or _downward_ flux
density. Flux density integrated over surface is denoted simply as $flux$. _Net
flux density_ is flux density integrated over the full solid angle.

[^radiance]: Radiance is sometimes referred to as _intensity_, _irradiance_ or
_exitance_. The latter two are reserved for radiance incoming on, and emitted
from a surface (resp.).

### Absorption Coefficient and Cross Section

### Emissivity and Albedo

### Optical Path and Transmissivity

### Heating Rate


The Radiative Transfer Equation
-------------------------------

Fundamentally, radiative tranfer is goverened by the Maxwell equations and
quantum mechanical principles. However, it is ofen not neccessary to be
concerned with the details of the electromagnetic field in the context of energy
budget calculations, perhaps with the exception of Mie theory of scattering.

There are three energetically important processes in which radiation interacts
with matter in the atmopshere: _scattering_, _absorption_ and _emission_. Put
together they form the radiative transfer equation.

### Scattering

Scattering of radiation occurs when a charged particle is made to oscillate in
a passing electromagnetic wave, generating new electromagnetic radiation,
which modifies the original field. The is no net exchange of energy between
the particle and the field at the end of the process.

### Absoprtion

Passing radiation can be absorbed by molecules and particles, whereby the energy
of a photon is absorbed to cause an electronic, vibrational or rotational
transition (discussed later) in a molecule. This can be later turned into
kinetic energy, causing an increase in temperature.
The photon is lost in the process, and radiance is reduced by the corresponding
amount of energy. The process of absorption follows quantum mechanical
principles.


### Emission

### Beer's Law

### Radiative Transfer Equation

The full form of the radiative transfer equation (RTE) combines the
contributions of extinction, scattering, and emission in a single equation:

$$
\mathrm{d}I(\theta,\phi) =
    -\beta_\mathrm{e}\mathrm{d}sI(\theta,\phi)
    + \beta_\mathrm{s}\mathrm{d}s \int_{4\pi} I(\theta,\phi) p(\theta,\phi,\theta',\phi') \mathrm{d}\theta' \mathrm{d}{\phi}'
    + \beta_\mathrm{a}\mathrm{d}s B(\phi,\theta)
$$

Solar Constant
--------------

The Sun emits radiation which closely matches that of black body of temperature
about 5800 K. A fraction of the radiation reaches the top of the atmosphere
(ToA).
Because of the large distance of Earth from the Sun, the radiation
can be considered parallel for most practical purposes.
The solar flux density S at ToA
in the direction of the Sun varies seasonally with Earth-Sun distance
from about 1330 Wm^-2^ in July to 1420 Wm^-2^ in January (in contrast to
seasons in the Northern Hemisphere).
The solar flux density
at mean distance is called _solar constant_, and denoted $S_0$. Solar constant
is ofter cited to have value 1366 Wm^-2^, though the exact value is time
variable. One such variability is associated with the ~11-year solar cycle,
but its amplitude is only about 1 Wm^-2^. Longer-term variability also exists,
but it is of little importance to NWP applications.

The solar constant and solar spectrum are best determined from space,
where there is unhindered view of the Sun. There have been a number of such
satellite-borne measurements performed over the past decades [@liou2002].

Scattering on Spherical Particles
---------------------------------
