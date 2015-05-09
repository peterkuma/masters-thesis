Shortwave Intermittency in ACRANEB2
===================================

As the atmospheric gaseous composition and temperature and pressure profile
do not
change as quickly as the cloud cover, we can speed up radiative computations
by calculating gaseous optical thickness of layers less frequently than the rest
of the fields, while maintaining rapid response to changing cloud cover.
In other words, we can introduce a *shortwave intermittency*
period longer than the model time step during which the gaseous optical
thickness is reused.

In the thermal part of the spectrum, we can achieve this by simply maintaining
constant gaseous optical thickness during the intermittency period. In the
shortwave spectrum, however, the situation is complicated by the fact that optical
thickness depends on the solar zenith angle. It is therefore necessary to devise
a method of accounting for this change without the need to do a full
(computationally expensive) recalculation of optical thickness.

This chapter discusses the proposal, implementation and evaluation of shortwave
intermittency in the context of a single column model and the NWP model
ALADIN.

Theoretical Considerations
--------------------------

### Monochromatic Light

Let us first consider the simple case of monochromatic radiation passing through
a homogeneous atmospheric layer. Direct radiation passing at cosine of the
zenith angle $\mu_0$ is attenuated exponentially by the Beer's law:

$$
I(z) = I(z_0) \exp\left(-\frac{1}{\mu_0}k_e\Delta u\right)
$$

where $k_e$ is the mass extinction coefficient and $\Delta u$ is the mass of the
absorber per unit area.
Here, $(1/\mu_0) k_e\Delta u$ is the *optical path* through the layer.

In addition to *optical path*, we use the concept of *optical thickness*.
The *optical thickness* of a layer is commonly defined as the optical path
through
the layer in the vertical direction ($\mu_0 = 1$), but we note that this is
the same as normalizing the actual optical path by $\mu_0$:

$$
\tau := \tau(z_1, z_2; \mu_0=1) = k\Delta u = \mu_0 \left(\frac{1}{\mu_0}k\Delta u\right) = \mu_0 \tau(z_1, z_2; \mu_0)
$$

where $\tau(z_1, z_2; \mu_0)$ denotes optical path for radiation passing
at cosine of the zenith angle $\mu_0$. We use the same symbol $\tau$ for optical
thickness and optical depth, but stating its meaning explicitly where needed.
In the monochromatic case, both definitions are equivalent, but the latter
generalizes better to the broadband radiation treatment, where the Beer's
law no longer holds. We will therefore use this latter definition:

$$
\tau := \mu_0 \tau(z_1, z_2; \mu_0)
$$

### Downward and Upward Broadband Optical Thickness

<!-- We can define *broadband optical thickness* as optical path taken by parallel
radiation through a layer normalized by cosine of the zenith angle
$mu$. For monochromatic radiation, such definition is equivalent to the
traditional definition (optical path through a layer when $mu0 = 1$), and is
independent from $mu$, because optical path scales linearly with $mu0$.
In the broadband case, this is no longer true, as the increase of optical
path with $mu$ is sublinear. If we determine the dependence of optical 
thickness on $mu$, we can approximate optical thicknesses during the
intermittence period without a significant loss of accuracy. -->

In a broadband radiative transfer scheme, it is necessary to distinguish
downward and upward optical thickness of a layer. This is because the optical
thickness depends not only on the properties of the layer
(as in monochromatic case), but also the spectral composition of the radiation
entering the layer and the length of the path through the layer,
which determines the amount of spectral saturation.

The downward shortwave optical thickness is calculated for parallel radiation
coming directly from the Sun at a zenith angle $\theta$ and is equal
to the optical path through the layer normalized by cosine of the zenith
angle (which is proportional to the length of the path).

The upward shortwave optical thickness, on the contrary, is calculated for diffuse
radiation reflected from the surface, which does not have any associated
direction in the $\delta$-two stream approximation.
In this case, the dependence
on the zenith angle is only through its influence on the spectrum of the
incoming radiation, which has passed through the atmosphere as parallel
radiation at the given zenith angle.

