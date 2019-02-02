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

<h3 id="dataset"><b>Sea-ice</b>: how to update input dataset?</h3>
<br>
The ice fraction data (used for prescribed CICE) is found in the same data file that provide SST data to the data ocean model since SST and ice fraction data are derived from the same observational data sets and are consistent with each other.

<br>
<br>

Copy SST file to your case directory:

<br>
<font color="red">On Abel</font>:
<br>
<code>
<pre>
export EXPNAME=sea_ice
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/sst/sst_HadOIBl_bc_48x96_clim_c050526.nc .

</pre>
</code>
<br>
<br>
To change sea-ice fraction surface boundary data, use <a href="http://nco.sourgeforce.net">nco</a> utilities to edit values on the file.
<br>
We will use a function called <a href="http://nco.sourceforge.net/nco.html#ncap2-netCDF-Arithmetic-Processor">ncap2</a> – (netCDF Arithmetic Averager) single line command below:
<br>

<br>
<font color="red">On Abel</font>:
<br>
<code>
<pre>

module load nco

ncap2 -O -s 'lat2d[lat,lon]=lat' -s 'omask=(lat2d >= 40.)' -s 'ice_cov=(ice_cov*(1-omask))' sst_HadOIBl_bc_48x96_clim_c050526.nc sst_HadOIBl_bc_48x96_clim_$EXPNAME.nc

</pre>
</code>


Apply this change using env_run.xml (recommended over user_nl* since also present in 
docn.streams.txt.prescribed):

<ul>
<li>figure out which namelist variable to change:

<code>
<pre>
grep sst_ *.xml
</pre>
</code>

</li>
<li>Change it in env_run.xml

<code>
<pre>
./xmlchange -file env_run.xml -i SSTICE_DATA_FILENAME -val ./sst_HadOIBl_bc_48x96_clim_sea_ice.nc
</pre>
</code>
</li>
</ul>

Process env_run.xml to make namelist changes effective (create namelist files)

<code>
<pre>
./preview_namelists
</pre>
</code>


Copy changed SST data file to run directory



<code>
<pre>
cp sst_HadOIBl_bc_48x96_clim_sea_ice.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>
</code>

<br>

Before submitting your experiment, make sure you adjust the <a href="wallclock.html">wall clock time</a>!

Now you are ready to submit your simulation:
<br>
<br>
<font color="red">On Abel</font>:
<br>

<code>
<pre>
cd ~/cesm_case/f2000.T31T31.$EXPNAME

./f2000.T31T31.$EXPNAME.submit
</pre>
</code>
<br>
Once your short simulation is done, check the outputs: were your changes taken into account? Do you get significant results?
<br>
If you are happy with your short run, you can setup your <a href="simulations.html">long run (14 months) experiment</a>.
<br>
<br>
<br>
{% include links.md %}

