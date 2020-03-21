---
title: "Running your experiments and analyzing your results"
teaching: 0
exercises: 0
questions:
- "How to submit your short run?"
- "How to continue your run"
objectives:
- "Be able to do a quick run to test an experiment"
- "If successful resubmit the same experiment for a longer period"
- "Analyze the outputs from your experiment"
- "Prepare graphs using python"
keypoints:
- "Start an experiment from a spinup"
- "Continue an existing experiment"
- "Evaluate the CPU time required for a long run"
- "Make custom plots"
---

### Running your experiment

Now you are ready to submit your simulation on Saga.

<font color="red">On Saga:</font>

~~~
cd $HOME/cases/F2000climo-f19_g17.$EXPNAME

./case.submit

~~~
{: .language-bash}

To monitor your job:

~~~
squeue -u $USER
~~~
{: .language-bash}

~~~
         JOBID       PARTITION  NAME      USER      ST     TIME       NODES NODELIST(REASON)
         26243157    normal     F2000cl  bjorngli  R      18:25      7     c14-[3,6,10,13-14],c16-[8,22]
~~~
{: .output}

If you realize after having submitted your job that you forgot something (so that it is not worth wasting CPU time) you can always delete your job using the JOBID obtained with the previous *squeue -u $USER* command (in this example 26243157).

~~~
scancel 26243157
~~~
{: .language-bash}

If your simulation is **unsuccessful** you have to understand what happened!

There are in particular log files in the run directory (/cluster/work/users/$USER/cesm/F2000climo-f19_g17.$EXPNAME/run/) which can provide some clues, although the error messages are not always explicit...

Open the latest log file with your favorit text editor (vi, emacs, etc.) and try to search for keywords like "ERROR" or "Error" or "error" (remember that the search is case sensitive).

Then correct any identified bug.

If your short simulation has **finished without crashing**, check the outputs: were your changes taken into account? Do you get significant results?

### Model timing data

A summary timing output file is produced after every CESM run. On Saga and in our case this file is placed in `/cluster/work/users/$USER/archive/F2000climo-f19_g17.$EXPNAME/logs` and is nammed cpl.log.$date.gz (where $date is a datestamp set by CESM at runtime).

This file contains information which is useful for *load balancing a case* (i.e., to optimize the processor layout for a given model configuration, compset, grid, etc. such that the cost and throughput will be optimal).

For this lesson we will concentrate on the last few lines in the file and in particular the number of simulated years per computational day, which will help us evaluate the wallclock time required for long runs.

<font color="red">On Saga:</font>

~~~
vi cpl.log.190205-144355.gz

.......................
(seq_mct_drv): ===============       SUCCESSFUL TERMINATION OF CPL7-CCSM ===============
(seq_mct_drv): ===============        at YMD,TOD =    90201       0      ===============
(seq_mct_drv): ===============  # simulated days (this run) =    31.000  ===============
(seq_mct_drv): ===============  compute time (hrs)          =     0.347  ===============
(seq_mct_drv): ===============  # simulated years / cmp-day =     5.873  ===============
(seq_mct_drv): ===============  pes min memory highwater  (MB)   50.429  ===============
(seq_mct_drv): ===============  pes max memory highwater  (MB)  517.162  ===============
(seq_mct_drv): ===============  pes min memory last usage (MB)   -0.001  ===============
(seq_mct_drv): ===============  pes max memory last usage (MB)   -0.001  ===============
~~~
{: .language-bash}

_Here the throughput was 5.873 simulated years / cmp-day and it took 0.347 * 60 ~ 21 minutes to run the first month. Assuming that the other months will take approximately the same time, that represents about 3 months per hour and a bit more than 4 hours for 12 months._


### Long experiment (14 months)

As for the previous exercice, you will work **in pairs** for this practical and you will **analyze the model outputs in pairs**.  
You will be using your previous experiment `$HOME/cases/F2000climo-f19_g17.$EXPNAME` (EXPNAME should be set depending on your experiment!) and run 14 months.  

#### Set a new duration for your experiment

Make sure you set the duration of your experiment properly. Here we wish to run 14 months from the control restart experiment but as it is a long run, we would rather continue to split it into chuncks of 1 month. 

*Note that splitting an experiment into small chunks is good practice: this way if something happens and the experiment crashes (disk quota exceeded, hardware issue, etc.) everything will not be lost and it will be possible to resume the run from the latest set of restart files.*

