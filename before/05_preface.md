Preface {-}
===========

My involvement in this work began in 2011 with a proposal by Jean-Francois
Geleyn entitled ‘General gaseous transmission functions for radiative transfer
– a cost vs. accuracy study’. The aim was to work on parametrisation of
gaseous transmission functions,
which were undergoing an overhaul by a joint work of Jean-Francois Geleyn
and Ján Mašek. I was tasked
with the assessment of the modifications in terms of accuracy. At the time I was
forced to interrupt my studies and my involvement in the project
due to continuing health problems. My involvement resumed in 2014,
when I attended
a second stay at CHMI to participate on implementation of shortwave
intermittency in the ACRANEB2 radiation scheme under the supervision of
Ján Mašek. This was completed with encouraging results, and this thesis
discusses theoretical and practical aspects of the work. Unfortunately,
some of the progress was hindered by the intractability of the radiation
scheme's source code, and limited availability of up-to-date and
comprehensive documentation (with the exception of Ján Mašek's excellent
article on the shortwave part, available since late 2014).

The majority of this work was done in the context of numerical weather
prediction, because this is the context in which development of
ACRANEB2 is done primarily. This had implications on the assessment of results,
which were studied for any impact on heating rate in a limited-area domain
over the period of 24 hours. Any application in simulation of climate
(either in regional models or GCM) would at least require assessment of fluxes
at top-of-the-atmosphere and near surface.

The intended audience of this work is diverse. (1) The practical results are
important to those who wish to use the ACRANEB2 radiation scheme in their
model runs. Especially the performance vs. accuracy comparison can serve
as a guide to setting an optimal shortwave intermittency period, or
to decide whether to use the shortwave intermittency option at all.
(2) The discussion of
theoretical concepts related to radiation schemes and ACRANEB2 can be of use
to those who want to get involved with the radiation scheme. (3) Discussion
of shortwave intermittency implementation and its impact on accuracy and
performance can help those who would wish to implement a similar method
in a different radiation scheme. (4) Supplementary programs developed as
part of this work can be used by those working on the ALADIN model in general
(nc_dump) or the ACRANEB2 radiation scheme
(ACRANEB2 data analysis and plotting scripts).

This work was done adhering to the principles of open science whenever
possible: the text of this thesis and data is released under
the Creative Commons Attribution 4.0 International License, and the source
code produced is released under the MIT license
(with the exception of contributions to the ALADIN model code base).
Both licenses allow sharing
and modification for any purpose, incl. commercial use.
Unfortunately, the source code of ALADIN is not licensed freely,
precluding the publication of contributions. I would like to use this preface
to express my hope that the situation will soon improve,
in particular in Earth sciences, where much of the work done is still
proprietary, even though often funded from public resources, and where there
is a great need for transparency and accountability due to the close relation
to high-stake global problems.

I would like to thank
\fontspec{Minion Pro} Ivan Bašták Ďurán \fontfamily{\familydefault}\selectfont
for getting me involved in the work
on the ACRANEB2 radiation scheme, Jean-Francois Geleyn for giving me the
opportunity to work on this project, for his leadership and advice,
RC LACE for funding my two ‘stays’ at CHMI,
the opponent (not known to me at the time of writing) for his/her time spent
on evaluating this thesis,
and most sincerely to Ján Mašek for his devoted, patient and kind
support in most aspects of my work on ACRANEB2 and beyond. In January 2015,
Jean-Francois Geleyn sadly passed away due to an
illness, investing some of his last time to help Ján Mašek finish an article
in preparation about the shortwave part of ACRANEB2.
I would like to dedicate this thesis to his memory, although
the quality of the content of my thesis may compare humbly to the high
standards of his scientific work.
