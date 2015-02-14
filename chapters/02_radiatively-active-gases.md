Radiatively Active Gases
========================

Radiation passing through the Earth's atmosphere is modified by the processes of
absorption and scattering. Both of the processes are wavelength-dependent, but
while scattering can be analysed by Rayleigh scattering, Mie theory and
geometric optics, in order to fully grasp absorption we need to be know the
specifc absorption lines of radiatively active gases.

Absorption functions of gas molecules can have immensely complicated structure.
Figure \ref{fig:co2-absorption} shows the absorption coefficient of CO~2~ in
various levels of magnification. Clearly, one needs a very large amount of
information to describe the structure fully. As it turns out, smooting the curve
by averaging out the details is of little use in calculation of transmittance
due to saturation at wavelengths where absorption is strongest (line centers).
This will be discussed later, along with shortcuts to handle the situation
efficiently.

![CO~2~ absorption coefficient.]

Types of Transitions
--------------------

Gases absorb and emit radiation radiation at only precise wavelengths[^1]
due to restrictions imposed by the quantum theory. In particular, the energy
has to match of of the allowed _electronic_, _vibrational_ or _rotational_
transitions.

[^1]: But considering line broadening and continua discussed later in this
chapter.

### Electronic Transitions

Electronic transitions are the most energetic, associated with electrons
transitioning into other energy levels within atoms, or breaking free entirely,
in which case there is a continuum absorption, because any extra energy
can transform into kinetic energy of the escaping electon. Electronic
transitions are mostly responsible for absorption in the high-frequency
part of the spectrum below 300 nm.

### Vibrational Transitions

Vibrational transitions are less energetic than electronic, but more energetic
than rotation transitions. They are due to transitions between vibrational
modes of multi-atomic molecules. In quantum theory, they can be described
by energy levels of a harmonic oscillator, having equally spaced levels
obeying the equation

$$
E_\nu = hv'(\nu + 1/2)
$$

where ν (Greek ‘nu’) is the _vibrational quantum number_.
Not all molecules are capable of having
vibrational transitions. They are subject to the condition that electromagnetic
wave has the be able to excert force on the atoms, for which the molecule
needs to have a dipole moment (be polarised). Notably, the most abundant
atmospheric gas N~2~ does not a dipole moments, and therefore does not posses
vibrational modes[^2]. The number of vibrational modes generally depend
on the number of atoms in the molecule.

[^2]: However, vibrational transitions sometimes can occur even in these
molecules if they are affected by EM wave at the time when there is a collision
with another molecule of air, temporarily creating a dipole. Some molecules
also form compounds in the form of dimers or multimers, in which case
new modes may become available.

### Rotational Transitions

Rotational transitions are caused transitions between rotational modes of
multi-atomic molecules. Rotational modes are quantised by the equation

$$
E_J = \frac{1}{2I}L_J^2
    = \frac{1}{2I}\left(\hbar\sqrt{J(J + 1)}\right)^2
    = \frac{\hbar^2}{2I} J(J + 1)
$$

and the corresponding transitions between adjacent modes are

$$
\Delta E = E_{J+1} - E_J = \frac{\hbar^2}{2I}\left[(J+1)(J+2)-J(J+1)\right] = \frac{\hbar^2}{I}(J + 1)
$$

where J is the _rotational quantum number_ and I is moment of intertia of the
molecule.
Rotational transitions are the least energetic. As transitions can occur
together, and because they are much less energetic than vibrational transitions,
they combine to produce vibrational bands with fine structure, centered
at a particular wavelength of a vibrational transition.

Not all molecules have rotational transitions. In particular, electromagnetic
wave has to be able to exert torque on the molecule. Especially, it needs
to have a dipole moment, or an intrinsic magnetic moment (as is the case with
O~2~).


Shortwave Spectrum
------------------

In the shortwave spectrum, absorption takes place mostly in the high-frequency
part of the spectrum (Fig. \ref{fig:shortwave-absorption}).
In particular, gamma radiation, X-rays, UV-C and UV-B
are almost entirely absorbed early in their travel through the atmosphere,
mostly by oxygen and ozone. As such, and because they consitute only a small
contribution of energy to low and mid-altitudes, they are of little
concern to us. Above these wavelengths in the visible part of the spectrum,
the atmosphere is relatively transparent, with only a few weak bands of ozone and
oxygen. In near-infrared, radiation is again absorbed strongly by bands of water
vapour and CO~2~. This time we have to be concerned, because water
vapour is mostly located in the troposphere, where it contributes to heating
of atmospheric layers, and the absorption is not flat-out as in very short wave
radiation.

