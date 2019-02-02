---
title: "Himalaya Tibetan experiment"
teaching: 0
exercises: 0
questions:
- "How to remove Himalaya Tibetan mountains?"
objectives:
- "Learn to remove the Himalaya Tibetan mountains in a CESM experiment"
keypoints:
- "Himalaya Tibetan"
---
### **Himalaya Mountains and Tibetan Plateau**: how to update input dataset?

Copy surface geopotential file to your case directory:  
<font color="red">On Abel</font>:  
`

<pre>export EXPNAME=himalaya
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/topo/USGS-gtopo30_48x96_c050520.nc .

</pre>

`  

Use nco utilities to edit values on the file (http://nco.sourgeforce.net) We will use a function called ncap2 – (netCDF Arithmetic Averager) single line command below  

<font color="red">On Abel</font>:  
`

<pre>module load nco

ncap2 -O -s 'lat2d[lat,lon]=lat ; lon2d[lat,lon]=lon' -s 'omask=(lat2d >= 30.0 && lat2d <= 50.0) && (lon2d >=70.0 && lon2d <= 100.0)' -s 'PHIS=(PHIS*(1-omask))' USGS-gtopo30_48x96_c050520.nc  USGS-gtopo30_48x96_c050520_$EXPNAME.nc

</pre>

`Apply this change`

<pre>echo "bnd_topo = './USGS-gtopo30_48x96_c050520_$EXPNAME.nc'" >> user_nl_cam 	

./preview_namelists

grep topo /work/users/$USER/f2000.T31T31.$EXPNAME/run/atm_in

</pre>

`Copy changed surface geopotential data file to run directory`

<pre>cp USGS-gtopo30_48x96_c050520_$EXPNAME.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
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

