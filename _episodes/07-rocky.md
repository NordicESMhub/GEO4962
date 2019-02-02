---
title: "Rocky experiment"
teaching: 0
exercises: 0
questions:
- "How to remove Rocky mountains?"
objectives:
- "Learn to remove the Rocky mountains in a CESM experiment"
keypoints:
- "Rocky"
---

<h3 id="dataset"><b>Rocky Mountains</b>: how to update input dataset?</h3>
<br>

Copy surface geopotential file to your case directory:

<br>
<font color="red">On Abel</font>:
<br>
<code>
<pre>
export EXPNAME=rocky
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/topo/USGS-gtopo30_48x96_c050520.nc .

</pre>
</code>
<br>
<br>
Use nco utilities to edit values on the file (http://nco.sourgeforce.net)

We will use a function called ncap2 – (netCDF Arithmetic Averager) single line command below


<br>

<br>
<font color="red">On Abel</font>:
<br>
<code>
<pre>
module load nco



ncap2 -O -s 'lat2d[lat,lon]=lat ; lon2d[lat,lon]=lon' -s 'omask=(lat2d >= 30.0 && lat2d <= 50.0) && (lon2d >=235.0 && lon2d <= 260.0)' -s 'PHIS=(PHIS*(1-omask))' USGS-gtopo30_48x96_c050520.nc  USGS-gtopo30_48x96_c050520_$EXPNAME.nc


</pre>
</code>

Apply this change

<code>
<pre>
echo "bnd_topo = './USGS-gtopo30_48x96_c050520_$EXPNAME.nc'" >> user_nl_cam 	

./preview_namelists

grep topo /work/users/$USER/f2000.T31T31.$EXPNAME/run/atm_in


</pre>
</code>


Copy changed surface geopotential data file to run directory


<code>
<pre>
cp USGS-gtopo30_48x96_c050520_$EXPNAME.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>
</code>

<br>

Before submitting your experiment, make sure you adjust the <a href="wallclock.html">wall clock time</a>!

Now you are ready to submit your simulation:
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

{% include links.md %}

