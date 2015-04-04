# Broadband approach as a framework for implementation of radiative transfer scheme with selective intermittency: Cost versus accuracy study

**This is a DRAFT.**

This repository contains source files and accompanying analyses
of the master's thesis
*Broadband approach as a framework for implementation of
radiative transfer scheme with selective intermittency:
Cost versus accuracy study*.

See [thesis.pdf](https://github.com/peterkuma/acraneb-thesis/raw/master/thesis.pdf).

## Assignment

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