### O3

Ozone exhibits a number of bands in the shortwave spectrum in three groups:
_Hartley bands_, _Huggins bands_ and _Chappuis bands_
(Figure \ref{fig:ozone-shortwave-bands}]). All of them are in the form
of continuum due to photodissociation, although Huggins bands have more
irregular structure.

Of the three, Hartley bands are the strongest. They cover the region between
240–310 nm. Because of their strength, they absort most incident solar radiation
in the mesopshere and stratosphere.

[Ozone shortwave bands. Data from @serdyuchenko2012. \label{fig:ozone-shortwave-bands}](img/ozone-shortwave-bands.png)

Huggins bands cover the region of 310–340 nm.

Although Chappuis bands are the weakest of the three, they are important for
atomospheric absorption, because they lie in the region of 450–750 nm,
where solar radiation is the strongest. Their principal location of absorption
is in the troposhpere.

### O2

Oxygen absorption happens mostly in the ultraviolet, where it is associated
with electronic transitions.

Even thouh O~2~ is a homonuclear diatomic molecule with no electic dipole
moment, it has a permanent magnetic moment, enabling rotational transitions
to occur.

Outside of the ultraviolet region, oxygen absorbs in the _red_ and _infra-red_
bands. They are associated with the $\mathrm{a\leftarrow X}$ (resp.
$\mathrm{b\leftarrow X}$) electronic transition in combination with
vibrational-rotational transitions. The red bands comprise band A centered
at 762 nm, band B
at 688 nm, and band γ at 628 nm. Infra-red bands are centered at 1.58 μm, 1.27
μm and 1.06 μm. Although relatively sparse, the red bands are important to the
troposheric energy budget, because they they are located at the peak of the
solar spectrum [@liou2002].

Oxygen molecules are known to form dimers with some other
atmospheric constituents, notably O~2~.N~2~ and O~4~. These have additional
bands belived to contribute roughly 1 Wm^-2^ to the total atmospheric absorption
[@solomon1998].

Longwave Spectrum
-----------------

### Water Vapour

### CO2

### O3

### Trace Gases

Distribution of Gases in the Atmosphere
---------------------------------------

Absorption Lines
----------------

Atmospheric gases do not in fact absorb and emit radiation at exact
wavelengths – if they did we would probably hardly observe any absorption,
because the likelihood of an EM wave of exact wavelength interacting with
a molecule would be negligible. Instead, absorption lines are spread out
over a range of frequencies by three types of processes:

* Natural broadening
* Doppler broadening
* Pressure broadening

_Natural broadening_ occurs due to quantum mechanical effects and is very weak
compared to the other two. Therefore, it has little importantce to atmospheric
radiative transfer.

_Doppler broadening_ occurs due to Doppler shift in frequency as observed
by a moving molecule. It has a normal (Gaussian) shape. Doppler broadening is
relative strongest in the upper atmosphere.

_Pressure broadening_ is the most important type of broadening to atmospheric
physics. It occurs due to collisions between molecules, which impose
a finite time limit on absorption and emission of a monochromatic EM wave.

Effects of all three types of broadening are combined together to produce
a characteristic _line shape_ of an absorbtion line. Line shape is defined
as function f(ν), such that:

$$
k_\nu = Sf(\nu)
$$

where S is the strength of a line. The shape function itself is normalised to
unity:

$$
\int_0^\infty f(\nu) \mathrm{d}\nu = 1
$$

### Pressure Broadening

Molecules in the atmosphere collide with each other at very high frequency.
Every time a collision happens any absorption or emission process which
is underway is interrupted. When a stimulation by a monochromatic wave
is limited to a finite amount of time, this is equivalent to stimulation
by a rage of frequencies, which can be reconstructed by performing Fourier
transform on the amplitude function. By taking into account the statistical
distribution of time between collisions (Poisson distribution), we can
calculate the relative probability of absorpiton/emission at every frequency.
The derivation is carried out in e.g. @zdunkowski2007, here we show only
the important result – the _Lorentz line shape_:

$$
f(\nu) = \frac{\alpha}{\pi[(\nu - \nu_0)^2 + \alpha^2]}
$$

where ν~0~ is the line center and α the line _half-width_.
It should be noted that this only applies to high enough wavenumbers
(compared to the half-width), but this is only concern to microwaves and longer
wavelengths.

