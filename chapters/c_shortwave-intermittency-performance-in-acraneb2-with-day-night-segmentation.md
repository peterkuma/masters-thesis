Shortwave Intermittency Performance in ACRANEB2 with Day/Night Segmentation
===========================================================================
\label{appendix:shortwave-intermittency-performance-with-dn}

This appendix presents the results of shortwave intermittency performance
in ACRANEB2 with day/night segmentation enabled. As such, they belong
to Chapter\ \ref{chap:shortwave-intermittency-in-acraneb2}, but we belive
it would be at the expense of clarity if put there. As noted in
Section\ \ref{sec:shortwave-intermittency-performance}, day/night segmentation
smears the performance results of shortwave intermittency, and this is
in a way which depends on the domain and simulation time period assessed.
For completeness, the results with day/night segmentation enabled
for the situation described in
Chapter\ \ref{chap:shortwave-intermittency-in-acraneb2} are in
Figure\ \ref{fig:shortwave-intermittency-performance-dn} and
Figure\ \ref{fig:shortwave-intermittency-performance-accuracy-dn}.

\begin{figure}
\centering
\includegraphics[height=6cm]{img/performance_plot_dn.pdf}
\caption{
\textbf{Shortwave intermittency performance (with day/night segmentation).}
Total model run time of shortwave
intermittency runs relative to no shortwave intermittency (‘Base’).
Run time was measured as CPU time in a benchmark (exclusive) mode
on 8 CPUs of NEC SX-9 (100 GFLOP per CPU).
\label{fig:shortwave-intermittency-performance-dn}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=\textwidth]{img/performance_accuracy_plot_dn.pdf}
\caption{
\textbf{Shortwave intermittency performance vs. accuracy (with day/night segmentation).}
Total model run time and mean absolute heating rate error (\textbf{solid line})
of shortwave intermittency runs, relative
to no shortwave intermittency. Shown
is the 95-\% upper bound of the absolute heating rate error
across domain sample points and time steps (\textbf{dashed line}).
Heating rate error is weighted by pressure thickness of layers.
Run time was measured as CPU time in a benchmark (exclusive) mode
on 8 CPUs of NEC SX-9 (100 GFLOP per CPU).
\label{fig:shortwave-intermittency-performance-accuracy-dn}
}
\end{figure}
