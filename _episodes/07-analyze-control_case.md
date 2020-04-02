---
title: "Analyze and visualize control model outputs"
teaching: 0
exercises: 0
questions:
- "What is a control run?"
- "What is a climatology?"
- "How to compare model outputs with a climatology?"
objectives:
- "Learn about control run"
- "Learn to compare a control run with a climatology"
keypoints:
- "control run"
- "climatology"
---

*   [What is a control run?](#what-is-a-control-run)
	* [What does our control run contain?](#what-does-our-control-run-contain)
	* [Analyze and Visualize](#analyze-and-visualize)
*   [What is a climatology?](#what-is-a-climatology)
	*   [SPARC Climatology](#sparc-climatology)
*   [Compare the control run to the SPARC climatology](#compare-the-control-run-to-the-sparc-climatology)
	*   [Methodology](#methodology)
	*   [Exercice](#exercice) ([check the deadline!](#deadline))

# What is a control run?

A control run is a simulation undertaken with a model with known conditions for the ocean, atmosphere, etc.

In our case, the control run will be used as a reference to evaluate the impacts of different scenarios 
(changes are made to the atmospheric composition such as CO2 concentration increase, etc.).

The control run is a representative of the conditions in years 2000 i.e. similar to today's climate. The idea was 
to generate the restart files (snapshot of the model state at a given point in time) from where you will be able to 
start your future experiments at year 9 and further compare your simulation outputs with the control run for the following years.


## What does our control run contain?

The control run model outputs are accessible from the Jupyterhub; for instance, from a Terminal:

~~~
ls $HOME/shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/
~~~
{: .language-bash}

~~~

F2000climo.f19_g17.control.cam.h0.0001-01.nc  F2000climo.f19_g17.control.cam.h0.0005-10.nc  F2000climo.f19_g17.control.cam.h0.0010-07.nc
F2000climo.f19_g17.control.cam.h0.0001-02.nc  F2000climo.f19_g17.control.cam.h0.0005-11.nc  F2000climo.f19_g17.control.cam.h0.0010-08.nc
F2000climo.f19_g17.control.cam.h0.0001-03.nc  F2000climo.f19_g17.control.cam.h0.0005-12.nc  F2000climo.f19_g17.control.cam.h0.0010-09.nc
F2000climo.f19_g17.control.cam.h0.0001-04.nc  F2000climo.f19_g17.control.cam.h0.0006-01.nc  F2000climo.f19_g17.control.cam.h0.0010-10.nc
F2000climo.f19_g17.control.cam.h0.0001-05.nc  F2000climo.f19_g17.control.cam.h0.0006-02.nc  F2000climo.f19_g17.control.cam.h0.0010-11.nc
F2000climo.f19_g17.control.cam.h0.0001-06.nc  F2000climo.f19_g17.control.cam.h0.0006-03.nc  F2000climo.f19_g17.control.cam.h0.0010-12.nc
F2000climo.f19_g17.control.cam.h0.0001-07.nc  F2000climo.f19_g17.control.cam.h0.0006-04.nc  F2000climo.f19_g17.control.cam.h0.0011-01.nc
F2000climo.f19_g17.control.cam.h0.0001-08.nc  F2000climo.f19_g17.control.cam.h0.0006-05.nc  F2000climo.f19_g17.control.cam.h0.0011-02.nc
F2000climo.f19_g17.control.cam.h0.0001-09.nc  F2000climo.f19_g17.control.cam.h0.0006-06.nc  F2000climo.f19_g17.control.cam.h0.0011-03.nc
F2000climo.f19_g17.control.cam.h0.0001-10.nc  F2000climo.f19_g17.control.cam.h0.0006-07.nc  F2000climo.f19_g17.control.cam.h0.0011-04.nc
F2000climo.f19_g17.control.cam.h0.0001-11.nc  F2000climo.f19_g17.control.cam.h0.0006-08.nc  F2000climo.f19_g17.control.cam.h0.0011-05.nc
F2000climo.f19_g17.control.cam.h0.0001-12.nc  F2000climo.f19_g17.control.cam.h0.0006-09.nc  F2000climo.f19_g17.control.cam.h0.0011-06.nc
F2000climo.f19_g17.control.cam.h0.0002-01.nc  F2000climo.f19_g17.control.cam.h0.0006-10.nc  F2000climo.f19_g17.control.cam.h0.0011-07.nc
F2000climo.f19_g17.control.cam.h0.0002-02.nc  F2000climo.f19_g17.control.cam.h0.0006-11.nc  F2000climo.f19_g17.control.cam.h0.0011-08.nc
F2000climo.f19_g17.control.cam.h0.0002-03.nc  F2000climo.f19_g17.control.cam.h0.0006-12.nc  F2000climo.f19_g17.control.cam.h0.0011-09.nc
F2000climo.f19_g17.control.cam.h0.0002-04.nc  F2000climo.f19_g17.control.cam.h0.0007-01.nc  F2000climo.f19_g17.control.cam.h0.0011-10.nc
F2000climo.f19_g17.control.cam.h0.0002-05.nc  F2000climo.f19_g17.control.cam.h0.0007-02.nc  F2000climo.f19_g17.control.cam.h0.0011-11.nc
F2000climo.f19_g17.control.cam.h0.0002-06.nc  F2000climo.f19_g17.control.cam.h0.0007-03.nc  F2000climo.f19_g17.control.cam.h0.0011-12.nc
F2000climo.f19_g17.control.cam.h0.0002-07.nc  F2000climo.f19_g17.control.cam.h0.0007-04.nc  F2000climo.f19_g17.control.cam.h0.0012-01.nc
F2000climo.f19_g17.control.cam.h0.0002-08.nc  F2000climo.f19_g17.control.cam.h0.0007-05.nc  F2000climo.f19_g17.control.cam.h0.0012-02.nc
F2000climo.f19_g17.control.cam.h0.0002-09.nc  F2000climo.f19_g17.control.cam.h0.0007-06.nc  F2000climo.f19_g17.control.cam.h0.0012-03.nc
F2000climo.f19_g17.control.cam.h0.0002-10.nc  F2000climo.f19_g17.control.cam.h0.0007-07.nc  F2000climo.f19_g17.control.cam.h0.0012-04.nc
F2000climo.f19_g17.control.cam.h0.0002-11.nc  F2000climo.f19_g17.control.cam.h0.0007-08.nc  F2000climo.f19_g17.control.cam.h0.0012-05.nc
F2000climo.f19_g17.control.cam.h0.0002-12.nc  F2000climo.f19_g17.control.cam.h0.0007-09.nc  F2000climo.f19_g17.control.cam.h0.0012-06.nc
F2000climo.f19_g17.control.cam.h0.0003-01.nc  F2000climo.f19_g17.control.cam.h0.0007-10.nc  F2000climo.f19_g17.control.cam.h0.0012-07.nc
F2000climo.f19_g17.control.cam.h0.0003-02.nc  F2000climo.f19_g17.control.cam.h0.0007-11.nc  F2000climo.f19_g17.control.cam.h0.0012-08.nc
F2000climo.f19_g17.control.cam.h0.0003-03.nc  F2000climo.f19_g17.control.cam.h0.0007-12.nc  F2000climo.f19_g17.control.cam.h0.0012-09.nc
F2000climo.f19_g17.control.cam.h0.0003-04.nc  F2000climo.f19_g17.control.cam.h0.0008-01.nc  F2000climo.f19_g17.control.cam.h0.0012-10.nc
F2000climo.f19_g17.control.cam.h0.0003-05.nc  F2000climo.f19_g17.control.cam.h0.0008-02.nc  F2000climo.f19_g17.control.cam.h0.0012-11.nc
F2000climo.f19_g17.control.cam.h0.0003-06.nc  F2000climo.f19_g17.control.cam.h0.0008-03.nc  F2000climo.f19_g17.control.cam.h0.0012-12.nc
F2000climo.f19_g17.control.cam.h0.0003-07.nc  F2000climo.f19_g17.control.cam.h0.0008-04.nc  F2000climo.f19_g17.control.cam.h0.0013-01.nc
F2000climo.f19_g17.control.cam.h0.0003-08.nc  F2000climo.f19_g17.control.cam.h0.0008-05.nc  F2000climo.f19_g17.control.cam.h0.0013-02.nc
F2000climo.f19_g17.control.cam.h0.0003-09.nc  F2000climo.f19_g17.control.cam.h0.0008-06.nc  F2000climo.f19_g17.control.cam.h0.0013-03.nc
F2000climo.f19_g17.control.cam.h0.0003-10.nc  F2000climo.f19_g17.control.cam.h0.0008-07.nc  F2000climo.f19_g17.control.cam.h0.0013-04.nc
F2000climo.f19_g17.control.cam.h0.0003-11.nc  F2000climo.f19_g17.control.cam.h0.0008-08.nc  F2000climo.f19_g17.control.cam.h0.0013-05.nc
F2000climo.f19_g17.control.cam.h0.0003-12.nc  F2000climo.f19_g17.control.cam.h0.0008-09.nc  F2000climo.f19_g17.control.cam.h0.0013-06.nc
F2000climo.f19_g17.control.cam.h0.0004-01.nc  F2000climo.f19_g17.control.cam.h0.0008-10.nc  F2000climo.f19_g17.control.cam.h0.0013-07.nc
F2000climo.f19_g17.control.cam.h0.0004-02.nc  F2000climo.f19_g17.control.cam.h0.0008-11.nc  F2000climo.f19_g17.control.cam.h0.0013-08.nc
F2000climo.f19_g17.control.cam.h0.0004-03.nc  F2000climo.f19_g17.control.cam.h0.0008-12.nc  F2000climo.f19_g17.control.cam.h0.0013-09.nc
F2000climo.f19_g17.control.cam.h0.0004-04.nc  F2000climo.f19_g17.control.cam.h0.0009-01.nc  F2000climo.f19_g17.control.cam.h0.0013-10.nc
F2000climo.f19_g17.control.cam.h0.0004-05.nc  F2000climo.f19_g17.control.cam.h0.0009-02.nc  F2000climo.f19_g17.control.cam.h0.0013-11.nc
F2000climo.f19_g17.control.cam.h0.0004-06.nc  F2000climo.f19_g17.control.cam.h0.0009-03.nc  F2000climo.f19_g17.control.cam.h0.0013-12.nc
F2000climo.f19_g17.control.cam.h0.0004-07.nc  F2000climo.f19_g17.control.cam.h0.0009-04.nc  F2000climo.f19_g17.control.cam.i.0002-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0004-08.nc  F2000climo.f19_g17.control.cam.h0.0009-05.nc  F2000climo.f19_g17.control.cam.i.0003-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0004-09.nc  F2000climo.f19_g17.control.cam.h0.0009-06.nc  F2000climo.f19_g17.control.cam.i.0004-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0004-10.nc  F2000climo.f19_g17.control.cam.h0.0009-07.nc  F2000climo.f19_g17.control.cam.i.0005-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0004-11.nc  F2000climo.f19_g17.control.cam.h0.0009-08.nc  F2000climo.f19_g17.control.cam.i.0006-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0004-12.nc  F2000climo.f19_g17.control.cam.h0.0009-09.nc  F2000climo.f19_g17.control.cam.i.0007-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-01.nc  F2000climo.f19_g17.control.cam.h0.0009-10.nc  F2000climo.f19_g17.control.cam.i.0008-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-02.nc  F2000climo.f19_g17.control.cam.h0.0009-11.nc  F2000climo.f19_g17.control.cam.i.0009-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-03.nc  F2000climo.f19_g17.control.cam.h0.0009-12.nc  F2000climo.f19_g17.control.cam.i.0010-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-04.nc  F2000climo.f19_g17.control.cam.h0.0010-01.nc  F2000climo.f19_g17.control.cam.i.0011-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-05.nc  F2000climo.f19_g17.control.cam.h0.0010-02.nc  F2000climo.f19_g17.control.cam.i.0012-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-06.nc  F2000climo.f19_g17.control.cam.h0.0010-03.nc  F2000climo.f19_g17.control.cam.i.0013-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-07.nc  F2000climo.f19_g17.control.cam.h0.0010-04.nc  F2000climo.f19_g17.control.cam.i.0014-01-01-00000.nc
F2000climo.f19_g17.control.cam.h0.0005-08.nc  F2000climo.f19_g17.control.cam.h0.0010-05.nc
F2000climo.f19_g17.control.cam.h0.0005-09.nc  F2000climo.f19_g17.control.cam.h0.0010-06.nc
~~~
{: .output}

## Analyze and Visualize

The *ending* of the filename gives you some information on its content:
- **F2000climo.f19_g17.control** is the control experiment name
- **cam** corresponds to the atmospheric component of the model
- **h0**: *h* stands for *history* and all *h0* files contain the same variables, processed in a similar manner but for different times.
- The 7 digits allow to represent the simulated year and month i.e. **0005-08** means year 5 (from the start of the simulation) and month 8 (August).
- **.nc** means we have netCDF files only.

So in the control directory (*atm/hist* as we are only interested in CAM model outputs), we have 14 years of simulation and
a file per month. Now let's have a look at a single file.

<font color="green">On jupyterhub in a Python 3 jupyter notebook:</font>

~~~
import matplotlib as mpl
import xarray as xr

mpl.rcParams['figure.figsize'] = [10., 8.]

path = 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/'
filename = path + 'F2000climo.f19_g17.control.cam.h0.0005-01.nc'
print(filename)

ds = xr.open_dataset(filename)
ds
~~~
{: .language-python}

~~~
shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-01.nc

<xarray.Dataset>
Dimensions:           (ilev: 33, lat: 96, lev: 32, lon: 144, nbnd: 2, time: 1)
Coordinates:
  * lat               (lat) float64 -90.0 -88.11 -86.21 ... 86.21 88.11 90.0
  * lon               (lon) float64 0.0 2.5 5.0 7.5 ... 350.0 352.5 355.0 357.5
  * lev               (lev) float64 3.643 7.595 14.36 ... 957.5 976.3 992.6
  * ilev              (ilev) float64 2.255 5.032 10.16 ... 967.5 985.1 1e+03
  * time              (time) object 0005-02-01 00:00:00
Dimensions without coordinates: nbnd
Data variables:
    gw                (lat) float64 ...
    hyam              (lev) float64 ...
    hybm              (lev) float64 ...
    P0                float64 ...
    hyai              (ilev) float64 ...
    hybi              (ilev) float64 ...
    date              (time) int32 ...
    datesec           (time) int32 ...
    time_bnds         (time, nbnd) object ...
    date_written      (time) |S8 ...
    time_written      (time) |S8 ...
    ndbase            int32 ...
    nsbase            int32 ...
    nbdate            int32 ...
    nbsec             int32 ...
    mdt               int32 ...
    ndcur             (time) int32 ...
    nscur             (time) int32 ...
    co2vmr            (time) float64 ...
    ch4vmr            (time) float64 ...
    n2ovmr            (time) float64 ...
    f11vmr            (time) float64 ...
    f12vmr            (time) float64 ...
    sol_tsi           (time) float64 ...
    nsteph            (time) int32 ...
    ADRAIN            (time, lev, lat, lon) float32 ...
    ADSNOW            (time, lev, lat, lon) float32 ...
    AEROD_v           (time, lat, lon) float32 ...
    ANRAIN            (time, lev, lat, lon) float32 ...
    ANSNOW            (time, lev, lat, lon) float32 ...
    AODDUST           (time, lat, lon) float32 ...
    AODDUST1          (time, lat, lon) float32 ...
    AODDUST3          (time, lat, lon) float32 ...
    AODVIS            (time, lat, lon) float32 ...
    AQRAIN            (time, lev, lat, lon) float32 ...
    AQSNOW            (time, lev, lat, lon) float32 ...
    AREI              (time, lev, lat, lon) float32 ...
    AREL              (time, lev, lat, lon) float32 ...
    AWNC              (time, lev, lat, lon) float32 ...
    AWNI              (time, lev, lat, lon) float32 ...
    CCN3              (time, lev, lat, lon) float32 ...
    CDNUMC            (time, lat, lon) float32 ...
    CLDHGH            (time, lat, lon) float32 ...
    CLDICE            (time, lev, lat, lon) float32 ...
    CLDLIQ            (time, lev, lat, lon) float32 ...
    CLDLOW            (time, lat, lon) float32 ...
    ...
    ...
    ...
    so4_a3DDF         (time, lat, lon) float32 ...
    so4_a3SFWET       (time, lat, lon) float32 ...
    so4_a3_SRF        (time, lat, lon) float32 ...
    so4_c1            (time, lev, lat, lon) float32 ...
    so4_c1SFWET       (time, lat, lon) float32 ...
    so4_c2            (time, lev, lat, lon) float32 ...
    so4_c2SFWET       (time, lat, lon) float32 ...
    so4_c3            (time, lev, lat, lon) float32 ...
    so4_c3SFWET       (time, lat, lon) float32 ...
    soa_a1            (time, lev, lat, lon) float32 ...
    soa_a1DDF         (time, lat, lon) float32 ...
    soa_a1SFWET       (time, lat, lon) float32 ...
    soa_a1_SRF        (time, lat, lon) float32 ...
    soa_a2            (time, lev, lat, lon) float32 ...
    soa_a2DDF         (time, lat, lon) float32 ...
    soa_a2SFWET       (time, lat, lon) float32 ...
    soa_a2_SRF        (time, lat, lon) float32 ...
    soa_c1            (time, lev, lat, lon) float32 ...
    soa_c1SFWET       (time, lat, lon) float32 ...
    soa_c2            (time, lev, lat, lon) float32 ...
    soa_c2SFWET       (time, lat, lon) float32 ...
Attributes:
    Conventions:       CF-1.0
    source:            CAM
    case:              F2000climo.f19_g17.control
    logname:           herfugl
    host:              
    initial_file:      /cluster/shared/noresm/inputdata/atm/cam/inic/fv/cami-...
    topography_file:   /cluster/shared/noresm/inputdata/atm/cam/topo/fv_1.9x2...
    model_doi_url:     https://doi.org/10.5065/D67H1H0V
    time_period_freq:  month_1
~~~
{: .output}

This file is very similar to the one from our test run, except we have a lot more years and months. 

This is a good news as it means we know how to make maps, Georeferenced Latitude-Vertical plots and we also
know how to interpolate on pressure levels.

~~~
ds.TS.plot(cmap=load_cmap('vik'))
~~~
{: .language-python}

<img src="../fig/control-0009-01.png"> 

~~~
import numpy as np
import xarray as xr
import Ngl
import matplotlib.pyplot as plt

#  Define the output pressure levels.
pnew = [1000., 900., 850., 700., 600, 500., 400., 300., 100., 30., 10.]

#  Extract the desired variables from xarray to numpy array
hyam = ds["hyam"][:]
hybm = ds["hybm"][:]
U    = (ds["U"][:,:,:,:])
psrf = (ds["PS"][:,:,:])
P0mb =  0.01*ds["P0"].values

lats = ds["lat"][:]
lons = ds["lon"][:]

#  Do the interpolation.
intyp = 1                              # 1=linear, 2=log, 3=log-log
kxtrp = True                          # True=extrapolate
  

UonP = Ngl.vinth2p(U,hyam,hybm,pnew,psrf,intyp,P0mb,1,kxtrp)


UonP[UonP==1e30] = np.NaN

U_cross_section=xr.Dataset(
       {'U': (('lev','lat'), UonP.mean(axis=3)[0,:,:])},
       {'lev':  np.asarray(pnew),
        'lat':  lats})
U_cross_section.U.attrs['units'] = 'm/s'
U_cross_section.U.attrs['long_name'] = "Zonal wind"
U_cross_section.U.attrs['standard_name'] = 'U'

fig = plt.figure(figsize=(8, 6))
U_cross_section.U.plot.contourf(cmap=load_cmap('vik'))
plt.ylim(plt.ylim()[::-1])
plt.yscale('symlog')
plt.ylim(bottom=1000)
plt.ylim(top=10)
plt.xlim(left=-90)
plt.xlim(right=90)
plt.ylabel('pressure (hPa)')
plt.title("Zonal wind on pressure levels")
~~~
{: .language-python}


<img src="../fig/U_F2000_CAM5_T31T31_control-0005-01_vertint.png"> 

# What is a climatology?

A Climatology is a climate data series.

In this lesson, we will use climatological data issued from the [Stratosphere-troposphere Processes And their Role in Climate](https://www.sparc-climate.org/) project (SPARC) 
and in particular the [Temperature and Zonal Wind Climatology](https://www.sparc-climate.org/data-centre/data-access/reference-climatology/randals-climatologies/temperature-wind-climatology/).


## SPARC Climatology


These data sets provide an updated climatology of zonal mean temperatures and winds covering altitudes 0-85 km. They are based on combining data from a variety of sources, and represent the time period 1992-1997 (SPARC Report No. 3, Randel et al 2002).
https://www.sparc-climate.org/wp-content/uploads/sites/5/2017/12/SPARC_Report_No3_Dec2002_Climatologies.pdf


The zonal mean temperature climatology is derived using UK Met Office (METO) analyses over 1000-1.5 hPa, combined with Halogen Occultation Experiment (HALOE) temperature climatology over pressures 1.5-0.0046 hPa (~85 km).

<img src="https://www.sparc-climate.org/wp-content/uploads/sites/5/2018/01/DC-TZWClim-temperature_anim.gif">



The monthly zonal wind climatology is derived from the UARS Reference Atmosphere Project (URAP), combining results from METO analyses with winds the UARS High Resolution Doppler Imager (HRDI). Details from the URAP winds are described in Swinbank and Ortland (2003).

<img src="https://www.sparc-climate.org/wp-content/uploads/sites/5/2018/01/DC-TZWClim-zonal_wind_anim.gif">

[NCAR's Climate Data Guide](https://climatedataguide.ucar.edu/) (CDG) provides more information (search SPARC) including strengths and weaknesses of assorted data sets.

## Plotting SPARC climatology

The SPARC climatology **T** and **U** is stored in a file called **SPARC.wind_temp.nc** and can be found on the Jupyterhub.

In the Jupyterhub Terminal:

~~~
cd $HOME/shared-ns1000k/GEO4962/SPARC/
ls
~~~
{: .language-bash}

~~~
-rw-r--r-- 1 jupyter-annefou jupyter-annefou 131512 Feb 13 12:43 sparc_temp.ascii
-rw-r--r-- 1 jupyter-annefou jupyter-annefou 229149 Feb 13 12:47 sparc_wind.ascii
-rw-r--r-- 1 jupyter-annefou jupyter-annefou 157840 Feb 13 12:47 SPARC.wind_temp.nc
-rw-r--r-- 1 jupyter-annefou jupyter-annefou 337206 Feb 13 12:47 sparc.000001.png
-rw-r--r-- 1 jupyter-annefou jupyter-annefou 480321 Feb 13 12:47 sparc.000002.png
~~~
{: .output}

where:

- [sparc_temp.ascii](ftp://sparc-ftp1.ceda.ac.uk/sparc/ref_clim/randel/temp_wind/temp.ascii) and [sparc_wind.ascii](ftp://sparc-ftp1.ceda.ac.uk/sparc/ref_clim/randel/temp_wind/wind.ascii) are two text files containing then temperature and zonal wind, respectively.
- `SPARC.wind_temp.nc` netCDF file containing **U** and **T** corresponding to `sparc_temp.ascii` and `sparc_wind.ascii`.

## Plotting SPARC climatology using *python*

### Open SPARC climatology netCDF file

~~~
import xarray as xr
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import calendar

mpl.rcParams['figure.figsize'] = [10., 8.]

filename = 'shared-ns1000k/GEO4962/SPARC/sparc.nc'
ds = xr.open_dataset(filename)
ds
~~~
{: .language-python}

~~~
<xarray.Dataset>
Dimensions:   (lat: 41, lev_temp: 33, lev_wind: 46, month: 12)
Coordinates:
  * lev_wind  (lev_wind) float32 1000.0 681.29193 ... 3.1622778e-05
  * lat       (lat) float32 -80.0 -76.0 -72.0 -68.0 ... 68.0 72.0 76.0 80.0
  * month     (month) int32 1 2 3 4 5 6 7 8 9 10 11 12
  * lev_temp  (lev_temp) float32 1000.0 681.29193 ... 0.006812923 0.004641587
Data variables:
    WIND      (lev_wind, lat, month) float32 ...
    TEMP      (lev_temp, lat, month) float32 ...
Attributes:
    creation_date:  Tue Feb 21 09:23:03 CET 2017
    creator:        D. Shea, NCAR
    Conventions:    None
    referencese:    \nRandel, W.J. et al., (2004)                            ...
    WWW_data:       http://www.sparc-climate.org/data-center/data-access/refe...
    WWW:            http://www.sparc-climate.org/
    README:         ftp://sparc-ftp1.ceda.ac.uk/sparc/ref_clim/randel/temp_wi...
    title:          SPARC Intercomparison of Middle Atmosphere Climatologies
~~~
{: .output}

### SPARC climatology: Plot Temperature 

~~~
# plot for January (month=0)
ds.TEMP.isel(month=0).plot.contourf(cmap=load_cmap('vik'),
                                   levels=20)

plt.title(calendar.month_name[1])
plt.ylim(plt.ylim()[::-1])
plt.yscale('log')
plt.ylim(top=0.005)
plt.ylim(bottom=1000.)
plt.xlim(left=ds.TEMP.lat.min())
plt.xlim(right=ds.TEMP.lat.max())


~~~
{: .language-python}

<img src="../fig/sparc_T_jan.png">


### SPARC climatology: Plot zonal wind

~~~
ds.WIND.isel(month=0).plot.contourf(cmap=load_cmap('cork'),
                                   levels=15)

plt.title(calendar.month_name[1])
plt.ylim(plt.ylim()[::-1])
plt.yscale('log')
plt.ylim(top=5.0e-5)
plt.ylim(bottom=1000.)
plt.xlim(left=ds.TEMP.lat.min())
plt.xlim(right=ds.TEMP.lat.max())
~~~
{: .language-python}


<img src="../fig/sparc_U_jan.png">

### Multiple plots 

Here we give an example to generate 12 subplots (one per month) for the zonal wind using the Python **range(start, stop[, step])** function (remember that the range of integers ends at **stop - 1**):

~~~
import xarray as xr
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import calendar

# some more adjustments to the figure aesthetics
mpl.rcParams['xtick.direction'] = 'in'
mpl.rcParams['ytick.direction'] = 'in'
mpl.rcParams.update({'font.size': 16})

filename = 'shared-ns1000k/GEO4962/SPARC/sparc.nc'
ds = xr.open_dataset(filename)

fig = plt.figure(figsize=[25, 18])
for month in range(1,13):
    ax = fig.add_subplot(3, 4, month)  # specify (nrows, ncols, axnum)

    levels=np.arange(-70,100,10)

    cs=ds.WIND.isel(month=month-1).plot.contourf(ax=ax, 
                                                 extend='both',
                                                 cmap=load_cmap('cork'), 
                                                 vmin=-70, 
                                                 vmax = 100, 
                                                 add_colorbar=False, 
                                                 levels= levels)

    plt.ylim(plt.ylim()[::-1])
    plt.yscale('log')
    ax.set_title(label = calendar.month_name[month])
    ax.set_ylim(top=5.0e-5)
    ax.set_ylim(bottom=1000.)
    ax.set_xlim(left=ds.WIND.lat.min())
    ax.set_xlim(right=ds.WIND.lat.max())
    
fig.suptitle(ds.WIND.attrs['long_name'], fontsize=24)
    
# adjust subplots so we keep a bit of space on the right for the colorbar    
fig.subplots_adjust(right=0.8, wspace=0.3, hspace=0.5)
# Specify where to place the colorbar
cbar_ax = fig.add_axes([0.85, 0.15, 0.01, 0.7])
# Add a unique colorbar to the figure
fig.colorbar(cs, cax=cbar_ax, label=ds.WIND.attrs['units'])

~~~
{: .language-python}

<img src="../fig/sparc_U_all.png">

> ## Make a multiple plot for the SPARC temperature
>
> Make the same kind of multiple plot but for the temperature instead. 
>
> > ## Solution
> > 
> > ~~~
> >import xarray as xr
> >import matplotlib as mpl
> >import matplotlib.pyplot as plt
> >import numpy as np
> >import calendar
> >
> >
> >filename = 'shared-ns1000k/GEO4962/SPARC/sparc.nc'
> >ds = xr.open_dataset(filename)
> >
> >fig = plt.figure(figsize=[25, 18])
> >for month in range(1,13):
> >    ax = fig.add_subplot(3, 4, month)  # specify (nrows, ncols, axnum)
> >
> >    levels=np.arange(140,320,10)
> >
> >    cs=ds.TEMP.isel(month=month-1).plot.contourf(ax=ax,
> >                                                 extend='both',
> >                                                 cmap=load_cmap('vik'), 
> >                                                 vmin=140, 
> >                                                 vmax = 310, 
> >                                                 add_colorbar=False, 
> >                                                 levels= levels)
> >
> >    plt.ylim(plt.ylim()[::-1])
> >    plt.yscale('log')
> >    ax.set_title(label = calendar.month_name[month])
> >    ax.set_ylim(top=0.005)
> >    ax.set_ylim(bottom=1000.)
> >    ax.set_xlim(left=ds.TEMP.lat.min())
> >    ax.set_xlim(right=ds.TEMP.lat.max())
> >    
> >fig.suptitle(ds.TEMP.attrs['long_name'], fontsize=24)
> >    
> ># adjust subplots so we keep a bit of space on the right for the colorbar    
> >fig.subplots_adjust(right=0.8, wspace=0.3, hspace=0.5)
> ># Specify where to place the colorbar
> >cbar_ax = fig.add_axes([0.85, 0.15, 0.02, 0.7])
> ># Add a unique colorbar to the figure
> >fig.colorbar(cs, cax=cbar_ax, label=ds.TEMP.attrs['units'])
> >
> > ~~~
> > {: .language-python}
> >
> > <img src="../fig/sparc_T_all.png">
> > 
> {: .solution}
>
{: .challenge}

# Compare the control run to the SPARC climatology

Now that we are familiar with the SPARC climatology, we are ready to analyze the CAM control run and 
make comparison with it. This is the goal of the first exercise you will have to fulfill. 


To help you:
- we summarize the [methodology](#methodology) you can follow (please note that there is not one
unique way to analyze and plot, and you should feel free to divert from the methodology given)
- we give you some [instructions](#exercise) with a list of questions you need to answer


## Methodology


### Which variables to analyze and why?

You can analyze many variables from the control run to check its validity but at least **T** and **U** (zonal wind) as
these two variables are the one contained in the SPARC climatology. 

### How to compute yearly means from the control run?

The first years of the control run may not be scientifically representative (we call it the spin up time) 
and we will disregard the first 4 years of the control run for our analysis.

The spin up time is the time the model takes for the model output values of an annual to reach a steady state.

So for your analysis, make sure you only use from year 5 and onwards.

In python, the [xarray](http://xarray.pydata.org/en/stable/) package is very handy as it can also open several
files and compute yearly average. Here is an example, where we first create a list (called *files*) with all
the filenames we wish to analyze:

~~~
import xarray as xr
import pandas as pd
import glob
import os
%matplotlib inline

files =  glob.glob(os.path.join('shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/', 'F2000climo.f19_g17.control.cam.h0.*'))
# sort files so they appear by year/month
files.sort()
# Select files from year 5 and beyond
files[48:]
~~~
{: .language-python}

~~~
['shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0005-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0006-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0007-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0008-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0009-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0010-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0011-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0012-12.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-01.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-02.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-03.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-04.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-05.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-06.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-07.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-08.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-09.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-10.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-11.nc',
 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist/F2000climo.f19_g17.control.cam.h0.0013-12.nc']
~~~
{: .output}

Then we can open all these files:

~~~
ds = xr.open_mfdataset(files[48:], decode_cf = False)
ds
~~~
{: .language-python}
The command above takes a bit of time (between 10-20 seconds) as it reads all the metadata of all the files but 
still does not load any data in memory yet.

~~~
<xarray.Dataset>
Dimensions:        (chars: 8, ilev: 31, lat: 48, lev: 30, lon: 96, nbnd: 2, time: 120)
Coordinates:
  * lev            (lev) float64 3.643 7.595 14.36 24.61 ... 957.5 976.3 992.6
  * ilev           (ilev) float64 2.255 5.032 10.16 18.56 ... 967.5 985.1 1e+03
  * lat            (lat) float64 -87.16 -83.48 -79.78 ... 79.78 83.48 87.16
  * lon            (lon) float64 0.0 3.75 7.5 11.25 ... 345.0 348.8 352.5 356.2
  * time           (time) float64 1.491e+03 1.519e+03 ... 5.079e+03 5.11e+03
Dimensions without coordinates: chars, nbnd
Data variables:
    hyam           (time, lev) float64 dask.array<shape=(120, 30), chunksize=(1, 30)>
    hybm           (time, lev) float64 dask.array<shape=(120, 30), chunksize=(1, 30)>
    hyai           (time, ilev) float64 dask.array<shape=(120, 31), chunksize=(1, 31)>
    hybi           (time, ilev) float64 dask.array<shape=(120, 31), chunksize=(1, 31)>
    P0             (time) float64 1e+05 1e+05 1e+05 1e+05 ... 1e+05 1e+05 1e+05
    date           (time) int32 dask.array<shape=(120,), chunksize=(1,)>
    datesec        (time) int32 dask.array<shape=(120,), chunksize=(1,)>
    time_bnds      (time, nbnd) float64 dask.array<shape=(120, 2), chunksize=(1, 2)>
    date_written   (time, chars) |S1 dask.array<shape=(120, 8), chunksize=(1, 8)>
    time_written   (time, chars) |S1 dask.array<shape=(120, 8), chunksize=(1, 8)>
    ntrm           (time) int32 31 31 31 31 31 31 31 31 ... 31 31 31 31 31 31 31
    ntrn           (time) int32 31 31 31 31 31 31 31 31 ... 31 31 31 31 31 31 31
    ntrk           (time) int32 31 31 31 31 31 31 31 31 ... 31 31 31 31 31 31 31
    ndbase         (time) int32 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0
    nsbase         (time) int32 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0
    nbdate         (time) int32 10101 10101 10101 10101 ... 10101 10101 10101
    nbsec          (time) int32 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0
    mdt            (time) int32 1800 1800 1800 1800 1800 ... 1800 1800 1800 1800
    nlon           (time, lat) int32 dask.array<shape=(120, 48), chunksize=(1, 48)>
    wnummax        (time, lat) int32 dask.array<shape=(120, 48), chunksize=(1, 48)>
    gw             (time, lat) float64 dask.array<shape=(120, 48), chunksize=(1, 48)>
    ndcur          (time) int32 dask.array<shape=(120,), chunksize=(1,)>
    nscur          (time) int32 dask.array<shape=(120,), chunksize=(1,)>
    co2vmr         (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    ch4vmr         (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    n2ovmr         (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    f11vmr         (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    f12vmr         (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    sol_tsi        (time) float64 dask.array<shape=(120,), chunksize=(1,)>
    nsteph         (time) int32 dask.array<shape=(120,), chunksize=(1,)>
    AEROD_v        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ANRAIN         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ANSNOW         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AODDUST1       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    AODDUST3       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    AODVIS         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    AQRAIN         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AQSNOW         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AREI           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AREL           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AWNC           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AWNI           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    BURDEN1        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDEN2        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDEN3        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENBC       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENDUST     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENPOM      (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENSEASALT  (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENSO4      (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    BURDENSOA      (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CCN3           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CDNUMC         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CLDHGH         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CLDICE         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CLDLIQ         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CLDLOW         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CLDMED         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CLDTOT         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    CLOUD          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DCQ            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DMS_SRF        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    DTCOND         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DTH            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DTV            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    EMISCLD        (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FICE           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FLDS           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLNS           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLNSC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLNT           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLNTC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLUT           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FLUTC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FREQI          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQL          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQR          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQS          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FSDS           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSDSC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNS           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNSC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNT           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNTC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNTOA         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSNTOAC        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    FSUTOA         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    H2O2_SRF       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    H2SO4_SRF      (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ICEFRAC        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ICIMR          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ICWMR          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    IWC            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    LANDFRAC       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    LHFLX          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    LWCF           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    NUMICE         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    NUMLIQ         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    OCNFRAC        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    OMEGA          (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    OMEGAT         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ORO            (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PBLH           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PHIS           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PRECC          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PRECL          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PRECSC         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PRECSL         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PS             (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    PSL            (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    Q              (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    QFLX           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    QREFHT         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    QRL            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    QRS            (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    RELHUM         (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    SHFLX          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SNOWHICE       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SNOWHLND       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SO2_SRF        (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SOAG_SRF       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SOLIN          (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    SWCF           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    T              (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    TAUX           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TAUY           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TGCLDCWP       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TGCLDIWP       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TGCLDLWP       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TMQ            (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TREFHT         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TS             (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TSMN           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    TSMX           (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    U              (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    U10            (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    UU             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    V              (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VD01           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VQ             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VT             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VU             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VV             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    WGUSTD         (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    WSUB           (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    Z3             (time, lev, lat, lon) float32 dask.array<shape=(120, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    bc_a1_SRF      (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    dst_a1SF       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    dst_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    dst_a3SF       (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    dst_a3_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ncl_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ncl_a2_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    ncl_a3_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    num_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    num_a2_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    num_a3_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    pom_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    so4_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    so4_a2_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    so4_a3_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    soa_a1_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
    soa_a2_SRF     (time, lat, lon) float32 dask.array<shape=(120, 48, 96), chunksize=(1, 48, 96)>
Attributes:
    Conventions:      CF-1.0
    source:           CAM
    case:             f2000.T31T31.control
    title:            UNSET
    logname:          jeani
    host:             compute-15-1.loc
    Version:          $Name$
    revision_Id:      $Id$
    initial_file:     /work/users/jeani/inputdata/atm/cam/inic/gaus/cami_0000...
    topography_file:  /work/users/jeani/inputdata/atm/cam/topo/USGS-gtopo30_4...
~~~
{: .output}

You can notice that your arrays are [dask](http://docs.dask.org/en/latest/array.html) arrays and they will
be chunked (split) when loading in memory. This allows to manipulate large amounts of data in parallel and/or where
the memory of your computer is not very large. As part of this course, we will not give you more details about it but feel free to ask us
if you are interested.

By default, **time** has not been decoded properly:


~~~
* time           (time) float64 1.491e+03 1.519e+03 ... 5.079e+03 5.11e+03
~~~
{: .output}

It appears as a *float64* and is not recognized as a time but it is easy to correct it. Here is one 
way to do it afterwards:

~~~
timedata=pd.date_range(start=pd.to_datetime('2005-01-31'), end=pd.to_datetime('2013-12-31'), freq='M')
print(timedata)
~~~
{: .language-python}

~~~
DatetimeIndex(['2005-01-31', '2005-02-28', '2005-03-31', '2005-04-30',
               '2005-05-31', '2005-06-30', '2005-07-31', '2005-08-31',
               '2005-09-30', '2005-10-31',
               ...
               '2014-03-31', '2014-04-30', '2014-05-31', '2014-06-30',
               '2014-07-31', '2014-08-31', '2014-09-30', '2014-10-31',
               '2014-11-30', '2014-12-31'],
              dtype='datetime64[ns]', length=120, freq='M')
~~~
{: .output}

Then we change the time index by this new timedata:

~~~
ds['time']=timedata 
~~~
{: .language-python}

Then we group our data by month (January, February, etc.) by averaging all January together, etc.:

~~~
dy = ds.groupby('time.month').mean('time')
dy
~~~
{: .language-python}

~~~
<xarray.Dataset>
Dimensions:        (ilev: 31, lat: 48, lev: 30, lon: 96, month: 12, nbnd: 2)
Coordinates:
  * lev            (lev) float64 3.643 7.595 14.36 24.61 ... 957.5 976.3 992.6
  * ilev           (ilev) float64 2.255 5.032 10.16 18.56 ... 967.5 985.1 1e+03
  * lat            (lat) float64 -87.16 -83.48 -79.78 ... 79.78 83.48 87.16
  * lon            (lon) float64 0.0 3.75 7.5 11.25 ... 345.0 348.8 352.5 356.2
  * month          (month) int64 1 2 3 4 5 6 7 8 9 10 11 12
Dimensions without coordinates: nbnd
Data variables:
    hyam           (month, lev) float64 dask.array<shape=(12, 30), chunksize=(1, 30)>
    hybm           (month, lev) float64 dask.array<shape=(12, 30), chunksize=(1, 30)>
    hyai           (month, ilev) float64 dask.array<shape=(12, 31), chunksize=(1, 31)>
    hybi           (month, ilev) float64 dask.array<shape=(12, 31), chunksize=(1, 31)>
    P0             (month) float64 1e+05 1e+05 1e+05 1e+05 ... 1e+05 1e+05 1e+05
    date           (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    datesec        (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    time_bnds      (month, nbnd) float64 dask.array<shape=(12, 2), chunksize=(1, 2)>
    ntrm           (month) float64 31.0 31.0 31.0 31.0 ... 31.0 31.0 31.0 31.0
    ntrn           (month) float64 31.0 31.0 31.0 31.0 ... 31.0 31.0 31.0 31.0
    ntrk           (month) float64 31.0 31.0 31.0 31.0 ... 31.0 31.0 31.0 31.0
    ndbase         (month) float64 0.0 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0 0.0 0.0
    nsbase         (month) float64 0.0 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0 0.0 0.0
    nbdate         (month) float64 1.01e+04 1.01e+04 ... 1.01e+04 1.01e+04
    nbsec          (month) float64 0.0 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0 0.0 0.0
    mdt            (month) float64 1.8e+03 1.8e+03 1.8e+03 ... 1.8e+03 1.8e+03
    nlon           (month, lat) float64 dask.array<shape=(12, 48), chunksize=(1, 48)>
    wnummax        (month, lat) float64 dask.array<shape=(12, 48), chunksize=(1, 48)>
    gw             (month, lat) float64 dask.array<shape=(12, 48), chunksize=(1, 48)>
    ndcur          (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    nscur          (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    co2vmr         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    ch4vmr         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    n2ovmr         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    f11vmr         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    f12vmr         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    sol_tsi        (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    nsteph         (month) float64 dask.array<shape=(12,), chunksize=(1,)>
    AEROD_v        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ANRAIN         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ANSNOW         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AODDUST1       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    AODDUST3       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    AODVIS         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    AQRAIN         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AQSNOW         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AREI           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AREL           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AWNC           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    AWNI           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    BURDEN1        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDEN2        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDEN3        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENBC       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENDUST     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENPOM      (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENSEASALT  (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENSO4      (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    BURDENSOA      (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CCN3           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CDNUMC         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CLDHGH         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CLDICE         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CLDLIQ         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    CLDLOW         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CLDMED         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CLDTOT         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    CLOUD          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DCQ            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DMS_SRF        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    DTCOND         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DTH            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    DTV            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    EMISCLD        (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FICE           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FLDS           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLNS           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLNSC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLNT           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLNTC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLUT           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FLUTC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FREQI          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQL          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQR          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FREQS          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    FSDS           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSDSC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNS           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNSC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNT           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNTC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNTOA         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSNTOAC        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    FSUTOA         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    H2O2_SRF       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    H2SO4_SRF      (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ICEFRAC        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ICIMR          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ICWMR          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    IWC            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    LANDFRAC       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    LHFLX          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    LWCF           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    NUMICE         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    NUMLIQ         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    OCNFRAC        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    OMEGA          (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    OMEGAT         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    ORO            (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PBLH           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PHIS           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PRECC          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PRECL          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PRECSC         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PRECSL         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PS             (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    PSL            (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    Q              (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    QFLX           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    QREFHT         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    QRL            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    QRS            (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    RELHUM         (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    SHFLX          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SNOWHICE       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SNOWHLND       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SO2_SRF        (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SOAG_SRF       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SOLIN          (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    SWCF           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    T              (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    TAUX           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TAUY           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TGCLDCWP       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TGCLDIWP       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TGCLDLWP       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TMQ            (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TREFHT         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TS             (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TSMN           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    TSMX           (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    U              (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    U10            (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    UU             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    V              (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VD01           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VQ             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VT             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VU             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    VV             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    WGUSTD         (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    WSUB           (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    Z3             (month, lev, lat, lon) float32 dask.array<shape=(12, 30, 48, 96), chunksize=(1, 30, 48, 96)>
    bc_a1_SRF      (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    dst_a1SF       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    dst_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    dst_a3SF       (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    dst_a3_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ncl_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ncl_a2_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    ncl_a3_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    num_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    num_a2_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    num_a3_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    pom_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    so4_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    so4_a2_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    so4_a3_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    soa_a1_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
    soa_a2_SRF     (month, lat, lon) float32 dask.array<shape=(12, 48, 96), chunksize=(1, 48, 96)>
~~~
{: .output}

> ## Important note
> As we are using *xarray*, computations are deferred which means that we still haven't loaded much in memory.
> Computations will be done when we access data.
>
{: .callout}


### How to save the results in a new netCDF file?

You can use *to_netcdf* xarray method:
~~~
# To select variables and store to netCDF
dy[['T', 'U','hyam','hybm','PS','PHIS','P0']].to_netcdf("F2000climo.f19_g17.control.cam.h0_TUmean.nc")
~~~
{: .language-python}


### How to interpolate hybrid sigma pressure levels to pressure levels?

Then you can use [Ngl.vinth2p](https://www.pyngl.ucar.edu/Functions/Ngl.vinth2p.shtml).

You are now ready to visualize U and T from your control run and start the exercise which consists in comparing
the control run with the SPARC climatology.

> ## Exercise
> 
> <font color="red">How well does CAM6 (control run) represent the SPARC climatology?</font>
> 
> To answer this question:
> - write a Python 3 Jupyter notebook and name it **exercise_sparc_vs_control_YOURNAME.ipynb** where you need to
> replace **YOURNAME** by your name!
> - Follow the methodology given in this lesson and compare the results from the control run and the SPARC climatology.
> - send it by email to the instructors/teachers 
>
{: .challenge}

### Deadline

<font color="red">Fulfill the first exercise until the next practical on <b>April 11, 2020</b>!</font>

{% include links.md %}