<font color="red">On Saga:</font>

~~~
# Set EXPNAME properly

cd $HOME/cases/F2000climo-f19_g17.$EXPNAME
~~~
{: .language-bash}


Since we have already the first month done, we are going to continue the experiment instead of starting from scratch.

<font color="red">On Saga:</font>

~~~
./xmlchange CONTINUE_RUN=TRUE
~~~
{: .language-bash}


To perform a 14 months experiment, we would need to repeat this one month experiment 13 times. 

For this purpose there is a CESM option called RESUBMIT.

<font color="red">On Saga:</font>

~~~
./xmlchange RESUBMIT=13
~~~
{: .language-bash}


By setting this option, CAM6 will be running one month of simulation (once submitted) and automatically resubmit the next 12 months.  

<font color="red">On Saga:</font>

~~~
cd $HOME/cases/F2000climo-f19_g17.$EXPNAME

./case.submit
~~~
{: .language-bash}

> ## updating WALLCLOCK TIME
> Remember that you can update the job wallclock time:
> ~~~
> ./xmlchange --subgroup case.run JOB_WALLCLOCK_TIME=01:00:00
> ~~~
> {: .language-bash}
> Make sure you set the job wallclock time **before** submitting your case (`./case.submit`)
{: .callout}

Regularly check your experiment (and any generated output files) and once it is fully done, store your model outputs on NIRD.

# Store model outputs on NIRD

First make sure that your run was successful and check all the necessary output files were generated.  

To post-process and visualize your model outputs, it is VERY IMPORTANT you move them from Saga to NIRD. Remember that all model outputs are generated in a semi-temporary directory and all your files will be removed after a few weeks!  

If you haven't set-up your [SSH keys](http://www.mn.uio.no/geo/english/services/it/help/using-linux/ssh-tips-and-tricks.html), the next commands (ssh and [rsync](http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)) will require you to enter your Unix password.  

Make sure you define EXPNAME properly (it depends on your experiment).

<font color="red">On Saga:</font>

~~~
# If you are running CO2 experiment (otherwise adjust: sea_ice, SST, rocky)
export EXPNAME=CO2
~~~
{: .language-bash}

Then copy the archived files from Saga to the NIRD project area.

*It is sometimes sensible to also copy the run files and even the case directory, but that should not be necessary for this lesson.*

<font color="red">On Saga:</font>

~~~
ssh login.nird.sigma2.no 'mkdir -p /projects/NS1000K/climate/GEO4962/outputs/$USER/archive'

rsync -avz /cluster/work/users/$USER/archive/F2000climo-f19_g17.$EXPNAME $USER@login.nird.sigma2.no:/projects/NS1000K/climate/GEO4962/outputs/$USER/archive/.
~~~
{: .language-bash}

