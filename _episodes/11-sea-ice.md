---
title: "Sea-ice experiment"
teaching: 0
exercises: 0
questions:
- "How to modify sea-ice?"
objectives:
- "Learn to modify sea-ice in a CESM experiment"
keypoints:
- "sea-ice"
---
<img src="../fig/Sea_Ice.png">

<h3 id="dataset"><b>Sea-ice</b>: how to update the input dataset?</h3>

The ice fraction data (used for prescribed CICE) is found in the same data file that provide SST data to the data ocean model since SST and ice fraction data are derived from the same observational data sets and are consistent with each other.

You first need to copy the original SST file to your case directory.

<font color="red">On Saga:</font>

<pre>export EXPNAME=sea_ice
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/sst/sst_HadOIBl_bc_48x96_clim_c050526.nc .
</pre>

To change sea-ice fraction surface boundary data, use <a href="http://nco.sourgeforce.net">nco</a> utilities to modify the values in the file.

We will use a function called <a href="http://nco.sourceforge.net/nco.html#ncap2-netCDF-Arithmetic-Processor">ncap2</a> – (netCDF Arithmetic Averager) single line command below:

<font color="red">On Saga:</font>
<pre>module load nco

ncap2 -O -s 'lat2d[lat,lon]=lat' -s 'omask=(lat2d >= 40.)' -s 'ice_cov=(ice_cov*(1-omask))' sst_HadOIBl_bc_48x96_clim_c050526.nc sst_HadOIBl_bc_48x96_clim_$EXPNAME.nc
</pre>

Apply this change using env_run.xml (recommended over user_nl* since also present in docn.streams.txt.prescribed):

We have to figure out which namelist variable to change.

<font color="red">On Saga:</font>

<pre>grep sst_ *.xml
</pre>

then change the relevant variable in env_run.xml.

<font color="red">On Saga:</font>

<pre>./xmlchange -file env_run.xml -i SSTICE_DATA_FILENAME -val ./sst_HadOIBl_bc_48x96_clim_sea_ice.nc
</pre>

and to process env_run.xml to make the namelist changes effective (i.e., create namelist files).

<font color="red">On Saga:</font>

<pre>./preview_namelists
</pre>

Finally, we can copy the changed SST data file to the run directory.

<font color="red">On Saga:</font>

<pre>cp sst_HadOIBl_bc_48x96_clim_sea_ice.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>

{% include links.md %}

