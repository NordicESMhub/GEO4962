---
title: "Himalaya experiment"
teaching: 0
exercises: 0
questions:
- "How to remove Himalaya mountains?"
objectives:
- "Learn to remove the Himalaya mountains in a CESM experiment"
keypoints:
- "Himalaya"
---
<img src="../fig/Himalaya.png">

### **Himalaya Mountains**: how to update input dataset?

Copy the original surface geopotential file into your case directory.

<font color="red">On Abel:</font>

<pre>export EXPNAME=himalaya
cd ~/cesm_case/f2000.T31T31.$EXPNAME

cp /work/users/$USER/inputdata/atm/cam/topo/USGS-gtopo30_48x96_c050520.nc .
</pre>

Use nco utilities to edit the values in the file (http://nco.sourgeforce.net).
We will use a function called ncap2 – (netCDF Arithmetic Averager) single line command below.

<font color="red">On Abel:</font>

<pre>module load nco

ncap2 -O -s 'lat2d[lat,lon]=lat ; lon2d[lat,lon]=lon' -s 'omask=(lat2d >= 30.0 && lat2d <= 50.0) && (lon2d >=70.0 && lon2d <= 100.0)' -s 'PHIS=(PHIS*(1-omask))' USGS-gtopo30_48x96_c050520.nc  USGS-gtopo30_48x96_c050520_$EXPNAME.nc
</pre>

Apply this change.

<font color="red">On Abel:</font>

<pre>echo "bnd_topo = './USGS-gtopo30_48x96_c050520_$EXPNAME.nc'" >> user_nl_cam 	

./preview_namelists

grep topo /work/users/$USER/f2000.T31T31.$EXPNAME/run/atm_in
</pre>

Copy the modified surface geopotential data file into your run directory.

<font color="red">On Abel:</font>

<pre>cp USGS-gtopo30_48x96_c050520_$EXPNAME.nc /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>


{% include links.md %}

