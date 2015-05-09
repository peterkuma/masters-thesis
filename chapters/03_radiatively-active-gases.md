Radiatively Active Gases
========================

Radiation passing through the Earth's atmosphere is modified by the processes of
absorption and scattering. Both of these processes are wavelength-dependent, but
while scattering is determined by Rayleigh scattering, Mie theory and
geometric optics, in order to fully determine absorption we need to be know the
specifc absorption lines of radiatively active gases.

Absorption spectrum of gas molecules can have immensely complicated structure,
and one needs a very large amount of information to describe the structure
fully. Additionally, smooting the curve
by averaging out the details is of little use in calculation of transmittance
due to saturation at wavelengths where absorption is strongest (line centers).
This chapter discusses the pysical basis of absorption by gases, while
Chapter\ \ref{chap:approximate-solutions-of-the-rte} introduces approaches
to overcoming this problem.

Spectroscopic data of absorption lines of gases are available from
spectroscopic databases. One of the most comprehensive databases
is HITRAN[^hitran] [@rothman2009]. For gases where continuum
absorption is imporatnt, one needs to use an additional model such as
MT_CKD produced by AER [@mlawer2012], which includes continuum absorption
of water vapor, nitrogen, oxygen, carbon dioxide and ozone.

[^hitran]: \url{https://www.cfa.harvard.edu/hitran/}.
The HITRAN database can be browsed conventiently at
‘HITRAN on the Web’ (\url{http://hitran.iao.ru}).

Types of Transitions
--------------------

Gases can absorb and emit radiation only in the vicinity of precise wavelengths
– absorption lines, due to restrictions imposed by the quantum theory.
In particular, the energy
has to match one of the allowed *electronic*, *vibrational* or *rotational*
transitions, up to a perturbation due to a collision (pressure broadening)
and velocity (Doppler broadening).

Electronic transitions are the most energetic, associated with electrons
transitioning into other energy levels within atoms, or breaking free entirely,
in which case there is a continuum absorption, because any extra energy
can transform into kinetic energy of the escaping electon. Electronic
transitions are mostly responsible for absorption in the high-frequency
part of the spectrum below 300 nm.

Vibrational transitions are less energetic than electronic, but more energetic
than rotational transitions. They are due to transitions between vibrational
modes of multi-atomic molecules.
Not all molecules have vibrational transitions.
They are subject to the condition that EM
wave has the be able to excert force on the atoms, for which the molecule
needs to have a dipole moment (be polarised). Notably, the most abundant
atmospheric gas $\mathrm{N_2}$ does not have a dipole moment,
and therefore does not posses
vibrational modes[^vibrational-modes].
The number of vibrational modes generally depend
on the number of atoms in the molecule.

[^vibrational-modes]:
However, vibrational transitions sometimes can occur even in these
molecules if they are affected by an EM wave at the time when there
is a collision
with another molecule of air, temporarily creating a dipole. Some molecules
also form compounds in the form of dimers or multimers, in which case
new modes may become available.

Rotational transitions are caused transitions between rotational modes of
multi-atomic molecules.
Rotational transitions are the least energetic. As transitions can occur
together, and because they are much less energetic than vibrational transitions,
they combine to produce vibrational bands with fine structure, centered
at a particular wavelength of a vibrational transition.
Not all molecules have rotational transitions. In particular, the EM
wave has to be able to exert torque on the molecule. Especially, it needs
to have a dipole moment, or an intrinsic magnetic moment (as is the case with
$\mathrm{O_2}$).

\begin{figure}
\includegraphics[width=\textwidth]{img/atmospheric-composition.pdf}
\caption{
\label{fig:atmospheric-composition}
\textbf{Atmospheric composition.}
Vertical profiles of mixing ratio of selected species at equinox.
Adapted from \cite{goody1995}. After Allen et. al. (1981, 1984).
}
\end{figure}

Shortwave Absorption
--------------------

In the shortwave spectrum, solar radiation is absorbed significantly
(in terms of the energy budget) by the following gases:

* Water vapour ($\mathrm{H_2O}$)
* Ozone ($\mathrm{O_3}$)
* Carbon dioxide ($\mathrm{CO_2}$)
* Oxygen ($\mathrm{O_2}$, $\mathrm{O}$)
* Methane ($\mathrm{CH_4}$)
* Nitrous oxide ($\mathrm{N_2O}$)

Solar absorption is the greatest in the
high-frequency range. In particular, gamma radiation, X-rays and UV-C
are almost entirely absorbed early in their travel through the atmosphere,
mostly by oxygen and ozone. As such, and because they consitute only a small
contribution of energy to low and mid-altitudes, they are of little
concern to NWP. In the UV spectrum, radiation is strongly absorbed by
bands of ozone (Hartley, Huggins bands), important in the stratosphere.
In the visible spectrum, clear-sky atmosphere is almost transparent,
with a few weaker bands of ozone (Chappius band) and oxygen
(‘red bands’). In the near IR,
radiation is again absorbed strongly by multiple bands of water
vapour, but also carbon dioxide, oxygen (‘infrared bands’), methane and nitrous
oxide. Both absorption in the visible and near IR spectrum has to be accounted
for for an accurate radiative transfer prediction in NWP.
The importance of absorption bands in the shortwave spectrum is given
not only by their strength (absorption cross section) and concentration
of the absorbing gas, but also by the
solar spectrum, which falls off quickly below about $0.2\ \mathrm{\mu m}$,
and above $3\ \mathrm{\mu m}$.

Absorption bands of gases important to solar absorption (discussed in
the following sections) can be seen in
Figure\ \ref{fig:zenith-transmittance-gases},
Figure\ \ref{fig:atmospheric-composition} shows concentration of gases
in the atmosphere,
and Figure\ \ref{fig:shortwave-heating-rate-gases} shows heating
rates attributed to the major shortwave absorbing atmospheric gases.

\begin{figure}
\centering
\includegraphics[width=\textwidth]{img/zenith-transmittance-gases.png}
\caption{
\textbf{Zenith clear-sky transmittance in midlatitude summer attributed to
gases.} Panels show absorption contribution of atmospheric gases. Molecular
scattering is not considered. Adopted from \cite{petty2006}.
\label{fig:zenith-transmittance-gases}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=10cm]{img/shortwave-heating-rate-gases.pdf}
\caption{
\textbf{Shortwave heating rate profile due absorption by atmospheric gases.}
This profile was derived for cloud-free tropical conditions and solar
zenith angle of 30°. Adapted from \cite{petty2006}. Figure courtesy
of S. Ackerman.
\label{fig:shortwave-heating-rate-gases}
}
\end{figure}

### Water Vapour

Water vapour is the most important shortwave absorption gas. It is abundant
in the troposphere, where it falls off sharply with height due to condensation.
It is also highly spatially and temporally variable.

Water vapour absorbs radiation in a number of bands in the shortwave spectrum,
most importantly in the near IR centered at $2.7\ \mathrm{\mu m}$ ($\chi$),
$1.87\ \mathrm{\mu m}$ ($\Omega$), $1.38\ \mathrm{\mu m}$ ($\psi$),
$1.1\ \mathrm{\mu m}$ ($\varphi$), $0.94\ \mathrm{\mu m}$ ($\rho, \sigma, \tau$),
$0.82\ \mathrm{\mu m}$ and $0.72\ \mathrm{\mu m}$ [@goody1995;@liou2002].
All of these are important to solar heating in the atmosphere.
There are also absorption lines in the visible spectrum, but are said
not to contribute significantly to heating rates [@liou2002].

### Ozone

Ozone ($\mathrm{O_3}$) exhibits a number of bands in the shortwave spectrum:
_Hartley bands_, _Huggins bands_ and _Chappuis bands_
(Figure \ref{fig:ozone-shortwave-bands}). All of them are in the form
of continuum due to photodissociation, although Huggins bands have a more
irregular structure.
Of the three, Hartley bands are the strongest. They cover the region of
240–310 nm. Because of their strength, they absort most incident solar radiation
in the mesopshere and stratosphere.
Huggins bands cover the region of 310–340 nm.
Although Chappuis bands are the weakest of the three, they are important for
atomospheric absorption, because they lie in the region of 450–750 nm,
where solar radiation is the strongest. Their principal location of absorption
is in the troposhpere.

\begin{figure}
\includegraphics[width=\textwidth]{ozone-absorption/ozone-absorption.pdf}
\caption{
\label{fig:ozone-shortwave-bands}
\textbf{Ozone shortwave absorption.}
Absorbed solar radiation (\textbf{red}) and absorption cross section
(\textbf{blue}) of $\text{O}_3$.
Indicated are approximate regions of the Hartley, Huggins and Chappius
absorption bands.
Data from \cite{serdyuchenko2012}.
}
\vspace{0.5cm}
\centering
\includegraphics[width=11cm]{img/oxygen-absorption.png}
\caption{
\textbf{Oxygen shortwave absorption.}
Absorption cross section of oxygen $\mathrm{^{16}O^{16}O}$
in the ultraviolet band.
Adopted from \cite{goody1995}. After Brasseur and Solomon (1984).
\label{fig:oxygen-absorption}
}
\end{figure}

### Carbon Dioxide

Carbon dioxide ($\mathrm{CO_2}$) is mostly active in the longwave spectrum,
but exhibits a number of bands in the shortwave as well. The strongest is
centered at $2.7\ \mathrm{\mu m}$, and a number of weaker bands are at
$2.0\ \mathrm{\mu m}$, $1.6\ \mathrm{\mu m}$, $1.4\ \mathrm{\mu m}$
[@liou2002].

### Oxygen

Oxygen ($\mathrm{O_2}$, $\mathrm{O}$) absorption happens mostly in the
ultraviolet, where it is associated with electronic transitions.
High-frequency UV absorption cross section is
shown in Figure\ \ref{fig:oxygen-absorption}. The strength of this absorption
means that little UV radiation penetrates the atmosphere in this region.

Even thouh $\mathrm{O_2}$ is a homonuclear diatomic molecule with no electic
dipole moment, it has a permanent magnetic moment,
enabling rotational transitions to occur. 

Outside of the UV band, oxygen absorbs in the *red* and *infrared*
‘atmospheric’ bands [@goody1995].
They are associated with the $\mathrm{a\leftarrow X}$ (resp.
$\mathrm{b\leftarrow X}$) electronic transition in combination with
vibrational-rotational transitions. The red bands comprise band A centered
at 762\ nm, band B
at 688\ nm, and band $\gamma$ at 628\ nm. Infrared bands are centered at
$1.58\ \mathrm{\mu m}$, $1.27\ \mathrm{\mu m}$
and $1.06\ \mathrm{\mu m}$.
Although relatively sparse, the red bands are important to the
troposheric energy budget, because they they are located at the peak of the
solar spectrum [@liou2002].

Oxygen molecules are known to form dimers with some other
atmospheric constituents, notably $\mathrm{O_2}.\mathrm{N_2}$
and $\mathrm{O_4}$. These have additional
bands belived to contribute roughly $1\ \mathrm{Wm^{-2}}$
to the total atmospheric absorption [@solomon1998].

### Methane

Methane ($\mathrm{CH_4}$) is not active in the visible spectrum,
but has a number of bands in the near IR clustered between 3
and $4\ \mathrm{\mu m}$ (3.38, 3.53, 3.26), 2 and
$2.5\ \mathrm{\mu m}$ (2.37, 2.30, 2.20) and at $1.66\ \mathrm{\mu m}$.

### Nitrous Oxide

Nitrous oxide ($\mathrm{N_2O}$) has a few absorption bands in the near IR
spectrum important to solar absorption: $4.06\ \mathrm{\mu m}$,
$3.90\ \mathrm{\mu m}$, $2.97\ \mathrm{\mu m}$ and $2.87\ \mathrm{\mu m}$
[@liou2002].

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

where $\nu_0$ is the line center and $\alpha$ is the line *half-width*.
It should be noted that this only applies to high enough wavenumbers
(compared to the half-width), but this is only concern to microwaves and longer
wavelengths.

The half-width α depends on the mean time between collision, which can be
expressed in terms of pressure and temperature as:

$$
\alpha = \alpha_0 \frac{p}{p_0} \left(\frac{T_0}{T}\right)^n
$$

where $\alpha_0$ is the half-width at reference pressure and temperature
$p_0$, $T_0$,
and $n$ is an empirically determined exponent, which depends on the type of the
molecule.

It has to be said that the theory outlined above (_Michelson-Lorentz theory_)
does not hold exactly [@goody1995].
Especially, collisions themselves are not instantaneous, but take finite
amount of time. Perhaps most importantly, the Lorentz line shape is
insuffiecient in describing the line shape in far-wings of lines, which
contribute very significantly to absorption in spectral windows, where
there is no other absorption, and a far-wings of many distant lines add up.

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
addition to photoionisation and photodissociation, there are other less
well-explained sources of continuum absoprtion at lower frequencies due to:

* Far-wings of absorption lines
* Collision induced absorption
* Absorption by dimers and multimers

Even though contiuum absorption is generally weak compared to line absorption
(with the exception of UV),
it is still of great importance, because it covers large parts of the spectrum,
often in places where there is absence of line absorption
(_atmospheric windows_).

Water vapour is the most important source of contiuum for the energy budget,
respnsible for as much as 40 % of longwave radiative cooling [@mlawer2012].
The continuum is mostly of two origins: far wings of lines and collision
between molecules (self and foreign continuum).