The geometry of the downward case is depicted in Fig.\ \ref{fig:geometry}.


### Modified Cosine of the Zenith Angle

The actual angle at which radiation passes through an atmospheric
layer is not the same as the zenith angle. This is due to the sphericity
of the atmosphere, and is particularly true for high zenith angles
($\mu_0 \rightarrow 0$).

In order to transparently account for this effect, the ACRANEB2 scheme
uses a modified cosine of the zenith angle in place of $\mu$ [@masek2014]:

$$
\mu_0' = \frac{1}{
  \left(\left(\frac{a}{H}\mu_0\right)^2 + 2\frac{a}{H} + 1\right)^{1/2} -
  \frac{a}{H}\mu_0
}
$$

where $a$ is the radius of the Earth, and $H$ is the approximate height of the
atmosphere. The ratio $H/a$ was chosen to be a constant of 0.001324,
for which $\mu_0'(\mu_0 = 0) = 38.88$[^note]. This has an additional benefit of
preventing $1/\mu_0$ growing to infinity as $\mu_0 \rightarrow 0$ in numerical
calculations.

[^note]: It should be noted that the true angle at which radiation passes
through a layer depends on the layer height, but here an independent
scaling was used. It is also affected by refraction, which is omitted as well.

The modified cosine of the zenith angle is the natural coordiate for
studying the change of optical thickness with the position of the Sun in
the sky.

Analysis in a Single Column Model
---------------------------------

In order to empirically investigate dependence of broadband gaseous optical
thickness on the zenith angle, we used a single column model to calculate
optical thickness for varying values of the modified cosine of the zenith angle.
We analysed the result of multiple runs of the acra2 SCM model over a range of
$\mu_0$ values from the interval $\left[0, 1\right]$
to simulate shortwave gaseous optical thickness of
layers[^shortwave-intermittency].

