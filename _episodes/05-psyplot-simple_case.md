---
title: "Analyze and visualize test model outputs with psyplot"
teaching: 0
exercises: 0
questions:
- "How to start/stop Jupyter notebooks in the Jupyterhub?"
- "How to analyze and visualize CESM outputs with python?"
- "What is the vertical coordinate in CESM?" 
objectives:
- "Learn about the Jupyter ecosystem"
- "Learn to analyze CESM CAM outputs with the test run"
- "Learn about python packages for Earth System Modelling"
keypoints:
- "jupyterlab"
- "hybrid sigma levels"
- "psyplot, xarray"
---

# Post-processing and Visualization

<img src="../fig/visualization.png">


*   [Introduction to Jupyterhub and JupyterLab](#introduction-to-jupyterhub-and-jupyterlab)
		* [Login to the JupyterHub](#login-to-the-jupyterhub)
		* [Start and stop your server](#start-and-stop-your-server)
		* [JupyterLab](#jupyterlab)
*   [Copy your output files from Abel to the virtual machine](#copy-your-output-files-from-abel-to-the-virtual-machine)
*   [Map visualization with psyplot](#map-visualization-with-psyplot)
*   [Customize your maps](#customize-your-plots)
		* [Set figure size](#set-figure-size)
		* [Plot 4D-fields such as Temperature](#plot-4d-fields-such-as-temperature)
		* [Change map projection](#change-map-projection)
*   [Georeferenced Latitude-Vertical plot](#georeferenced-latitude-vertical-plot)	
		* [2D plot for one longitude point](#2d-plot-for-one-longitude-point)
		* [2D plot over averaged longitudes](#2d-plot-over-averaged-longitudes)
*   [CESM vertical coordinate system](#cesm-vertical-coordinate-system)
*   [Interpolate to pressure levels](#interpolate-to-pressure-levels)

# Introduction to Jupyterhub and JupyterLab

You will be using jupyterhub to post-process and visualize your data. All attendees have received a username
and corresponding password; please let us know otherwise.  

## Login to the JupyterHub

## Start and stop your server

## JupyterLab

### Create a new python 3 notebook

### Start a new Terminal

# Copy your output files from Abel to the virtual machine

Start a new **Terminal** on your JupyterHub (this will be referred to hereafter as your "JupyterHub terminal") and type the following commands.

<font color="blue">On the JupyterHub terminal:</font>

<pre>rsync -avzu --progress YOUR_USER_NAME@abel.uio.no:/work/users/YOUR_USER_NAME/archive/f2000.T31T31.test/ /opt/uio/GEO4962/$USER/f2000.T31T31.test/
</pre>


# Map visualization with psyplot

Start a new **python3** notebook on your JupyterHub and type the following commands.

<font color="green">On jupyter:</font>

~~~
# os provides a portable way of using operating system dependent functionality
# for instance to get path, environment variables
import os

# python package for plotting maps, 2D plot, etc.
import psyplot.project as psy

# the next line is only necessary when running within a Jupyter notebook
# and allows to inline plots in the Jupyter notebook
%matplotlib inline
~~~
{: .language-python}

These set of commands are meant to initialize the python 3 notebook with python packages (*os* and *psyplot.project*)
that we will use for plotting our netCDF model outputs.

Now we can create a map. We plot **TS** (Surface temperature) by specifying the filename and title of our plot 
and using *psy.plot.mapplot*:

~~~
# get your username from the environment variable USER
username = os.getenv('USER')
# specify the path where your test simulation is stored
path = 'GEO4962/' + username + '/f2000.T31T31.test/atm/hist/'
filename = path + 'f2000.T31T31.test.cam.h0.0009-01.nc'
print(filename)

p = psy.plot.mapplot(filename, name='TS', title="Surface temperature [K]\nF2000_CAM5_T31T31_test-0009-01")
~~~
{: .language-python}


<img src="../fig/TS_F2000_CAM5_T31T31_test-0009-01.png">


# Customize your maps

##  Set figure size

~~~
import matplotlib as mpl
mpl.rcParams['figure.figsize'] = [10., 8.]
p = psy.plot.mapplot(filename, name='TS', title="Surface temperature [K]\nF2000_CAM5_T31T31_test-0009-01")
~~~ 
{: .language-python}

<img src="../fig/TS_F2000_CAM5_T31T31_test-0009-01_big.png">

## Plot 4D-fields such as Temperature
		
In the same way add another cell below the plot and display the variable **T** instead of the surface temperature (TS). 

To show the colorbar label we used the *clabel* format option keyword and one of the predefined labels (*desc* for description). 

~~~
psy.plot.mapplot(filename, name='T', title="F2000_CAM5_T31T31_test-0009-01", clabel='{desc}')
~~~
{: .language-python}

<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_top.png">


Contrary to TS which depends only on two horizontal dimensions (namely latitude and longitude)
 plus time, for T there is an additional dimension (along the vertical).

> ## What did we plot?
>
> - <font color="red">What is the difference between T and TS?</font>
> - <font color="red">Which time did you plot?</font>
> - <font color="red">Which level did you plot?</font>
> - <font color="red">How to display the lowest model level?</font>
{: .challenge}


In the same way add another cell below the plot and try to display the zonal wind (U) instead of the surface temperature (TS).
As for T, U has an additional dimension (along the vertical), hence we also have to specify a vertical level 
(between 0 and 29) to make our plot. 

<font color="green">On jupyter:</font>

~~~
u = psy.plot.mapplot(filename, name='U', dims={'lev': 29}, title="F2000_CAM5_T31T31_test-0009-01", clabel='{desc}')
~~~
{: .language-python}



<img src="../fig/U29_F2000_CAM5_T31T31_test-0009-01.png">


## Change map projection

~~~
psy.plot.mapplot(filename, name='T', dims={'lev': 29}, projection='moll', 
                 clabel='{desc}', title="F2000_CAM5_T31T31_test-0009-01")
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_moll.png">

The list of available projections for pysplot is available [here](https://psyplot.readthedocs.io/projects/psy-maps/en/latest/api/psy_maps.plotters.html#psy_maps.plotters.FieldPlotter.projection).


## Georeferenced Latitude-Vertical plot 


### 2D plot for one longitude point

We select *lon=0* and to use psyplot, we create a new *xarray* using latitudes and the levels:

~~~
import xarray as xr

ds = psy.open_dataset(filename)

# Create a new dataset over latitudes and levels
# where we select time=0 and lon=0
T_cross_section = xr.Dataset(
    {'T': ds['T'].isel(time=0, lon=0)},
    {'lat':  ds.lat, 'lev': ds.lev}, 
    attrs = ds['T'].attrs)

# Plot
psy.plot.plot2d(T_cross_section, name='T', clabel='{desc}')
~~~
{: .language-python}

<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_lon0.png">

### 2D plot over averaged longitudes

We create a new *xarray* as before but instead of selecting one longitude, we average over all the longitudes,
using *mean* function:

~~~
# Instead of selecting one longitude, 
# we can average over all the longitudes
# We select time=0 and use mean where we specify the dimension
# over which we want to average ('lon')
Tmean=xr.Dataset(
       {'T': ds['T'].isel(time=0).mean(dim='lon')},
       {'lat':  ds.lat, 'lev': ds.lev}, 
        attrs = ds['T'].attrs)

print(Tmean)

# Plot the cross section
psy.plot.plot2d(Tmean, name='T', clabel=Tmean.attrs['units'])
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon.png">

## CESM vertical coordinate system

~~~
# To revert vertical axis
psy.plot.plot2d(Tmean, name='T', clabel='{desc}')

# Invert vertical axis
import matplotlib.pyplot as plt
plt.ylim(plt.ylim()[::-1])
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon_invert_y.png">

The vertical axis is labelled as "hybrid level at midpoints". Again, not pressure levels but still we 
usually use the log to plot it as it is more intuitive to analyze. For this, go to the tab "Grid" and 
change the units of the vertical axis from "scalar" to "Log10". 

~~~
psy.plot.plot2d(Tmean, name='T', clabel='{desc}')
# Invert vertical axis
plt.ylim(plt.ylim()[::-1])
# 'symlog' scaling, however, handles negative values nicely
plt.yscale('symlog')
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon_log10.png">

We can also adjust the top of the figure:

~~~
psy.plot.plot2d(Tmean, name='T', plot='contourf', clabel='{desc}')
# Invert vertical axis
plt.ylim(plt.ylim()[::-1])
# 'symlog' scaling, however, handles negative values nicely
plt.yscale('symlog')
plt.ylim(top=3)
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon_log10_adjust.png">

{% include links.md %}

