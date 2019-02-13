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

# Introduction to Jupyterhub and JupyterLab

You will be using jupyterhub to post-process and visualize your data. All attendees have received a username
and corresponding password; please let us know otherwise.  

## Login to the JupyterHub


<img src="../fig/jupyterhub_login.png" width="400">

Use the username and password you have received and **sign In**.
 
> ## Tips
> Before getting to the username/password login page, your browser may warn you about the security
> of the website and get a message such as "This site is not secure". In order to bypass this security message,
> you need to accept to proceed. Let us know if you still have problems to login.
>
{: .callout}
 
## Start and stop your server

When you manage to successfully login to the Jupyterhub, you should have the following panels:

<img src="../fig/jupyterhub_panels.png" width="600">

To start/stop your server, clock on **Control Panel**:

<img src="../fig/jupyterhub_start_stop_server.png" width="600">

When your server is not running, the button "Stop My Server" does not appear and you only see the button "My Server".

- To stop your server, click on "Stop My Server"
- To start your server, click on "My Server"

> ## Important note
>
> Make sure you stop your server once you have finished your session so it can release resources for next time. 
>
{: .callout}

## JupyterLab

By default, jupyterhub presents you the standard Jupyter user interface layout but you can also access the new 
web-based user interface for Project Jupyter that is called [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).

For this replace **tree?** in the web address you have in your browser tab by **lab**. Then you should get:

<img src="../fig/jupyterlab.png" width="600">

### Menu Bar

The menu bar at the top of JupyterLab has top-level menus that expose actions available in JupyterLab with 
their keyboard shortcuts. The default menus are:

- **File**: actions related to files and directories
- **Edit**: actions related to editing documents and other activities
- **View**: actions that alter the appearance of JupyterLab
- **Run**: actions for running code in different activities such as notebooks and code consoles
- **Kernel**: actions for managing kernels, which are separate processes for running code
- **Tabs**: a list of the open documents and activities in the dock panel
- **Settings**: common settings and an advanced settings editor
- **Help**: a list of JupyterLab and kernel help links

### Left Sidebar
The left sidebar contains a number of commonly-used tabs, such as a file browser, a list of running 
kernels and terminals, the command palette, and a list of tabs in the main work area:

<img src="../fig/jupyterlab_file_browser.png" width="600">

If you move your mouse on the other icon of this left sidebar, a short information is given on its functionality.

If you click on the "running man" icon, you can see what is currently running on your server and you can click on 
"SHUTDOWN" to stop a running Python notebook or Terminal.

<img src="../fig/jupyterlab_running.png" width="600">

> ## Tips
>
> To access to **Control Panel**, you would need to go back to the standard Jupyter user interface layout which
> you can access by entering the Jupyterhub address given in the email in your browser tab (i.e. without your username and tree?).
{: .callout}


### Create a new python 3 notebook

Go back to the **File Browser** left sidebar tab and in the launcher select **Python 3** under the Notebook 
section:

<img src="../fig/jupyterlab_start_notebook.png" width="500">

By default, your new notebook is named as "**Untitled.ipynb**":

- **ipynb** is the extension for any Jupyter notebook and you should make sure all your notebook gets this extension (otherwise it is not recognized as a Jupyter notebook)
- you can rename your jupyter notebook with the tab "File --> Rename Notebook...".


### Start a new Terminal

Similarly, you can start a new Terminal by clicking on "Terminal" in the Launcher. 

<img src="../fig/jupyterlab_start_terminal.png" width="500">


> ## Tips
> If the **Launcher** tab does not exist 
> anymore in your JupyterLab, you can start a new one in "**File** --> **New Launcher**".
{: .callout}



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


Now, add another cell below the plot and try to display the zonal wind (U) instead of the surface temperature (TS).
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

mpl.rcParams['figure.figsize'] = [10., 8.]

ds = psy.open_dataset(filename)

# Create a new dataset over latitudes and levels
# where we select time=0 and lon=0
T_cross_section = xr.Dataset(
    {'T': ds['T'].isel(time=0, lon=0)},
    {'lat':  ds.lat, 'lev': ds.lev}, 
    attrs = ds['T'].attrs)

# Plot
psy.plot.plot2d(T_cross_section, name='T', clabel='{desc}', 
				xlabel=ds.lat.attrs['long_name'], 
				ylabel=ds.lev.attrs['long_name'])
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
psy.plot.plot2d(Tmean, name='T', title=Tmean.attrs['long_name'], clabel=Tmean.attrs['units'],
               xlabel=ds.lat.attrs['long_name'], ylabel=ds.lev.attrs['long_name'])
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon.png">

## CESM vertical coordinate system

The vertical coordinate is a **hybrid sigma-pressure system**. 

The hybrid coordinate was developed by 
[Simmons and Strüfing, 1981](https://rmets.onlinelibrary.wiley.com/doi/abs/10.1002/qj.49710945905) 
in order to provide a general framework for a vertical coordinate which is terrain following at 
the Earth’s surface, but reduces to a pressure coordinate at some point above the surface.

In this system, the upper regions 
of the atmosphere are discretized by pressure only. Lower vertical levels use 
the sigma (i.e. p/ps) vertical coordinate smoothly merged in, with the lowest levels being 
pure sigma. A schematic representation of the hybrid vertical coordinate and vertical indexing is 
presented below. 

<img src="../fig/hybrid_sigma_pressure_coordinates.png" height="400">

More information can be found in [Description of the NCAR Community Atmosphere Model (CAM 3.0)](http://www.cesm.ucar.edu/models/atm-cam/docs/description/description.pdf).

The values at the top of the model are then pressure values (mb) so it is clear that we need to revert the
vertical axis to get the lower values at the top and the highest values at the bottom:

~~~
# To revert vertical axis
psy.plot.plot2d(Tmean, name='T', title=Tmean.attrs['long_name'], clabel=Tmean.attrs['units'],
               xlabel=ds.lat.attrs['long_name'], ylabel=ds.lev.attrs['long_name'])

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
psy.plot.plot2d(Tmean, name='T', title=Tmean.attrs['long_name'], clabel=Tmean.attrs['units'],
               xlabel=ds.lat.attrs['long_name'], ylabel=ds.lev.attrs['long_name'])

# Invert vertical axis
plt.ylim(plt.ylim()[::-1])
# 'symlog' scaling, however, handles negative values nicely
plt.yscale('symlog')
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon_log10.png">

We can also adjust the top of the figure:

~~~
psy.plot.plot2d(Tmean, name='T', title=Tmean.attrs['long_name'],plot='contourf', clabel=Tmean.attrs['units'],
               xlabel=ds.lat.attrs['long_name'], ylabel=ds.lev.attrs['long_name'])

# Invert vertical axis
plt.ylim(plt.ylim()[::-1])
# 'symlog' scaling, however, handles negative values nicely
plt.yscale('symlog')
plt.ylim(top=3)
~~~
{: .language-python}


<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_mean_lon_log10_adjust.png">

{% include links.md %}