[^shortwave-intermittency]: The full analysis is available at
\url{https://github.com/peterkuma/shortwave-intermittency}.

<!-- 
This depende
While the gaseous composition and temperature remain relatively constant,
effective solar gaseous optical thicknesses also depend of the zenith angle,
which is much more variable. However, this dependence can be accounted for by
interpolating gaseous optical thicknesses on the interval between the minimal
and maximal zenith an gles attained during a chosen intermittence period.-->

### Dependece of Optical Thickness on the Zenith Angle

<!-- In the monochromatic RTE, the depnedence of optical path on the inverse of
cosine of the zenith angle $\mu_0$ is linear:

$$
\Delta\delta(\mu0) = \frac{1}{\mu_0} k\Delta u
$$

However, this linear dependence no longer applies in the broadband model,
as the optical path increases at a diminishing rate with longer
optical paths compared to the monochromatic case. Instead, the actual
relationship depends in a complex way on the transmission through previous
layers and the transmission formula (e.g. the modified Malkmus model)
due to saturation of absorption at certain wavelengths.
 -->

The plot in Fig.\ \ref{fig:optical-depth} shows
the result for a clear sky atmosphere with 87 layers in standard and log-log
coordinates. The dependence is plotted as a function of the modified
cosine of the zenith angle (see above).
As you can see from the logarithmic plot, the dependence is
close to a power function (i.e. is linear in the logarithmic coordinates).
This suggest that a linear interpolation between extreme values 
of the zenith angle in an intermittency period could yield
accurate enough results. Similar relatiotionship was observed in cloudy
atmosphere and a number of additional cases.

\begin{figure}
\centering
\includegraphics[width=12cm]{img/intermittence-geometry.pdf}
\caption{
  \textbf{Geometry of the shortwave intermittency problem (downward).}
  (1) At the beginning of the
  intermittency period, solar radiation passes through a plane-parallel
  atmospheric layer
  at zenith angle $\theta_1$. (2) As the Sun rises to zenith angle $\theta_2$,
  the broadband optical thickness (as per our definition)
  of the layer changes from $\tau_1$ to $\tau_2$. Note that $\tau_2 > \tau_1$,
  as the broadband optical thickness equals to optical path normalized by
  $\mu = cos(\theta)$, which is proportional to the length of the path.
  \label{fig:geometry}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=7cm]{img/optical_thickness_downward.pdf}
\includegraphics[width=7cm]{img/optical_thickness_upward.pdf}\\
\includegraphics[width=7cm]{img/optical_thickness_downward_log.pdf}
\includegraphics[width=7cm]{img/optical_thickness_upward_log.pdf}
\caption{
  \textbf{Optical thickness of layers as a function of the modified
  cosine of the zenith angle.} Downward optical thickness in ordinary
  (\textbf{top-left}) and log-log coordinates (\textbf{bottom-left}),
  and upward optical thickness in ordinary (\textbf{top-right}) and log-log
  coordinates (\textbf{bottom-right}).
  Lines are labeled with layer numbers. Note that the relationship is
  almost linear in the log-log coordinates.
  \label{fig:optical-depth}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=10cm]{img/heating_rate_shortwave_difference.pdf}\\
\includegraphics[width=10cm]{img/heating_rate_shortwave_relative_difference.pdf}
\caption{
  \textbf{Heating rate difference between the reference and linearly
  interpolated optical thicknesses at 15$^\circ$ steps of the zenith angle.}
  Plots show absolute difference in heating rate (\textbf{top}),
  and relative difference in heating rate in per cent (\textbf{bottom}).
  \label{fig:heating-rate}
}
\end{figure}

### Linear Interpolation of Optical Thickness

As justified by the empirical analysis of optical thickness dependence
on the zenith angle, we performed an experiment with the single column
model where the log optical thicknesses were linearly interpolated
with respect to log of the modified cosine of the zenith angle.
The Fig.\ \ref{fig:heating-rate} shows the result for a clear-sky atmosphere,
and a choice of shortwave intermittency interval of $\Delta \theta = 15^\circ$ 
(1\ h on the equator on equinox). The heating rates were compared to the
reference (non-interpolated) case. The difference in heating rates was
the most significant for high zenith angles (low $\cos(\mu)$),
when the change in the zenith angle corresponds to a large change in
the cosine of the zenith angle. The difference was within 0.1\ K/day (5 %)
for all but the top layers, which is an acceptable loss of accuracy compared
to the rest of the broadband radiative scheme.

### More Cases

We performed the same analysis as above on multiple other cases:
a *cloudy atmosphere* with the same temperature and composition profiles,
*tropical*, *midlatitude summer* and *winter* atmospheres, and *subarctic summer*
and *winter* atmospheres[^more-cases].
The cloudy atmosphere did not differ significantly from the clear sky case.
The tropical, midlatitude and subarctic cases had error of the heating rate
within 0.5\ K/day.

[^more-cases]: Plots of all studied cases can be found in the
Additional Materials (see the end of this report).

Shortwave Intermittency Implementetion in a 3D Model
------------------------------------------------

The results from the Single Colomn Model support the application of
shortwave intermittency in a 3-dimensional NWP model. This was implemented
in the ACRANEB2 scheme in the ALADIN[^2] model.

[^2]: ALADIN cycle 38.

In the 3D model, the radiative transfer scheme calculates radiative transfer
independently for each grid point of the model domain.

### Overview of the Implementation

At the beginning of an intermittency period
(*full* radiative time step):

1. Calculate the mimimum and maximum values of the zenith angle attained at
   any time step during the intermittency period. Store the zenith angles
   (the extreme values as well as the values at all time steps) in global
   arrays (preserved across time steps).

2. Calculate shortwave optical thickness as usual for the two extreme values
   the zenith angle. Store (the logarithm of) the optical thicknesses
   in global arrays.

At every time step *within* the intermittency period
(*partial* radiative time step):

1. Retrieve current zenith angle from the global array (ignoring the
   zenith angle supplied by the model), and continue all computations
   with this zenith angle.

2. Calculate optical thicknesses by interpolating between the extreme optical
   thicknesses as stored in the global arrays.

### Technical Considerations

There were a number of additional technical considerations which needed to be
taken into account when implementing shortwave intermittency in a 3D model:

1. **Solar declination.** Solar declination varies during the intermittency
   period. In our case, the model does no provide the scheme with solar
   declination for the subsequent time steps, nor a straighforward way
   of calculating it[^3].
   In order to
   simplify implementation, solar declination within intermittency period
   is kept constant. This is justified since the length of the intermittency
   period is not expected to be chosen long enough for the variation of
   solar declination to be important.

[^3]: Without copying a significat amount of code.

2. **Storage requirements.** Shortwave intermittency requires us to store
   fields of downward and upward optical thickness at two extreme values of
   the zenith angle. This results in four 3D global fields of optical
   thickness and a number of 2D global fields of zenith angles
   to be kept in the main memory between time steps.

3. **Day/night segmentation.** The ACRANEB2 scheme performs calculations
   on blocks of grid points in a vectorizable form[^4]. The shortwave computations
   are only performed on segments of grid points where the Sun is in the sky.
   This selection has to be extended with grid points where the zenith angle
   is positive at any time during the intermittency period.

4. **Modularization.** The shortwave intermittency implementation required more
   modularization in terms of decoupling the shortwave and longwave
   computations of optical thickness.

[^4]: In the sense of performing an operation on a sequence of values
      simultaneously by a single processor
      (on processors which support such a feature).

Analysis Description
--------------------
\label{sec:shortwave-intermittency-analysis-description}

In order to evaluate accuracy and performance of the implementation of
shortwave intermittency, we performed a number of simulations (experiments)
with the ALADIN limited-area NWP model and analysed the results for accuracy
and performance.

The simulations were performed on a domain covering Central Europe
with coupling to the ARPEGE global model. The horizontal mesh size was
4.7\ km with 87 vertical layers and time step of 3\ min.
Values for offline analysis were sampled from a limited number of points
chosen evenly from the whole domain (Figure \ref{fig:domain-points}).
A 24-h summer day convective situation starting at 0:00 UTC,
29 May 2009 was chosen for the analysis.

For the purpose of gathering data from the selected points during model runs,
tools called [nc_dump](https://github.com/peterkuma/nc_dump)[^nc-dump]
and [dump2h5](https://github.com/peterkuma/dump2h5)[^dump2h5] for the
ALADIN model were developed.
These made it possible to export fields into NetCDF/HDF5 files, which were
subsequently analysed using a set of short programs made
in the statistical programming language R[^acraneb2-intermittency-analysis].

The runs were made on 8 CPUs of the NEC SX-9 supercomputer
(100 GFLOPS per CPU),
and performance was measured as the CPU time in an exclusive (benchmark)
mode of the machine, in order to avoid interference with other concurrent tasks
(which would be substantial). The SX-9 processors rely heavily on code
vectorisation, and as such may be less representative of other more common
architectures. Multithreading in the ALADIN model is implemented using OpenMP,
distributing computation on blocks of grid points to the threads.

[^acraneb2-intermittency-analysis]: The full analysis is
available at \url{https://github.com/peterkuma/acraneb2-intermittency-analysis}.

[^nc-dump]: https://github.com/peterkuma/nc_dump
[^dump2h5]: https://github.com/peterkuma/dump2h5

\begin{figure}
\centering
\includegraphics[width=9cm]{img/domain-points_edited.pdf}
\caption{
\textbf{Points on the model domain sampled for offline analysis.}
Data from the points shown were saved during model runs for later (offline)
analysis at every time step of the simulation.
\label{fig:domain-points}
}
\end{figure}

### Experiments

The following experiments were performed:

1. **Shortwave Intermittency Base**

    Base configuration for shortwave intermittency evaluation:

    * Shortwave gaseous optical thickness computed at every time step.
    * Longwave gaseous optical thickness computed once per 1\ h.
    * Calibration of longwave NER weights computed once per 3\ h.

2. **Shortwave Intermittency 6-min, 15-min, 30-min, 1-h, 90-min, 2-h**

    Shortwave intermittency enabled with 6-min, 15-min, 30-min, 1-h, 90-min, 2-h
    intermittency period (resp.):

    * Based on *Shortwave Intermittency Base*.
    * Shortwave gaseous optical thickness computed once per
    6\ min, 15\ min, 30\ min, 1\ h, 90\ min, 2\ h (resp).

Results
-------

### Accuracy

In order to determine how shortwave intermittency affects accuracy,
we looked at the global bias in heating rate, as well as the local error
and its statistical distribution. The shortwave intermittency runs were
compared to the base configuration with no shortwave intermittency.
The impact on shortwave heating rates and longwave heating rates can
be seen in Figure\ \ref{fig:shortwave-heating-rate-error}
and Figure\ \ref{fig:longwave-heating-rate-error}, resp.
The impact on bias was negligible ($<\ 0.2\ \text{K/day}$)
in both shortwave and longwave heating rates.

It should be noted that in the time series plot, the time axis is in UTC,
therefore domain points are not synchronised with respect to local solar time.

From the shortwave heating rate error time series plot, it is clear
that the magnitude of error is the greatest during the day (up to
$0.4\ \text{K/day}$ with 2-h shortwave intermittency), whereas during
the night the error is zero. At the ‘full’ steps when shortwave gaseous
optical depths are calculated, the error drops markedly, giving rise
to a tooth-like pattern,
but a non-reducible error accumaltes with time as the run diverges
from the reference run.

Shortwave intermittency has an impact on the longwave heating rates,
leading to error of about 0.6\ K/day in the second half of the simulation,
i.e. greater than in shortwave heating rates.
This is likely due the strong sensitivity of longwave fluxes on the temperature
profile.

<!-- 
shows the error in heating rate of 1\ h shortwave intermittency
compared to no shortwave intermittency
(Exp. *Shortwave Intermittency 1\ h* vs. Exp. *Shortwave Intermittency Base*).
The local error was less than 0.15\ K/day in 90\ % of samples, and the global
error was on the order of 0.05\ K/day (mean absolute error).
 -->

<!-- The plot in Fig.\ \ref{fig:results} shows the average global heating rates
as calculated by the scheme *with* and *without* 2-h shortwave intermittency.
We can see that the difference is on the order of K/day, which is small
compared to the accuracy of the scheme. -->

### Performance

The total model run time of shortwave intermittency experiments is displayed in
Figure\ \ref{fig:shortwave-intermittency-performance}. The time reduction was up
to about 5\ % with the longest shortwave intermittency period (2\ h).
There is a diminishing gain in performance with longer intermittency periods,
as discussed theoretically in Section\ \ref{sec:computational-intermittency}.
The 6-min shortwave intermittency run was longer than the base run, which
is expected as in every ‘full’ step of shortwave intermittency gaseous
optical thickness is calculated twice
(for the start and the end of the forthcoming intermittency
period), and the implementation only introduces overhead compared to the
base configuration.

**Note:** It has to be noted that the performance analysis had to be performed with
day/night segmentation
disabled, as it causes the model run time to be non-monotonic with the length
of the shortwave intermittency interval. With day/night segmentation enabled,
time reduction scales up to 96\ % in the 2-h shortwave intermittency case,
whereas in the results presented, the reduction is up to 94\ %
(i.e. more pronounced). We belive that this choice is justified by the improved
clarity of interpretation of the results.

Figure\ \ref{fig:shortwave-intermittency-performance-accuracy}
compares performance and accuracy of the model runs. As such, it is important
in deciding the optimal choice of shortwave intermittency period. The exact
choice depends on the presence of other performance tuning options
in the whole model configuration,
as an option with the least error incured per reduction in time should
be chosen. Therefore, depending on the circumstances it may be viable
to increase the shortwave intermittency
period even over 1\ h, although after this point the error starts to grow
more rapidly with respect to any time reduction. Moreover, there is a hard bound
on the time saved by shortwave intermittency – when all but the first time step
are ‘intermittent’. From these results, we can expect it to be about 6–7\ %.
Users of the radiation scheme are therefore advised to use this chart
as a guide in deciding the optimum configuration in their particular situation.

We should remark that the error observed in the runs was not normally
distributed. Rather, many local errors were clustered around zero, descreasing
gradually in number towards the 95-th percentiles, with the rest distributed
in heavy-tails. Therefore, we chose the 90\ % confidence intervals and the mean
absolute error (MAE) to present our results instead of the more traditional
root-mean-square error (RMSE), which would place very strong emphasis on
the outliers and could be misleading due to the expectation of normal
distribution. However, we realise that the presence of outliers is not a
desirable property, but a more complex analysis would need to be performed
in order to determine what their source is and whether they can be eliminated.

<!-- Memory increase due to shortwave intermittency was about 2.4\ \%. -->

\begin{figure}
\centering
\includegraphics[width=10cm]{img/shortwave_heating_rate_error.pdf}\\
\includegraphics[width=\textwidth]{img/shortwave_heating_rate_error_timeseries.pdf}
\caption{
\textbf{Impact of shortwave intermittency on shortwave heating rate error.}
Shown is a global bias (\textbf{top}) and time series (\textbf{bottom})
of heating rate and 90\ \% confidence bands
of 24-h model runs with 6\ min, 15\ min, 1\ h, 1.5\ h and 2\ h
shortwave intermittency compared to no shortwave intermittency
(bands in progressively lighter shades, resp.).
 In the time series plot
heating rate error is weighted by pressure thickness of layers (by resampling).
The situation is a convective summer day of 29 May 2009 over Central Europe.
\label{fig:shortwave-heating-rate-error}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=10cm]{img/longwave_heating_rate_error.pdf}\\
\includegraphics[width=\textwidth]{img/longwave_heating_rate_error_timeseries.pdf}
\caption{
\textbf{Impact of shortwave intermittency on longwave heating rate error.}
Shown is a global bias (\textbf{top}) and time series (\textbf{bottom})
of heating rate and 90\ \% confidence bands
of 24-h model runs with 6-min, 15-min, 30-min, 1-h, 1.5-h and 2-h
shortwave intermittency compared to no shortwave intermittency
(bands in progressively lighter shades, resp.). In the time series plot
heating rate error is weighted by pressure thickness of layers (by resampling).
The situation is a convective summer day of 29 May 2009 over Central Europe.
\label{fig:longwave-heating-rate-error}
}
\end{figure}


\begin{figure}
\centering
\includegraphics[height=6cm]{img/performance_plot.pdf}
\caption{
\textbf{Shortwave intermittency performance.}
Total model run time of shortwave
intermittency runs relative to no shortwave intermittency (‘Base’).
Run time was measured as CPU time in a benchmark (exclusive) mode
on 8 CPUs of NEC SX-9 (100 GFLOP per CPU).
\label{fig:shortwave-intermittency-performance}
}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=\textwidth]{img/performance_accuracy_plot.pdf}
\caption{
\textbf{Shortwave intermittency performance vs. accuracy.}
Total model run time and mean absolute heating rate error (\textbf{solid line})
of shortwave intermittency runs, relative
to no shortwave intermittency. Shown
is the 95-\% upper bound of the absolute heating rate error
across domain sample points and time steps (\textbf{dashed line}).
Heating rate error is weighted by pressure thickness of layers.
Run time was measured as CPU time in a benchmark (exclusive) mode
on 8 CPUs of NEC SX-9 (100 GFLOP per CPU).
\label{fig:shortwave-intermittency-performance-accuracy}
}
\end{figure}