The half-width α depends on the mean time between collision, which can be
expressed in terms of pressure and temperature as:

$$
\alpha = \alpha_0 \frac{p}{p_0} \left(\frac{T_0}{T}\right)^n
$$

where α~0~ is the half-width at reference pressure and temperature p~0~, T~0~,
and n is empirically determined exponent, which depends on the type of the
molecule.

It has to be said that the theory outlined above (_Michelson-Lorentz theory_)
does not hold exactly [@goody1995].
Especially, collisions themselves are not instantaneous, but take finite
amount of time. Perhaps most importantly, the Lorentz line shape is
insuffiecient in describing the line shape in far-wings of lines, which
contribute very significantly to absorption in spectral windows, where
there is no other absorption, and a far-wings of many distant lines add up.
Overall, it has been established that the Lorentz line shape _underestimates_
absorption in far-wings, and _overestimates_ absorption near line centers.

### Voigt Line Shape

### Equivalent Width

The _equivalent width_ of a line is the spectral width of a perfectly opaque
square line which would absorb the same about of radiation. For a line
of any shape it can be calculated as:

$$
W = \int_0^\infty (1 - e^{-k_{\nu} u}) d\nu
$$

As such, it is not an intrinsic property of a line, but depends on the
mass path u.

### Weak Line Limit

It is useful to consider the special case when the amount of absorber
is relatively small. The equation of equivalent width can then be linearised
to give a simplified equation:

$$
W = \int_0^\infty (1 - e^{-k_{\nu} u}) d\nu
  \approx \int_0^\infty (1 - (1 - k_{\nu} u)) d\nu
  = \int_0^\infty Sf(\nu)u d\nu
  = Su
$$

In the weak line limit, the aborption by a single line is independent from
line shape, and it is linear with mass path.

### Strong Line Limit

The equivalent width of an arbitrary Lorentz line is:

$$
W = \int_0^\infty \left(1 - \exp\left(-\frac{Su\alpha}{\pi[(\nu-\nu_0)^2 + \alpha^2]}\right)\right) d\nu
$$

If the lower integration limit is extended to -∞, and u is substituted
by non-dimensional mass path $\tilde{u} = Su/(2\pi\alpha)$, the integration
can be performed analytically to give:

$$
W = 2\pi\alpha L(\tilde{u})
$$

where L is the Ladenburg-Reiche function, defined in terms of the modified
Bessel function of the first kind:

$$
L(\tilde{u}) = \tilde{u}e^{-\tilde{u}}[I_0(\tilde{u}) + I_1(\tilde{u})]
$$

Using this analytical form, it can be shown that for large mass path,
equivalent width approaches:

$$
W \approx 2\sqrt{S\alpha u}
$$
 
This is the _strong line limit_, when absorption by a single line
grows in proportion to the square root of mass path $\sqrt{u}$.

The absorption by a single line starts off linearly, but with increasing
absorber amount the monochromatic radiance near the line center becomes
depleted, and the rate of absorption is reduced to sub-linear (square-root)
regime. This can be thought of as _saturation_ of absorption,
and is similar in the context of multiple overlapping absorption lines.

Continuum
---------

Gases absorb radiation in discreete absorption lines approximated by the Lorentz
or Voigt line shape. However, in some molecules there are parts of the spectrum
where the absorption coefficient varies relatively little with wavelength,
without apparent association with absorption lines. Typically, this _continuum
absoprtion_ occurs in connection with photoionization and photodissociation,
when the extra energy is consumed by kinetic energy of the escaping electron,
resp. broken-up molecules. These processes are mostly confined to the
ultraviolet part of the spectrum, because of the high energies requered. In
addition to photoionisation and photodissociation, there are other less well-
explained sources of continuum absoprtion at lower frequencies due to:

* Far-wings of absorption lines
* _Self continuum_
* _Foreign continuum_
* Absorption by dimers and multimers

Event though contiuum absorption is generally weak comparable to line absorption
(with the exception of UV)
it is still of great importance, because it convers large parts of the spectrum,
often in places where there is absence of line absorption
(_atmospheric windows_).

### Water Vapour Continuum

Water vapour is the most important source of contiuum for the energy budget,
respnsible for as much as 40 % of longwave radiative cooling [@mlawer2012].
The continuum is mostly of two origins: far wings of lines and collision
between molecules (self and foreign continuum).

### Continua of Other Gases
