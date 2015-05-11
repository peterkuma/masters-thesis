Conclusion{-}
==========

The computational complexity of radiation schemes poses a continuing challenge
to NWP models and GCM. With the refining of model grid size and reduction
of time steps, this challenge is likely not going to diminish even with
improving hardware performance. Therefore, some forms of temporal and
spatial subsampling will still be necessary. If we can transition from
simple reduction of resolution or frequency to more elaborate approaches,
the models can benefit from increased accuracy, or allocate the time saved
to other components. The ACRANEB2 radiation scheme was devised to address
this issue by having only two spectral bands, allowing for its
global fields to be kept in memory and be reused between time steps
(otherwise the memory requirements would be prohibitive).
In the first place, the longwave intermittency of gaseous optical thickness
was implemented (not as part of this work), leading to tremendous computational
time saving, necessary for it to be a viable competitor to other schemes with
full intermittency. The implementation of shortwave intermittency
was envisioned, and it was the main objective of this work.

If it were not for the complicating factor of the changing solar zenith
angle, gaseous optical thickness of layers could be simply preserved
between time steps. However, this reality required us to evaluate the
dependency in the context of the broadband scheme. The effort involved
scripting of the single column model 
(the SCM itself was ready before this work commenced) in a preliminary analysis.
As could be
hinted from the theoretical formulae for gaseous optical thickness
(the modified Malkmus formula), this dependency is close to linear in the
log-log coordinates over large enough intervals.
By implementing the interpolation outside of the scheme,
it was found that the accuracy of interpolation is good enough
in a set of diverse example atmospheric profiles. The results of the
pre-analysis substantiated the case for implementation of shortwave intermittency
in this form in the code of the scheme itself.

Evaluation of results
in the limited-area NWP model ALADIN was the objective of the main analysis.
The desire to have a full picture of the effect on the model fields
lead to the development of a dumping code for the ALADIN model, giving
us an advantage over what would normally be possible with the existing
data export capabilities of the model and allowing for a comprehensive analysis
and plotting in the powerful statistical programming environment R.
Prepared were 6 experiments with different choices of the shortwave
intermittency period, and run on the NEC SX-9 supercomputer at CHMI.
The analysis revealed the impact on shortwave heating rate up to ±0.4\ K/day
(90 % confidence interval) at noon,
but this value was considerably less at other times of the day (with
less incoming solar radiation) and scaled with the length of the shortwave
intermittency period. A typical ‘tooth-like’ pattern was observed in time series,
indicating that with the start of a new intermittency period
(when gaseous optical thickness is fully calculated),
there is a strong reduction in error.
Somewhat surprisingly, it was found that the effect on longwave heating rate
error is present in an even greater magnitude (up to 0.6 K/day), but it does
not depend on the length of the shortwave intermittency period and accumulates
monotonically with time. It is hypothesised that it is the result of the innate
uncertainty (i.e. presence of noise) in temperature profiles in the model,
coupled with the strong dependency of longwave fluxes on temperature.
The distribution of heating rate error, which does not follow normal
distribution, can also skew our perception and the choice of the best statistic
to represent the error. This fact may warrant a further investigation.

Performance of the experiments was more difficult to evaluate due to three
issues: (1) the supercomputer at CHMI is normally shared by many jobs,
affecting even the
measured CPU time, (2) day/night segmentation of computation
in ACRANEB2 makes the CPU time not strictly monotonic with
shortwave intermittency period,
(3) SX-9 are vectorising processors, limiting the
applicability to other architectures.
The first issue was addressed by running the jobs in an exclusive (benchmark)
mode, and the second issue was address by disabling day/night segmentation
(but giving a note about how such a choice affects performance). The third
issue was not addressed, and the evaluation on other hardware is left to
users with access to other architectures.
Overall, the performance was found to be dependent on the shortwave
intermittency period, leading to time saving of up to 4\ % of the total model
run time. In order to put it into perspective, we compared performance to
accuracy side-by-side in a performance (cost) vs. accuracy chart. It shows
that the 95-% upper bound on the absolute shortwave heating rate error starts
to grow rapidly beyond about 30-min shortwave intermittency period,
making the trade-off between performance and accuracy likely unfavourable beyond
this period (but the exact choice depends on the relative viability
of other tuning options in the model).

Unfortunately, the assessment of longwave intermittency as set out in the
thesis assigment was not completed due to time constraints,
but in a smaller adjunct analysis we performed a comparison of
ACRANEB2 with the
radiation scheme FMR/RRTM (also available in the ALADIN model) in terms of their
accuracy with 1-h longwave and shortwave intermittency (ACRANEB2)
and 1-h full intermittency (FMR/RRTM).
The purpose was to demonstrate the detrimental
effect of full intermittency on heating rate accuracy, and how it can be
alleviated with the combination of longwave and shortwave intermittency.
The results were clearly in favour of partial intermittency in ACRANEB2,
but the analysis did not seek to compare performance aspects. The analysis
hinted an interesting degradation of accuracy in the lower troposphere
in ACRANEB2, which might be of interest in a continued development
of the longwave solver. Because of the limited scope of this adjunct analysis,
it was formulated as an appendix (Appendix\ \ref{appendix:acraneb2-vs-fmr}).
