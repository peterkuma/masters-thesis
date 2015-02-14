ACRANEB
=======

ACRANEB [@ritter1992] is a radiation scheme developed as an alternative to RRTM
(Rapid Radiative Transfer Model) for use in NWP models. In contrast to
k-distribution method employed by RRTM, ACRANEB uses a broadband model
in only two spectral regions – shortwave and longwave, along with combined
adding method/net exchange rate approach to finding spatial solution of
the radiative transfer equation. Decrease in accuracy is compensated by
more frequent updating of cloud cover made possible by shorter integration time.

ACRANEB is currently used operatively as a module in the NWP model ALARO
by a number of countries.

Operation Overview
------------------

The ACRANEB scheme is run on a single cell of the model computational grid.
Vertically, the atmosphere is split into layers, on which the computation
is discretizated. In the ALARO model, the layers are defined in hybrid
_eta cooridates_, transitioning smoothly from σ-coordinates near the surface
to pressure coordinates in the free atmosphere. Therefore, boundary layers
follow the ground, while upper layers follow isobaric surfaces.

The input to the radiation scheme consists of:

* Pressure profile
* Temperature profile
* Concentration of gases
* Cloud fraction and cloud water/ice content
* Aerosol fraction and properties (?)
* Surface temperature and albedo/emissivity
* Solar constant (?)

The output of the scheme are the broadband fluxes at layer interfaces,
from which the heating rate of layers can be calculated.

Apart from an NWP model, ACRANEB can be run in isolation inside a
single-cell model. This is useful mostly for diagnostic purposes.

Broadband Regions
-----------------

The ACRANEB scheme operates in two spectral regions:

* Shortwave: 245 nm – 4.642 μm
* Longwave: 4.642 μm – 105.000 μm

In the shortwave region, there is a single source of radiation
(the Sun, resp. Moon), which undergoes scattering and absorption in every layer.

In the longwave region, the surface and every layer is a source of radiation
through thermal emission, but this complexity is somewhat reduced by the fact
that scattering of infrared radiation by gases in the atmosphere is weak enough
to be neglected, although scattering of infrared radiation by clouds and
aerosols still needs to be taken into account.

Gaseous Transmission
--------------------

The radiation model depends on the ability to calculate gaseous transmission
function between arbitrary layers. Transmission functions are approximated by a
_modified Malkmus model_.
The complex absorption structure of a gas is parametrised by a small number
of parameters as it is in the classical narrow-band Malkmus model,
but in this case they describe the whole broadband region
(shorwave or longwave). This greatly reduces the number of calculations
needed to to compute a transmission function between two layers, but
necessitate a range of compromises to be made.

### Modified Malkmus Model

The modified Malkmus model is given by a heuristically derived formula
based on the original Malkmus formula [@masek2012]:

$$
\tau_M = \frac{a}{2b}\left(\sqrt{1 + \frac{4bu}{1 - c/a} - 1} \right)
$$
$$
\tau = \frac{\tau_0}{\alpha}\left[\left(1 + \frac{\tau_M}{\tau_0}\right)^{\alpha} - 1\right]
$$

Coefficients a, b, and c depend on pressure and temperature by:

$$
a = a_0 (T/T_0)^{\alpha_a},
b = b_0 (p_0/p) (T/T_0)^{\alpha_b},
c = c_0 (p/p_0) (T/T_0)^{\alpha_c}
$$

The parameters a~0~, b~0~, c~0~, α~a~, α~b~, α~c~, α and τ~0~
are determined by fitting the transmission
function to a range of transmissions calculated by an external narrow-band
model SPLIDACO.

### Representation of Gases in ACRANEB

ACRANEB contain representation of all atmospheric gases which contribute
significantly to the radiative energy budget in shortwave and longwave part
of the spectrum:

* Water vapour
* O~3~`
* CO2+ (CO~2~, CH~4~, CO, N~2~O, O~2~)

CO~2~, CH~4~, CO, N~2~O and O~2~ are treated as a single _composite gas_
(‘CO2+’), because they are well-mixed, and their concentration in the atmosphere
is relatively constant[^gases-concentration]
(Fig. \ref{fig:gases-concentration}).

The absorption structure of each gas is described by a total of 16 parameters
(8 for both parts of the spectrum), as detailed above.

\begin{figure}
\includegraphics[width=\textwidth]{img/atmospheric-composition.pdf}
\caption{
\label{fig:atmospheric-composition}
\textbf{Atmospheric composition.}
Schematic figure showing concentration of some radiatively active gases in the
atmosphere. Adapted from \cite{goody1989}.
}
\end{figure}

[^gases-concentration]: This is not neccessrily true for all conditions,
because some of these gases have sources near the surface, e.g. CO~2~
is released by vegetation and exhibits both spatial and seasonal variability.
Nevertheless, this simplification is justified, because the impact on
atmospheric heating rate is low [citation?].

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





Net Exchange Rate Formulation
-----------------------------

The adding method introduced in the previous chapter can be used to calculate
fluxes at layer interfaces when source terms (sources of radiation) and
optical depths of layers are known. However, this approach cannot be used
directly for broadband calculations. This is because the optical depths
are dependent on the actual power distribution with wavelength in affected flux,
i.e. certain wavelengths can be selectively depleted by previous absorption,
and further absorption becomes saturated (non-linear). Because there is only
one broadband flux incorporation contributions of many sources, there is no
way of specifying single right optical depth of a layer in the adding method
equation. But this does not preclude the possibility to find one that is the
most optimal.

An important observation about the radiative transfer problems is that it
is linear – the radiative transfer equation can be solved separately for
each radiation source, and total radiances (or fluxes) can be obtained by
summing the elemental solutions. Therefore, in theory, the adding method
can be applied for each radiation source only, ensuring that layer
optical depths can be chosen (almost) unequivocally, because the path between
the layer and source is well known. The only exception is multiple scattering,
when the path is prolonged, but this may be a relatively negligible effect.
This method however cannot be femployed efficiently in radiative transfer models,
because there are too many sources (in the longwave spectrum every layer is
a source). But some sources are more important than others – radiation
exchange with surface and space are generally stronger than exchanges between
layers. The space is not a radiation source (rather a ‘sink’), but the situation
can be mathematically inverted to treat it as a source instead.

ACRANEB, being a broadband radiative model, has to make a number of simplifying
assumptions in order to be able to leverage the adding method.


### Statistical Model

### Autoevaluation

Verification
------------

ACRANEB belongs to the category of less accurate but fast radiative transfer
models. As such, it can use RRTM or LBL models as a verification target.
