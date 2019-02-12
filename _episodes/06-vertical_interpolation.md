---
title: "From hybrid sigma-pressure levels to pressure levels"
teaching: 0
exercises: 0
questions:
- "How to interpolate on pressure levels?"
objectives:
- "Learn to interpolate data on pressure levels"
keypoints:
- "hybrid sigma levels"
- "pressure levels"
---

# Interpolate to pressure levels

### Interpolate to one pressure level

~~~
import Ngl
import Nio
import os
import xarray as xr
import numpy as np
import matplotlib as mpl

# python package for plotting maps, 2D plot, etc.
import psyplot.project as psy

# the next line is only necessary when running within a Jupyter notebook
# and allows to inline plots in the Jupyter notebook
%matplotlib inline

# Set figure size for all our plots
mpl.rcParams['figure.figsize'] = [10., 8.]
# get your username from the environment variable USER
username = os.getenv('USER')
# specify the path where your test simulation is stored
path = 'GEO4962/' + username + '/f2000.T31T31.test/atm/hist/'
filename = path + 'f2000.T31T31.test.cam.h0.0009-01.nc'
print(filename)

#  Open the netCDF file containing the input data.
cfile = Nio.open_file(filename,"r")

#  Define the output pressure levels.
pnew = [850.]

#  Extract the desired variables.
hyam = cfile.variables["hyam"][:]
hybm = cfile.variables["hybm"][:]
T    = (cfile.variables["T"][:,:,:,:])
psrf = (cfile.variables["PS"][:,:,:])
P0mb =  0.01*cfile.variables["P0"].get_value()

lats = cfile.variables["lat"][:]
lons = cfile.variables["lon"][:]

#  Do the interpolation.
intyp = 2                              # 1=linear, 2=log, 3=log-log
kxtrp = False                          # True=extrapolate
  
Tnew = Ngl.vinth2p(T,hyam,hybm,pnew,psrf,1,P0mb,1,kxtrp)

ntime, output_levels, nlat, nlon = Tnew.shape
print("vinth2p: shape of returned array   = [{:1d},{:1d},{:2d},{:3d}]".format(*Tnew.shape))
print("  number of timesteps     = {:4d}".format((ntime)))
print("  number of input levels  = {:4d}".format((T.shape[1])))
print("  number of output levels = {:4d}".format((output_levels)))
print("  number of latitudes     = {:4d}".format((nlat)))
print("  number of longitudes    = {:4d}".format((nlon)))


Tnew[Tnew==1e30] = np.NaN
print(Tnew.mean(axis=3).shape,lats.shape)
T850=xr.Dataset(
       {'T850': (('lat','lon'), Tnew[0,0,:,:])},
       {'lons':  ds.lon,
       'lats':  ds.lat})

# plot using psyplot

psy.plot.mapplot(T850, name='T850', title='Temperature (K) at 850 mb')
~~~
{: .language-python}

<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_850mb.png">

### Georeferenced Latitude-Vertical plot on pressure levels

> ## Create a Georeferenced Latitude-Vertical plot on the following pressure levels:
> pnew = [900., 850., 700., 600, 500., 400., 300., 100., 30., 10.]
> 
> - What do you observe? 
> - Is there anything wrong?
>
> > ## Solution
> > ~~~
> > import xarray as xr
> > import numpy as np
> > import matplotlib as plt
> > 
> > pnew = [850., 700., 600, 500., 400., 300., 100., 30., 10.]
> > 
> > Tnew = Ngl.vinth2p(T,hyam,hybm,pnew,psrf,1,P0mb,1,kxtrp)
> > 
> > ntime, output_levels, nlat, nlon = Tnew.shape
> > 
> > Tnew[Tnew==1e30] = np.NaN
> > print(Tnew.mean(axis=3).shape,lats.shape)
> > Tmean=xr.Dataset(
> >        {'T': (('lev','lat'), Tnew.mean(axis=3)[0,:,:])},
> >        { 'lev':  np.asarray(pnew),
> >        'lat':  lats})
> > ~~~
> > {: .language-python}
>
> <img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_vertint.png"> 
>
{: .challenge}

Here, we show you how to use [ncl](https://www.ncl.ucar.edu/Document/Tools/) to interpolate T and U fields to 
a list of pressure levels and store the resulting field in a new netCDF file:


~~~
press = "'lev_p=(/1000.0,900.,850.,700.,500.,300.,200.,100.,50.,20.,10./)'"
cmd = "ncl " + press + " 'input_filename=" + '"' + filename + '"' 
cmd = cmd + "' 'output_filename=" + '"f2000.T31T31.test.cam.h0.0009-01_pl.nc"' 
cmd = cmd + "' vertical_interpolation.ncl"

# run ncl command
import os
returned_value = os.system(cmd)
print(returned_value)
~~~
{: .language-python}

Then we can plot T:

~~~
import xarray as xr

ds = psy.open_dataset('f2000.T31T31.test.cam.h0.0009-01_pl.nc')

# Create a new dataset over latitudes and levels
# where we select time=0 and lon=0
T_cross_section = xr.Dataset(
    {'T': ds['T'].isel(time=0).mean(dim='lon')},
    {'lat':  ds.lat, 'lev': ds.lev_p}, 
    attrs = ds['T'].attrs)


# Plot
psy.plot.plot2d(T_cross_section, name='T', plot='contourf', 
                title="Georeferenced Latitude-Vertical plot", 
                clabel="Temperature (K)",
                xlabel='latitude',
                ylabel='pressure (mb)'
               )

plt.ylim(plt.ylim()[::-1])
plt.yscale('symlog')
plt.ylim(bottom=1000)
plt.ylim(top=10)
~~~
{: .language-python}

<img src="../fig/T_F2000_CAM5_T31T31_test-0009-01_pressure.png"> 

And U:

~~~
U_cross_section = xr.Dataset(
    {'U': ds['U'].isel(time=0).mean(dim='lon')},
    {'lat':  ds.lat, 'lev': ds.lev_p}, 
    attrs = ds['U'].attrs)

psy.plot.plot2d(U_cross_section, name='U', plot='contourf', 
                title="Georeferenced Latitude-Vertical plot", 
                clabel="Zonal wind (m/s)",
                xlabel='latitude',
                ylabel='pressure (mb)'
               )
plt.ylim(plt.ylim()[::-1])
plt.yscale('symlog')
plt.ylim(bottom=1000)
plt.ylim(top=10)
~~~
{: .language-python}

<img src="../fig/U_F2000_CAM5_T31T31_test-0009-01_pressure.png"> 


{% include links.md %}

