---
title: "Analyze and visualize cesm model outputs"
teaching: 0
exercises: 0
questions:
- "What is a control run?"
- "How to use ncl to interpolate on pressure levels?"
- "How to start Python in the Jupyter notebook?"
- "How to analyze and visualize CESM outputs with python?"
objectives:
- "Learn about the control run"
- "Learn to use ncl to interpole data on pressure levels"
- "Learn about the Jupyter ecosystem"
- "Learn about python packages for Earth System Modelling"
keypoints:
- "control run"
- "ncl"
- "jupyterlab"
- "psyplot, xarray, ipyleaflet"
---
# Post-processing and Visualization

You will be using both cruncher (cruncher.norstore.uio.no) and viz2 (viz2.norstore.uio.no) to post-process your data (cruncher) and visualize your data (viz2).  

*   [Visualize your model outputs with psyplot](#psyplot)
*   [Post-processing workflow: example with the control experiment](#workflow)
*   [SPARC Climatology](#sparc)
*   [Exercice-1](#exercice1)

# Visualization with psyplot


### **Geographical map**


<font color="red">

*   Which Time did you plot?
*   Which level did you plot?

</font>


### **Georeferenced Latitude-Vertical plot**


# Post-processing workflow: example with the control experiment

<font color="red">On nird (login.nird.sigma2.no):</font>

`

<pre>cd /projects/NS1000K/GEO4962/outputs/archive/f2000.T31T31.control/atm/hist
</pre>

`

<font color="red">

*   How many years did we run?
*   What is the output frequency?

</font>

1.  [Select variables of interest](#Select)
2.  [Compute monthly/yearly/zonal mean](#mean)
3.  [Convert to Pressure levels and visualize](#h2P)

### **NIRD**

#### Setup on cruncher

**nird**

`

<pre>export PATH=/projects/NS1000K/panoply/4.4.3/:$PATH
module load cdo
module load ncl
</pre>

`

#### Select variables of interest

[ncks](http://nco.sourceforge.net/nco.html#ncks-netCDF-Kitchen-Sink)

[nco](http://nco.sourceforge.net/)

<font color="red">on cruncher</font>

`

<pre>mkdir -p $HOME/GEO4962/control
ncks -v T f2000.T31T31.control.cam.h0.0005-01-11-00000.nc $HOME/GEO4962/control/f2000.T31T31.control.cam.h0.0005-01-11-00000_T.nc
</pre>

`

`

<pre>ncks -v T,U,hyam,hybm,PS f2000.T31T31.control.cam.h0.0004-12-12-00000.nc $HOME/GEO4962/control/f2000.T31T31.control.cam.h0.0004-12-12-00000_TU.nc
ncks -v T,U,hyam,hybm,PS f2000.T31T31.control.cam.h0.0005-01-11-00000.nc $HOME/GEO4962/control/f2000.T31T31.control.cam.h0.0005-01-11-00000_TU.nc
</pre>

`

[T and U on pressure levels](#h2P)

<font color="red">

*   Use panoply to visualize your new netCDF files
*   Use a shell loop to extract T and U (and hyam, hybm and PS) from all the model outputs (control experiment) and store the resulting netCDF files in $HOME/GEO4962/control/

</font>

##### Compute monthly/yearly mean

###### Monthly mean

[CDO](https://code.zmaw.de/projects/cdo)

[NCO](http://nco.sourceforge.net)

[NCO](http://nco.sourceforge.net)

[ncra](http://nco.sourceforge.net/nco.html#ncra-netCDF-Record-Averager)

`

<pre>cd /projects/NS1000K/GEO4962/outputs/archive/f2000.T31T31.control/atm/hist/

ncra f2000.T31T31.control.cam.h0.0004-01-*.nc f2000.T31T31.control.cam.h0.0005-01-*.nc $HOME/GEO4962/control/f2000.T31T31.control-0005-01-monmean.nc
</pre>

`

`

<pre>cd /projects/NS1000K/GEO4962/outputs/archive/f2000.T31T31.control/atm/hist/

ncra -d time,1461.,1492\. f2000.T31T31.control.cam.h0.0004-01-*.nc f2000.T31T31.control.cam.h0.0005-01-*.nc $HOME/GEO4962/control/f2000.T31T31.control-0005-01-monmean.nc
</pre>

`

**-d time,1461.,1492.**

`

<pre>ncdump -h f2000.T31T31.control.cam.h0.0001-01-01-00000.nc
</pre>

`

`

<pre>	double time(time) ;
		time:long_name = "time" ;
		time:units = "days since 0001-01-01 00:00:00" ;
		time:calendar = "noleap" ;
		time:bounds = "time_bnds" ;
</pre>

`

<font color="red">

*   Apply ncra to compute the average (January, year 5) on the netCDF files you first created (after ncks).
*   You can use shell loops to compute the average for every month and then get 12 output files (one per month)

</font>

**Remark:**

##### Compute monthly climatologies from daily data using ncclimo

[ncclimo](http://nco.sourceforge.net/nco.html#ncclimo-netCDF-Climatology-Generator)

[ncra](http://nco.sourceforge.net/nco.html#ncra-netCDF-Record-Averager)

`

<pre>	ncclimo --seasons=none -v U,T,hyam,hybm,PS,PHIS,gw -C dly -c f2000.T31T31.control -f UT.f2000.T31T31.control -s 4 -e 8 -i . -o /projects/NS1000K/GEO4962/outputs/$USER/some/directory/
</pre>

`

`

<pre>	mkdir mo_climo

	for i in {01..12}; do ncra UT.f2000.T31T31.control_0004$i??_0008$i??_climo.nc mo_climo/UT.f2000.T31T31.control.$i.nc; done
</pre>

`

###### Zonal mean

[Here](http://www.ncl.ucar.edu/Applications/zonal.shtml)

[zonal_2.ncl](http://www.ncl.ucar.edu/Applications/Scripts/zonal_2.ncl)

[dim_avg_Wrap](http://www.ncl.ucar.edu/Document/Functions/Contributed/dim_avg_Wrap.shtml)

##### Convert to Pressure levels

[vertical interpolation](http://www.ncl.ucar.edu/Applications/vert_interp.shtml)

[vinth2p](http://www.ncl.ucar.edu/Document/Functions/Built-in/vinth2p.shtml)

**vert_1.ncl**

**f2000.T31T31.control-0005-01-monmean.nc**

1.  Download [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) and transfer it to cruncher. Here we assume you have your vert_1.ncl script in **$HOME/GEO4962/control/**.
2.  Edit vert_1.ncl (use your favourite editor such as emacs) and change the input file name:/li>`

    <pre>fn  = "f2000.T31T31.control-0005-01-monmean.nc" ; define filename
    </pre>

    `  

3.  Then run your script with ncl <font color="red">on cruncher</font>:

`

<pre>module load ncl

ncl vert_1.ncl
</pre>

`

`

<pre>  pnew = (/ 850.0,700.0,500.0,300.0,200.0 /)        
</pre>

`

**pnew**

`

<pre>T = in->T  
</pre>

`

[here](https://www.ncl.ucar.edu/Applications/o-netcdf.shtml)

[here](http://www.ncl.ucar.edu/Applications/vert_interp.shtml)

**Remark:**

##### Automating interpolation

**README**

**int_script_template.ncl**

**generate_interpolation_file_2.sh**

**generate_interpolation_file_2.sh**

`

<pre>	./generate_interpolation_file_2.sh filename fieldname
</pre>

`

`

<pre>	./generate_interpolation_file_2.sh UT.f2000.T31T31.control.01.nc T
</pre>

`

`

<pre>	for f in UT.f2000.T31T31.control.*.nc
	do
		./generate_interpolation_file_2.sh $f T
	done
</pre>

`

#### [SPARC climatology](http://www.sparc-climate.org/data-center/data-access/reference-climatologies/randels-climatologies/temperature-wind-climatology/)

**sparc.nc**

`

<pre>cd /projects/NS1000K/GEO4962/SPARC
</pre>

`

[sparc_2.ncl](https://www.ncl.ucar.edu/Applications/Scripts/sparc_2.ncl)

*   Create sparc directory in your HOME on norStore:
`

<pre>mkdir -p $HOME/GEO4962/sparc
cd $HOME/GEO4962/sparc
</pre>

`
*   copy sparc_2.ncl in your local directory:
`

<pre>cp /projects/NS1000K/GEO4962/SPARC/sparc_2.ncl $HOME/GEO4962/sparc/.
</pre>

`
*   Edit **$HOME/GEO4962/sparc/sparc_2.ncl** and change **diri** (it specifies the directory where sparc.nc can be found). It is by default set to **"./"** and should be set to:
`

<pre>diri="/projects/NS1000K/GEO4962/SPARC/"
</pre>

`
*   Save your script and run ncl:
`

<pre>ncl sparc_2.ncl
</pre>

`

**display**

`

<pre>display sparc.000001.png
</pre>

`

**sparc.000001.png**

![](../../images/sparc.000001.png)

**sparc.000002.png**

![](../../images/sparc.000002.png)

#### Exercice-1

1.  <font color="red">How well does CAM5 (T31/L30, 5 yr control run) represent observations?</font>

1.  Select T,U,hyam,hybm,PS (use ncks) for all the model outputs of the control experiment (/projects/NS1000K/GEO4962/outputs/archive/f2000.T31T31.control/atm/hist). Save these new output files in the directory $HOME/GEO4962/control/.
2.  For each year (you may start from year 4 to year 8), compute the monthly average using ncra.
3.  Use ncra again to get an average for all the January months. Repeat it for each month (February to December).
4.  Use [zonal_2.ncl](http://www.ncl.ucar.edu/Applications/Scripts/zonal_2.ncl) and [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) to get a zonal mean and interpolate to pressure levels. Make sure you choose your pressure levels (change the variable **pnew** in [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) so you can easily compare with SPARC climatology).
5.  You may use [sparc_2.ncl](https://www.ncl.ucar.edu/Applications/Scripts/sparc_2.ncl) to get plots similar to those we got with the SPARC climatology. You can also use panoply (or python).

<font color="red">Fulfill the first exercise until the next practical on March 27, 2017!</font>

{% include links.md %}

