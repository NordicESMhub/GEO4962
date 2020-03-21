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

### **Himalaya Mountains**: how to update the input dataset?

Copy the original surface geopotential file into your case directory.

<font color="red">On Saga:</font>

~~~
export EXPNAME=himalaya
cd $HOME/cases/F2000climo-f19_g17.$EXPNAME

cp /cluster/projects/nn1000k/cesm/inputdata/./atm/cam/topo/fv_1.9x2.5_nc3000_Nsw084_Nrs016_Co120_Fi001_ZR_061116.nc .
~~~
{: .language-bash}

Use nco utilities to edit the values in the file (http://nco.sourgeforce.net).
We will use a function called ncap2 – (netCDF Arithmetic Averager) single line command below.

<font color="red">On Saga:</font>

~~~
module load NCO/4.7.9-intel-2018b

ncap2 -O -s 'lat2d[lat,lon]=lat ; lon2d[lat,lon]=lon' -s 'omask=(lat2d >= 30.0 && lat2d <= 50.0) && (lon2d >=70.0 && lon2d <= 100.0)' -s 'PHIS=(PHIS*(1-omask))' fv_1.9x2.5_nc3000_Nsw084_Nrs016_Co120_Fi001_ZR_061116.nc fv_1.9x2.5_nc3000_Nsw084_Nrs016_Co120_Fi001_ZR_061116_$EXPNAME.nc
~~~
{: .language-bash}

<img src="../fig/Himalaya_modified.png">

Apply this change.

<font color="red">On Saga:</font>

~~~
echo "bnd_topo = './fv_1.9x2.5_nc3000_Nsw084_Nrs016_Co120_Fi001_ZR_061116_$EXPNAME.nc'" >> user_nl_cam 	

./preview_namelists

grep topo /cluster/work/users/$USER/cesm/F2000climo-f19_g17.$EXPNAME/run/atm_in
~~~
{: .language-bash}

Copy the modified surface geopotential data file into your run directory.

<font color="red">On Saga:</font>

~~~
cp fv_1.9x2.5_nc3000_Nsw084_Nrs016_Co120_Fi001_ZR_061116_$EXPNAME.nc /cluster/work/users/$USER/cesm/F2000climo-f19_g17.$EXPNAME/run/.
~~~
{: .language-bash}


{% include links.md %}

