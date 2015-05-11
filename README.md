# Broadband approach as a framework for implementation of radiative transfer scheme with selective intermittency: Cost versus accuracy study

This repository contains source files and accompanying analyses
of the master's thesis
*Broadband approach as a framework for implementation of
radiative transfer scheme with selective intermittency:
Cost versus accuracy study*.

See [thesis.pdf](https://github.com/peterkuma/acraneb-thesis/raw/master/thesis.pdf).

The thesis was submitted on 11 May 2015.

**Related repositories:**

- [peterkuma/acraneb2-intermittency-analysis](https://github.com/peterkuma/acraneb2-intermittency-analysis)
- [peterkuma/shortwave-intermittency](https://github.com/peterkuma/shortwave-intermittency)

Abstract
--------

The computational complexity of radiation schemes in NWP models
precludes full radiative transfer calculations in every time step
and every grid point of the model. Traditionally, models resort to calling
a radiation scheme on a reduced temporal or spatial resolution, optionally
scaling the resulting fluxes for the change in temperature profile
and the solar zenith angle. As a result, the variability of cloud cover is
neglected, leading to a considerable error. In the shortwave spectrum,
relatively slowly changing gaseous optical properties are one of the most
expensive parts to calculate. We propose a modification to the shortwave part
of the ACRANEB2 broadband radiation scheme to interpolate gaseous optical
thickness of layers with respect to the solar zenith angle within
a chosen intermittency period, while still accounting for evolving cloudiness
by recalculating its optical properties and the resulting
fluxes via the adding method in every model time step.
In this work we use a single column model to study the dependence
of shortwave gaseous optical thickness on the solar zenith angle,
we show that this dependence can be approximated with good accuracy,
implement this approximation in the ACRANEB2 radiation scheme
and assess the impact on accuracy of heating rates and model run time
in 24-h simulations of the limited-area NWP model ALADIN. We show that
the modification results in time saving of up to 4 % of total model run time
and incur error on shortwave heating rates up to ±0.4 K/day at noon
(90 % confidence interval)
and 0.06 K/day (MAE) over the whole domain and time period,
and that both performance and accuracy scale with the length of the
intermittency period. This relationship is summarised in
a cost vs. accuracy comparison, giving potential users a guide on choosing
the optimal intermittency period in their circumstances.
The proposed modification became part of the ACRANEB2 radiation scheme
implemented in package ALARO-1 version A, and since January 2015
it is operational in the model ALADIN/CHMI.

**Keywords:** shortwave radiative transfer code, cost versus accuracy,
broadband approach, partial intermittency, gaseous optical thickness

Assignment
----------

**Student:** Bc. Peter Kuma

**Supervisor:** Mgr. Ján Mašek

### Title

**Broadband approach as a framework for implementation of
radiative transfer scheme with selective intermittency
– cost versus accuracy study**

### Goal

Propose, implement and test suitable intermittent strategies for
ACRANEB scheme, taking into account particularities of shortwave and longwave
radiative transfer calculations.

### Annotation

Clouds are main modulating factor of radiative transfer in the Earth's atmosphere. For realistic numerical weather prediction it is thus desirable to have full feedback between radiative transfer and quickly evolving clouds. Ideally, this would be achieved by making radiative transfer calculations at every gridpoint and every model timestep. Main obstacle to do this is spectral integration. Extremely high cost of exact line by line computations prevents their use in numerical weather prediction so that cheaper and somewhat less accurate alternatives must be sought. Traditional solutions are based either on so called k-distribution method, or on broadband approach. The latter is used also in radiation transfer scheme ACRANEB of model ALADIN, for efficiency reasons having just two spectral bands – one solar (shortwave) and one thermal (longwave). Even with such broad spectral division it is possible to make the scheme accurate enough by parameterizing optical saturation of shortwave cloud absorption and spectral overlaps between various radiatively active species. In thermal part, problem of multiple emission sources can be solved efficiently by using net exchanged rate technique. Still, the cost of radiative transfer calculations with above improvements represents significant part of model CPU time and it is desirable to reduce it by suitable intermittent strategy. Unlike k-distribution method, broadband approach is especially suitable for implementing selective intermittency where rapidly varying cloud optical properties are updated at every model timestep, while slowly evolving gaseous transmissions only from time to time. Aim of this work is to propose, implement and test suitable intermittent strategies for ACRANEB scheme, taking into account particularities of shortwave and longwave radiative transfer calculations.

### References

Ritter B, Geleyn JF. 1992. A comprehensive radiation scheme for numerical weather
prediction models with potential applications in climate simulations. *Mon.
Weather Rev.* **120**: 303–325, doi:10.1175/1520-0493(1992)120 0303:ACRSFN
2.0.CO;2.

Geleyn JF, Hollingsworth A. 1979. An economical analytical method for the
computation of the interaction between scattering and line absorption of
radiation. *Contrib. Atmos. Phys.* **52**: 1–16.

Mašek J, Geleyn JF, Brožková R, Giot O, Achom HO, Kuma P. 2014. Single interval
shortwave radiation scheme with parameterized optical saturation and spectral
overlaps. Manuscript submitted for publication.

License
-------

Copyright (c) 2015 Peter Kuma

The text of the thesis is released under the
Creative Commons Attribution 4.0 International License
(https://creativecommons.org/licenses/by/4.0/).

The source code of programs in this repository
is released under the MIT License.

These terms do not apply to the following files:

- `ozone-absorption/ln840`
- `ozone-absorption/serdyuchenkogorshelev5digits.dat`

which are copyright of their respective authors, and:

- `img/natural-earth`

which is in the public domain (naturalearthdata.com).

### The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
