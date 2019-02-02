---
title: "SST experiment"
teaching: 0
exercises: 0
questions:
- "How to modify Sea Surface Temperature (SST)?"
objectives:
- "Learn to modify SST in a CESM experiment"
keypoints:
- "SST"
---
### **SST**: how to update input dataset?

Copy SST file to your case directory:  
<font color="red">On Abel</font>:  
`

<pre>export EXPNAME=SST
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/sst/sst_HadOIBl_bc_48x96_clim_c050526.nc .

</pre>

`  

To change SST (+6K), use [nco](http://nco.sourgeforce.net) utilities to edit values on the file.  
We will use a function called [ncap2](http://nco.sourceforge.net/nco.html#ncap2-netCDF-Arithmetic-Processor) – (netCDF Arithmetic Averager) single line command below:  

<font color="red">On Abel</font>:  
`

<pre>
module load nco

ncap2 -O -s 'lat2d[lat,lon]=lat ; lon2d[lat,lon]=lon' -s 'omask=(lat2d >= -5.0 && lat2d <= 5.0) && (lon2d >=180.0 && lon2d <= 275.0)' -s 'SST_cpl=(SST_cpl + 6.0*omask)' sst_HadOIBl_bc_48x96_clim_c050526.nc sst_HadOIBl_bc_48x96_clim_$EXPNAME.nc

</pre>

`

*   figure out which namelist variable to change:`

    <pre>grep sst_ *.xml
    </pre>

    `
*   Change it in env_run.xml`

    <pre>./xmlchange -file env_run.xml -i SSTICE_DATA_FILENAME -val ./sst_HadOIBl_bc_48x96_clim_$EXPNAME.nc
    </pre>

    `

Process env_run.xml to make namelist changes effective (create namelist files)`

<pre>./preview_namelists
</pre>

`Copy changed SST data file to run directory`

<pre>cp sst_HadOIBl_bc_48x96_clim_SST.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>

`  
Before submitting your experiment, make sure you adjust the [wall clock time](wallclock.html)! Now you are ready to submit your simulation:  
<font color="red">On Abel</font>:  
`

<pre>cd ~/cesm_case/f2000.T31T31.$EXPNAME

./f2000.T31T31.$EXPNAME.submit
</pre>

`  
Once your short simulation is done, check the outputs: were your changes taken into account? Do you get significant results?  
If you are happy with your short run, you can setup your [long run (14 months) experiment](simulations.html).
{% include links.md %}