Once the previous commands are successful, you are ready to post-process and visualize your data on [http://climate.uiogeo-apps.sigma2.no/](http://climate.uiogeo-apps.sigma2.no/). 

However, as your simulation is stored on the NIRD project area, you can now [archive your experiment](../15-clean/) on the NIRD archive (long-term archive i.e. several years).

# Post processing and visualization

You can always compare the results of your experiments to the control run, at any time (i.e., this applies for both the short and long runs).

An easy way to do this is to calculate the difference between for example the surface temperature field issued from the control run and that from your new experiment.

# Visualization with xarray

Start a new **python3** notebook on your JupyterHub and type the following commands (in this example we assume we have the first month of data from the sea ice experiment).

<font color="green">On jupyterhub:</font>

Start a new **pangeo** notebook on your JupyterHub.

~~~
import os
import xarray as xr
import cartopy.crs as ccrs
import matplotlib.pyplot as plt
%matplotlib inline

month = '0010-01'
username = os.getenv('USER')

path = 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.control/atm/hist'
filename = path + 'F2000climo.f19_g17.control.cam.h0.' + month + '.nc'
dsc = xr.open_dataset(filename, decode_cf=False)
TSc = dsc['TS']

path = 'shared-ns1000k/GEO4962/outputs/' + username + 'F2000climo.f19_g17.sea_ice/atm/hist/'
filename = path + 'f2000.T31T31.sea_ice.cam.h0.' + month + '.nc'
dssi = xr.open_dataset(filename, decode_cf=False)
TSsi = dssi['TS']

diff = TSc - TSsi

fig = plt.figure()
ax = plt.axes(projection=ccrs.Miller())

diff.TS.plot(ax=ax, 
           transform=ccrs.PlateCarree(),
           cmap=load_cmap('vik') 
           )

ax.coastlines()
plt.title("Surface temperature [K]\nF2000climo.f19_g17-0010-01\nControl-Sea_Ice")
~~~
{: .language-python}

<img src="../fig/TS_F2000_CAM5_T31T31_control-sea_ice-0009-01.png">

## Making bespoke graphs with python

Let's make a basic contour plot with python.

<font color="green">On jupyterLab:</font>

Now we can make a contour plot with a single command.

<font color="green">On jupyter:</font>

~~~
TSsi.plot.contourf()
~~~
{: .language-python}

to obtain this:

<img src="../fig/Basic-plot.png">

This figure is not very useful: we do not know which projection was used, there is no coastline, we would rather have a proper title, etc.

To do that we need to add bit more information.

<font color="green">On jupyter:</font>

~~~
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
ax = plt.axes(projection=ccrs.PlateCarree(central_longitude=180))
TSsi.plot.contourf(ax=ax,
                   transform=ccrs.PlateCarree())
ax.set_title(experiment + '-' + month + '\n' + TSsi.long_name)
ax.coastlines()
ax.gridlines()
~~~
{: .language-python}

This is a slightly better plot, we are getting closer to what we had with psyplot...

<img src="../fig/Better-plot.png">

### Change the default projection

It is very often convenient to visualize using a different projection than the original data:


<font color="green">On jupyter:</font>

~~~
TSmin = 220
TSmax = 320

fig = plt.figure(figsize=[8, 8])
ax = fig.add_subplot(1, 1, 1, projection=ccrs.Orthographic(central_longitude=20, central_latitude=40))  # specify (nrows, ncols, axnum)

TSsi.plot.contourf(ax=ax,
                      transform=ccrs.PlateCarree(), 
                      extend='max',
                      cmap='jet', vmin=TSmin, vmax = TSmax)

ax.set_title(experiment + '-' + month + '\n')
ax.coastlines()
ax.gridlines()
~~~
{: .language-python}


<img src="../fig/Sea_ice-0009-01_nowrap.png">

> ## wrap around longitudes
> 
> 
> <font color="green">On jupyter:</font>
>
> ~~~
> 
> # get longitude min and max
> print(TSsi.lon.min(), TSsi.lon.max())
> ~~~
> {: .language-python}
>
> To fill the gap, we can wrap around longitudes i.e. add a new longitude band at 360. equals to 0.
>
> ~~~
> TSmin = 220
> TSmax = 320
> 
> # max longitude is 356.25 so we add another longitude 360. (= 0.)  
> TS_cyclic_si, lon_cyclic = add_cyclic_point(TSsi.values, coord=TSsi.lon)
> # Create a new xarray with the new arrays
> TSsi_cy = xr.DataArray(TS_cyclic_si, coords={'lat':TSsi.lat, 'lon':lon_cyclic}, dims=('lat','lon'), 
>                        attrs = TSsi.attrs )
> 
> fig = plt.figure(figsize=[8, 8])
> ax = fig.add_subplot(1, 1, 1, projection=ccrs.Orthographic(central_longitude=20, central_latitude=40))  # specify (nrows, ncols, axnum)
> 
> TSsi_cy.plot.contourf(ax=ax,
>                       transform=ccrs.PlateCarree(), 
>                       extend='max',
>                       cmap='jet', vmin=TSmin, vmax = TSmax)
> 
> ax.set_title(experiment + '-' + month + '\n')
> ax.coastlines()
> ax.gridlines()
> 
> ~~~
> {: .language-python}
>
> 
> <img src="../fig/Sea_ice-0009-01.png">
{: .callout}


You can now use the command [savefig](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.savefig.html) to save the current figure into a file.

<font color="green">On jupyter:</font>

~~~
fig.savefig(experiment + '-' + month + '.png')
~~~
{: .language-python}

### contourf versus pcolormesh

So far, we used *contourf* to visualize our data but we can also use *pcolormesh*.

> ## Change *contourf* by *pcolormesh* 
>
> Change *contourf* by *pcolormesh* in the previous plot.
> 
> What do you observe?
> 
> > ## Solution
> > ~~~
> > import os
> > import xarray as xr
> > import numpy as np
> > import cartopy.crs as ccrs
> > from cartopy.util import add_cyclic_point
> > import matplotlib.pyplot as plt
> > 
> > %matplotlib inline
> > 
> > username = os.getenv('USER')
> > 
> > month = '0010-01'
> > path = 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.sea_ice/atm/hist'
> > filename = path + 'F2000climo.f19_g17.sea_ice.cam.h0.' + month + '.nc'
> > 
> > dset = xr.open_dataset(filename, decode_cf=False)
> > TSsi = dset['TS']
> > 
> > TSmin = 220
> > TSmax = 320
> > 
> > # max longitude is 356.25 so we add another longitude 360. (= 0.)  
> > TS_cyclic_si, lon_cyclic = add_cyclic_point(TSsi.values, coord=TSsi.lon)
> > # Create a new xarray with the new arrays
> > TSsi_cy = xr.DataArray(TS_cyclic_si, coords={'lat':TSsi.lat, 'lon':lon_cyclic}, dims=('lat','lon'), 
> >                        attrs = TSsi.attrs )
> > 
> > fig = plt.figure(figsize=[8, 8])
> > ax = fig.add_subplot(1, 1, 1, projection=ccrs.Orthographic(central_longitude=20, central_latitude=40))  # specify (nrows, ncols, axnum)
> > 
> > TSsi_cy.plot.pcolormesh(ax=ax,
> >                       transform=ccrs.PlateCarree(), 
> >                       extend='max',
> >                       cmap='jet', vmin=TSmin, vmax = TSmax)
> > 
> > ax.set_title(experiment + '-' + month + '\n')
> > ax.coastlines()
> > ax.gridlines()
> > ~~~
> > {: .language-python}
> >
> > 
> > <img src="../fig/Sea_ice-0009-01_pcolormesh.png">
> >
> {: .solution}
{: .challenge}


### Create multiple plots in the same figure

See [here](https://nordicesmhub.github.io/NEGI-Abisko-2019/training/CMIP6_example.html).

<font color="green">On jupyter:</font>

~~~
import os
import xarray as xr
import numpy as np
import cartopy.crs as ccrs
from cartopy.util import add_cyclic_point
import matplotlib.pyplot as plt

%matplotlib inline

username = os.getenv('USER')

path = 'shared-ns1000k/GEO4962/outputs/runs/F2000climo.f19_g17.sea_ice/atm/hist'

fig = plt.figure(figsize=[20, 8])
TSmin = 220
TSmax = 320

for month in range(1,7):
    filename = path + 'F2000climo.f19_g17.sea_ice.cam.h0.0010-0' + str(month) + '.nc'
    dset = xr.open_dataset(filename, decode_cf=False)
    TSsi = dset['TS']
    lat = dset['lat']
    lon = dset['lon']
    dset.close()

    TS_cyclic_si, lon_cyclic = add_cyclic_point(TSsi.values, coord=TSsi.lon)
    TSsi_cy = xr.DataArray(TS_cyclic_si, coords={'lat':TSsi.lat, 'lon':lon_cyclic}, dims=('lat','lon'), 
                            attrs = TSsi.attrs )

    ax = fig.add_subplot(2, 3, month, projection=ccrs.Mollweide())  # specify (nrows, ncols, axnum)

    cs = TSsi_cy.plot.contourf(ax=ax,
                      transform=ccrs.PlateCarree(), 
                      extend='max',
                      cmap='jet', vmin=TSmin, vmax = TSmax, add_colorbar=False)

    ax.set_title( 'month ' + str(month) + '\n')
    ax.coastlines()
    ax.gridlines()
    

fig.suptitle(experiment + '-0010'+'\n' + TSsi.long_name, fontsize=24)
    
# adjust subplots so we keep a bit of space on the right for the colorbar    
fig.subplots_adjust(right=0.8)
# Specify where to place the colorbar
cbar_ax = fig.add_axes([0.85, 0.15, 0.02, 0.7])
# Add a unique colorbar to the figure
fig.colorbar(cs, cax=cbar_ax, label=TSsi.units)
~~~
{: .language-python}

<img src="../fig/Sea_ice-0009-01-06.png">

{% include links.md %}

