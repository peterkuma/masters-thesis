Comparison of Intermittency in ACRANEB2 and FMR
===============================================

In this appendix we present the results of an analysis comparing
intermittency in ACRANEB2 and FMR [@fouquart1980][^appendix-note].
Both radiation schemes are available
in the limited-area model ALADIN. Therefore, it was possible to compare
longwave and shortwave intermittency in ACRANEB2 to full intermittency in FMR,
relative to their respective base configurations with no intermittency.
This analysis is limited in scope, as we compared only
1-h longwave and shortwave intermittency in ACRANEB2 to 1-h full intermittency
in FMR (fluxes assumed constant within the intermittency period).
The method of analysis and situation were identical to the one described in
Section\ \ref{sec:shortwave-intermittency-analysis-description}.
The purpose of this analysis was to contrast the effect of full intermittency
and partial intermittency of the same length on heating rate error.

[^appendix-note]: The results of this analysis are presented in appendix,
because the limited scope would not warrant a chapter on its own. Moreover,
a proper discussion would require the introduction of a number of concepts
related to longwave intermittency in ACRANEB2, for which documentation is yet
to be available via a dedicated article (in preparation at the time of writing).

In total 4 experiments were performed:

1. **Intermittency Base**
    
    Base configuration of ACRANEB2 with longwave and shortwave intermittency
    disabled.

2. **Intermittency 1 h**

    ACRANEB2 with longwave and shortwave intermittency enabled with 1-h
    period.

    * Based on Intermittency Base.
    * Longwave and shortwave gaseous transmissivities computed once per 1 h.
    * Longwave ‘bracketing’ weights computed once per 3 h.

3. **Intermittency FMR Base**

    Base configuration of FMR with intermittency disabled.

4. **Intermittency FMR 1 h**

    FMR with full intermittency enabled with 1-h period.

    * Based on Intermittency FMR Base.
    * Fluxes computed once per 1 h.

Figure\ \ref{fig:acraneb2-vs-fmr-longwave-heating-rate-error}
and \ref{fig:acraneb2-vs-fmr-shortwave-heating-rate-error}
show the results obtained from these experiments.
It is clear that the longwave and shortwave intermittency implementation
in ACRANEB2 is superior to full intermittency in FMR with the same choice of
intermittency period. A notable exception are layers below 750\ hPa
in the longwave spectrum, which would warrant an additional investigation.
It should be stressed, however, that this is not a fair
comparison in terms of performance, as in this case the 1-h intermittency
run of ACRANEB2 takes about 20\ % longer than FMR.

\begin{figure}
\centering
\includegraphics[width=10cm]{img/acraneb2-vs-fmr/longwave_heating_rate_error.pdf}\\
\includegraphics[width=\textwidth]{img/acraneb2-vs-fmr/longwave_heating_rate_error_timeseries.pdf}
\caption{
\textbf{Impact of intermittency in ACRANEB2 and FMR on longwave heating rate error.}
Shown is the vertical profile (\textbf{top}) and time series (\textbf{bottom})
of heating rate error and 90\ \% confidence bands
of 1-h intermittency runs of ACRANEB2
(\textbf{darker shade}, \textbf{solid line}) and
FMR (\textbf{lighter shade}, \textbf{dashed line}). In the time series plot
heating rate error is weighted by pressure thickness of layers (by resampling).
The situation is a convective summer day of 29 May 2009 over Central Europe.
\label{fig:acraneb2-vs-fmr-longwave-heating-rate-error}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=10cm]{img/acraneb2-vs-fmr/shortwave_heating_rate_error.pdf}\\
\includegraphics[width=\textwidth]{img/acraneb2-vs-fmr/shortwave_heating_rate_error_timeseries.pdf}
\caption{
\textbf{Impact of intermittency in ACRANEB2 and FMR on shortwave heating rate error.}
Shown is the vertical profile (\textbf{top}) and time series (\textbf{bottom})
of heating rate and 90\ \% confidence bands
of 1-h intermittency runs of ACRANEB2
(\textbf{darker shade}, \textbf{solid line}) and
FMR (\textbf{lighter shade}, \textbf{dashed line}). In the time series plot
heating rate error is weighted by pressure thickness of layers (by resampling).
The situation is a convective summer day of 29 May 2009 over Central Europe.
\label{fig:acraneb2-vs-fmr-shortwave-heating-rate-error}
}
\end{figure}
