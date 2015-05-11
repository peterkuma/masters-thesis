Abstrakt{-}
========

\fontspec{Minion Pro}

Výpočtová náročnosť radiačných schém v numerických predpovedných modeloch
počasia (NWP) neumožňuje robiť plné radiačné
výpočty v každom časovom kroku a bode mriežky modelu.
Tradične to modely riešia volaním radiačnej schémy s redukovaným časovým
alebo priestorovým rozlíšením, prípadne so škálovaním výsledných tokov
na zmenu teplotného profilu a slnečného zenitálneho uhla. V dôsledku toho
je zanedbaná variabilita oblačnosti a dochádza tak k značnej chybe.
V krátkovlnnom spektre sú relatívne pomaly sa meniace plynové
optické vlastnosti jednou z najdrahších časí na výpočet. Preto navrhujeme
modifikáciu krátkovlnnej časti širokospektrálnej radiačnej schémy
ACRANEB2 na interpoláciu plynových optických hrúbok vrstiev vzhľadom na
slnečný zenitálny uhol vrámci zvolenej intermitentnej periódy,
zatiaľ čo vývoj oblačnosti je stále zachytený pomocou výpočtu ich
optických vlastností a výsledných tokov cez
adding metódu v každom časovom kroku modelu. V tejto práci používame
jednostĺpcový model na štúdium závislosti krátkovlnnej plynovej optickej
hrúbky na slnečnom zenitálnom uhle, ukazujeme, že táto závislosť
môže byť aproximovaná s dobrou presnosťou, implementujeme túto aproximáciu
v radiačnej schéme ACRANEB2 a vyhodnocujeme dopad na presnosť ohrevu
vrstiev a dĺžku behu modelu v 24 hodinovej simulácii regionálneho NWP
modelu ALADIN. Ukazujeme, že táto úprava vedie k úspore času do 4\ %
celkového času behu modelu a spôsobuje chybu krátkovlnných ohrevu vrstiev
do ±0.4 K/deň na poludnie (90\ % konfidenčný interval) a 0.06 K/deň
(stredná abs. chyba) cez celú doménu a časovú periódu a že
výkon aj presnosť sa škálujú s dĺžkou intermitentnej periódy.
Tento vzťah je zhrnutý v porovnaní ceny a presnosti, poskytujúci
potencionálnym užívateľom usmernenie pri voľbe optimálnej intermitentnej
periódy pri daných okolnostiach. Navrhovaná zmena sa stala súčasťou
radiačnej schémy ACRANEB2 implementovanej v balíku ALARO-1 verzia A
a od januára 2015 je v operatívnom použití v modeli ALADIN/ČHMÚ.

**Kľúčové slová:** krátkovlnný radiačný kód, cena verzus presnosť,
širokospektrálny prístup, čiastočná intermitencia, plynová optická hrúbka

\fontfamily{\familydefault}\selectfont

Abstract{-}
========

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
the modification results in time saving of up to 4\ % of total model run time
and incur error on shortwave heating rates up to ±0.4 K/day at noon
(90\ % confidence interval)
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
