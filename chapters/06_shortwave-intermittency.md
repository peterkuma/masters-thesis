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

### Monochromatic light

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

### Downward and upward broadband optical thickness

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


### Modified cosine of the zenith angle

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

### Dependece of optical thickness on the zenith angle

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

### Linear interpolation of optical thicknesses

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

### More cases

We performed the same analysis as above on multiple other cases:
a *cloudy atmosphere* with the same temperature and composition profiles,
*tropical*, *midlatitude summer* and *winter* atmospheres, and *subarctic summer*
and *winter* atmospheres[^more-cases].
The cloudy atmosphere did not differ significantly from the clear sky case.
The tropical, midlatitude and subarctic cases had error of the heating rate
within 0.5\ K/day.

[^more-cases]: Plots of all studied cases can be found in the
Additional Materials (see the end of this report).

Shortwave intermittency Implementetion in a 3D Model
------------------------------------------------

The results from the Single Colomn Model support the application of
shortwave intermittency in a 3-dimensional NWP model. This was implemented
in the ACRANEB2 scheme in the ALADIN[^2] model.

[^2]: ALADIN cycle 38.

In the 3D model, the radiative transfer scheme calculates radiative transfer
independently for each grid point of the model domain.

### Overview of the implementation

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

### Technical considerations

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

Analysis
--------

In order to evaluate accuracy and performance of the implementation of
shortwave intermittency, we performed a number of simulations (experiments)
with the ALADIN NWP model and analysed the results.

### Analysis Description

The simulations were performed on a domain covering Central Europe.
Values for offline analysis were sampled from a limited number of points
chosen evenly from the whole domain (Figure \ref{fig:domain-points}).
A 24-h summer day convective situation starting at 0:00 UTC,
29 May 2009 was chosen for the analysis.

For the purpose of gathering data from the selected points during model run,
tools called [nc_dump](https://github.com/peterkuma/nc_dump)[^nc-dump]
and [dump2h5](https://github.com/peterkuma/dump2h5)[^dump2h5] were developed.
These made it possible to export fields into NetCDF/HDF5 files, which were
subsequently analysed using a set of short programs made
in the statistical programming language R[^acraneb2-intermittency-analysis].

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

    * Shortwave gaseous transmissivities computed at every time step.
    * Longwave gaseous transmissivities computed once per 1\ h.
    * Calibration of longwave NER weights computed once per 3\ h.

2. **Shortwave Intermittency 1\ h**

    Shortwave intermittency enabled with 1\ h intermittency:

    * Based on *Shortwave Intermittency Base*.
    * Shortwave gaseous transmissivities computed once per 1\ h.

### Accuracy

In order to determine how the shortwave intermittency affects accuracy,
we looked at the global bias of heating rates, as well as the local error
and its statistical distribution. Figure \ref{fig:shortwave-heating-rate-error}
shows the error in heating rate of 1\ h shortwave intermittency
compared to no shortwave intermittency
(Exp. *Shortwave Intermittency 1\ h* vs. Exp. *Shortwave Intermittency Base*).
The local error was less than 0.2\ K/day in 95\ % of samples, and the global
error was on the order of 0.01\ K/day.

\begin{figure}
\centering
\includegraphics[width=10cm]{img/shortwave_heating_rate_error.pdf}\\
\includegraphics[width=\textwidth]{img/shortwave_heating_rate_error_timeseries.pdf}
\caption{
\textbf{Shortwave heating rate error of 1\ h shortwave intermittency.}
Shown is a global bias (\textbf{top}) and time series (\textbf{bottom})
of heating rate and 95\ \% confidence bands
of a model run with 1\ h shortwave intermittency compared to
no shortwave intermittency. The situation is a convective summer day of
29 May 2009 over Central Europe.
\label{fig:shortwave-heating-rate-error}
}
\end{figure}

<!-- The plot in Fig.\ \ref{fig:results} shows the average global heating rates
as calculated by the scheme *with* and *without* 2-h shortwave intermittency.
We can see that the difference is on the order of K/day, which is small
compared to the accuracy of the scheme. -->

### Performance

We measured performance of the new scheme using a 24-h run of the NWP model
on 4 CPUs of a NEC SX-9 supercomputer (100 GFLOPS per CPU). The decrease in total model
computation time with 2-h shortwave intermittency was 5\ %, which is in our experience
a significant reduction. See Tab.\ \ref{tab:performance} for details.

\begin{table}
\caption{
  \textbf{Impact of shortwave intermittency on the model computation time.}
  The table lists full NWP model computation time of 6-hour integration,
  180-s time step (case 2012-07-01T00:00:00Z) for a number of different
  configurations. Time is expressed relative to the baseline case.
  \textit{Note:} Memory increase due to shortwave intermittency was 2.4\ \%. 
  \label{tab:performance}
}
\begin{tabular*}{\hsize}{@{\extracolsep{\fill}} llr}
\textbf{Day/night computation} & \textbf{Shortwave intermittency} & \textbf{Time (relative)}\\
\hline
Yes                   & No                  & 1.00\\
No                    & No                  & 1.02\\
No                    & Yes, 0 h            & 1.08\\
No                    & Yes, 1 h            & 1.04\\
Yes                   & Yes, 0 h            & 1.05\\
Yes                   & Yes, 1 h            & \textbf{0.95}
\end{tabular*}
\end{table}

Conclusion
----------

shortwave intermittency is a viable approximation in plane-parallel broadband
radiative transfer schemes. By avoiding calculation of shortwave gaseous optical
thickness at every time step we gain a signification reduction in
computation time, while maintaining good accuracy of heating rates.

Linear interpolation of optical thickness on logarithic scale is
enough to account for the dependence of optical thickness on the relatively 
quickly-changing zenith angle for intermittency periods up to 2 hours long
(at least).