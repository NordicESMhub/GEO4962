---
title: "Model experiments"
teaching: 0
exercises: 0
questions:
- "How to define a climate experiment?"
- "How to run long experiments?"
objectives:
- "Choose a scenario"
- "Run a long experiment (14 months)"
- "Analyze long experiment"
keypoints:
- "Evaluate various climate scenarii"
- "Start an experiment from a control run"
---

<img src="../fig/long_simulations.jpg">

# Introduce model experiments

You will work **in pairs** for this practical and you will **analyze the model outputs in pairs**.  

First choose your teammate: you will have to work together to set-up and run your experiment so make sure one of you has access to Abel.  

## Experiments

The goal is to run the experiment of your choice (to cherry pick from the list below) for a duration of 14 months, starting on 1st of January until 1st of March the following year. For this you will take the same restart file you already used for the test experiment of the previous practicals.

Each of the 4 experiments is given an explicit name: 

1.  **EXPNAME = CO2**
              Doubling of CO2 (change CO2 value to 800 ppm > change the name list)
2.  **EXPNAME = sea_ice**
              Melt of Arctic sea ice (set sea ice fraction to zero North of 40N > change the input data set)
3.  **EXPNAME = SST**
              Super El Nino (add +6 K to tropical Central and East Pacific SST from 5S to 5N, 180W to 85W > change the input data set)
4.  **EXPNAME = himalaya**
              Lowering of Himalaya Mountains and Tibetan Plateau (set surface Geopotential to 0 from 25N to 40N and 70E to 100E > change the input data set)

Make sure you define an environment variable EXPNAME, **every time** you login <font color="red">on Abel</font>:  

    # define an environment variable for your experiment (CO2, sea_ice, SST or himalaya)
    
    export EXPNAME=CO2

Here is the list of tasks to perform for the experiment of your choice:  

1.  [Create a new case for your experiment](#Create-a-new-case-for-your-experiment)
2.  [Setup experiment duration (1 month)](#Setup-your-new-experiment-duration)
3.  [Changing namelist or dataset](#Changing-namelist-or-dataset)
4.  [Long experiment (14 months)](#Long-experiment-(14-months))

### Create a new case for your experiment

Use an appropriate name for your new experiment depending on what you selected (doubling CO2, sea_ice, etc.). 

Suggested **EXPNAME** were given above.  

To create a new case always involve executing the command create_newcase.  

<font color="red">On Abel:</font>

<pre>cd $HOME/cesm/cesm1_2_2/scripts

# Adjust EXPNAME depending on your experiment (CO2, sea_ice, SST, himalaya)

export EXPNAME=CO2
#
# Simulation 2: Long simulation
#
./create_newcase -case ~/cesm_case/f2000.T31T31.$EXPNAME -res T31_T31 -compset F_2000_CAM5 -mach abel
</pre>

Now you should have a new directory in $HOME/cesm_case/f2000.T31T31.$EXPNAME corresponding to your new case.  

<font color="red">On Abel:</font>

<pre># Make sure EXPNAME is correctly defined!

cd ~/cesm_case/f2000.T31T31.$EXPNAME
</pre>

As before we start a hybrid run from the control experiment.

<font color="red">On Abel:</font> 

<pre>./xmlchange RUN_TYPE=hybrid
./xmlchange RUN_REFCASE=f2000.T31T31.control
./xmlchange RUN_REFDATE=0009-01-01
</pre>

We also need to define the **START DATE** for your experiment (that will make it easier to compare the outputs of the experiment with those of the same month from the control run).

<font color="red">On Abel:</font> 

<pre>./xmlchange RUN_STARTDATE=0009-01-01
</pre>

### Setup your new experiment duration

Before running the long simulation (14 months), it is sensible to check your new settings on a short experiment that will take only a few minutes to run, to make sure everything is done as you expected (and if not, to correct any mistake). 

You will run 1 month first, check the results and then restart the same experiment for several months.  

Make sure you set the duration of your experiments properly. 

<font color="red">On Abel:</font> 

<pre>./xmlchange -file env_run.xml -id STOP_N -val 1
./xmlchange -file env_run.xml -id STOP_OPTION -val nmonths
</pre>

Now we are ready to set-up the model configuration and build the cesm executable.  

<font color="red">On Abel:</font>  

<pre>./cesm_setup

# Make sure EXPNAME is set properly!

./f2000.T31T31.$EXPNAME.build
</pre>

The default history file from CAM is a monthly average but it is possible to change the output frequency with the namelist variable **nhtfrq**

*   If nhtfrq = 0, the file will be a monthly average
*   If nhtfrq > 0, frequency is input as number of timesteps
*   If nhtfrq < 0, frequency is input as number of hours.

For instance to change the history file from monthly average to daily average, we set the namelist variable nhtfrq = -24\. 

We also need to copy restart files in your running directory, etc.

<font color="red">On Abel:</font>

<pre>cat >> user_nl_cice << EOF
grid_file = '/work/users/$USER/inputdata/share/domains/domain.ocn.48x96_gx3v7_100114.nc'
kmt_file = '/work/users/$USER/inputdata/share/domains/domain.ocn.48x96_gx3v7_100114.nc'
EOF

# Make sure EXPNAME is set properly!      

scp login.nird.sigma2.no:/projects/NS1000K/GEO4962/outputs/runs/f2000.T31T31.control/rest/0009-01-01-00000/f2000.T31T31.control.*.0009-01-01-00000.nc  /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
scp login.nird.sigma2.no:/projects/NS1000K/GEO4962/outputs/runs/f2000.T31T31.control/rest/0009-01-01-00000/rpointer.* /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>

Now depending on your experiment case, you would have either to change the namelist or to change the input dataset.

### Changing namelist or dataset 

*   [Doubling CO2](../06-CO2/index.html)
*   [Lowering Rocky mountains](../07-rocky/index.html)
*   [Melt of Artic sea ice](../08-sea-ice/index.html)
*   [Super El Nino](../09-sst/index.html)
*   [Lowering Himalaya mountains](../10-himalaya/index.html)

## Before submitting your experiment, make sure you adjust the <a href="wallclock.html">wall clock time</a>!

Now you are ready to submit your simulation.

<font color="red">On Abel:</font>

<pre>cd ~/cesm_case/f2000.T31T31.$EXPNAME

./f2000.T31T31.$EXPNAME.submit

squeue -u $USER
</pre>

If your simulation is **unsuccessful** you have to understand what happened!

There are in particular log files in the run directory (/work/users/$USER/f2000.T31T31.$EXPNAME/run/) which can provide some clues, although the error messages are not always explicit...

Open the latest log file with your favorit text editor (vi, emacs, etc.) and try to search for keywords like "ERROR" or "Error" or "error" (remember that the search is case sensitive).

Then correct any identified bug.

If your short simulation has **finished without crashing**, check the outputs: were your changes taken into account? Do you get significant results?

If you are happy with your short run, you can setup your <a href="simulations.html">long run (14 months) experiment</a>.

### Model timing data

A summary timing output file is produced after every CESM run. On Abel and in our case this file is placed in /work/users/$USER/archive/f2000.T31T31.$EXPNAME/cpl/logs and is nammed cpl.log.$date.gz (where $date is a datestamp set by CESM at runtime).

This file contains information which is useful for *load balancing a case* (i.e., to optimize the processor layout for a given model configuration, compset, grid, etc. such that the cost and throughput will be optimal).

For this lesson we will concentrate on the last few lines in the file and in particular the number of simulated years per computational day, which will help us evaluate the wallclock time required for long runs.

<font color="red">On Abel:</font>

<pre>vi cpl.log.190205-144355.gz

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
</pre>

### Long experiment (14 months)

As for the previous exercice, you will work **in pairs** for this practical and you will **analyze the model outputs in pairs**.  
You will be using your previous experiment ~/cesm_case/f2000.T31T31.$EXPNAME (EXPNAME should be set depending on your experiment!) and run 14 months.  

#### Set a new duration for your experiment

Make sure you set the duration of your experiment properly. Here we wish to run 14 months from the control restart experiment but as it is a long run, we would rather continue to split it into chuncks of 1 month. 

*Note that splitting an experiment into small chunks is good practice: this way if something happens and the experiment crashes (disk quota exceeded, hardware issue, etc.) everything will not be lost and it will be possible to resume the run from the latest set of restart files.*

<font color="red">On Abel:</font>

<pre># Set EXPNAME properly

cd ~/cesm_case/f2000.T31T31.$EXPNAME
</pre>

Since we have already the first month done, we are going to continue the experiment instead of starting from scratch.

<font color="red">On Abel:</font>

<pre>./xmlchange CONTINUE_RUN=TRUE
</pre>

To perform a 14 months experiment, we would need to repeat this one month experiment 13 times. 

For this purpose there is a CESM option called RESUBMIT.

<font color="red">On Abel:</font>

<pre>./xmlchange -file env_run.xml -id RESUBMIT -val 13
</pre>


By setting this option, CAM5 will be running one month of simulation (once submitted) and automatically resubmit the next 13 months.  

#### Adjust parameters for your long batch submission

Before submitting your experiment (f2000.T31T31.$EXPNAME.submit), you need to adjust [wall clock time](https://en.wikipedia.org/wiki/Wall-clock_time) and adjust CPU resources.  

As each chunk will run 1 month of your experiment, you need to assess the duration of a one month simulation. 

For more information on how to update the wall clock time for your CAM5 simulation, go [here](wallclock.html).  

<font color="red">On Abel:</font>
<pre>cd ~/cesm_case/f2000.T31T31.$EXPNAME

./f2000.T31T31.$EXPNAME.submit
</pre>


Regularly check your experiment (and associated generated output files) and once it is fully done, [store your model outputs on norStore](norstore.html).

# Store model outputs on norStore

First make sure your run was successful and check all the necessary output files were generated.  

To post-process and visualize your model outputs, it is VERY IMPORTANT you move them from Abel to norStore. Remember that all model outputs are generated in a semi-temporary directory and all your files will be removed after a few weeks!  

If you haven't set-up your [SSH keys](http://www.mn.uio.no/geo/english/services/it/help/using-linux/ssh-tips-and-tricks.html), the next commands (ssh and [rsync](http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)) will require you to enter your Unix password.  

Make sure you define EXPNAME properly (it depends on your experiment).

<font color="red">On Abel:</font>

<pre># If you are running CO2 experiment (otherwise adjust: sea_ice, SST, rocky)
export EXPNAME=CO2
</pre>

Then copy the archived files from abel to the norStore project area.

*It is sometimes sensible to also copy the run files and even the case directory, but that should not be necessary for this lesson.*

<font color="red">On Abel:</font>

<pre>ssh login.nird.sigma2.no 'mkdir -p /projects/NS1000K/GEO4962/outputs/$USER/archive'

rsync -avz /work/users/$USER/archive/f2000.T31T31.$EXPNAME $USER@login.nird.sigma2.no:/projects/NS1000K/GEO4962/outputs/$USER/archive/.
</pre>

Once the previous commands are successful, you are ready to [post-process and visualize](../../results.html) your data on login.nird.sigma2.no  

However, as your simulation is stored on the norStore project area, you can now [archive your experiment](archive.html) on the norStore archive (long-term archive i.e. several years).

# Post processing and visualization

You can always compare the results of your experiments to the control run, at any time (i.e., this applies for both the short and long runs).

An easy way to do this is to calculate the difference between for example the surface temperature field issued from the control run and that from your new experiment.

# Copy your output files from Abel to your virtual machine

Start a new **Terminal** on your JupyterHub and transfer your data. Do not forget to replace *YOUR_USER_NAME* by your actual user name and *YOUR_EXPERIMENT* by your actual experiment name (you have to do this because the Virtual machine and Abel are different systems, therefore all the environment variables that were defined on Abel are not known here).

<font color="blue">On the JupyterHub terminal:</font>

<pre>rsync -avzu --progress YOUR_USER_NAME@abel.uio.no:/work/users/YOUR_USER_NAME/archive/f2000.T31T31.YOUR_EXPERIMENT/ /opt/uio/GEO4962/$USER/f2000.T31T31.YOUR_EXPERIMENT/
</pre>

# Visualization with psyplot

Start a new **python3** notebook on your JupyterHub and type the following commands (in this example the *USER* is jeani and we have the first month of data from the sea ice experiment).

<font color="green">On jupyter:</font>

<pre>import psyplot.project as psy

month = '0009-01'

path = 'GEO4962/outputs/runs/f2000.T31T31.control/atm/hist/'
filename = path + 'f2000.T31T31.control.cam.h0.' + month + '.nc'
dsc = xr.open_dataset(filename, decode_cf=False)
Sc = dsc['TS'][0,:,:]

path = 'GEO4962/jupyter-jeani/f2000.T31T31.sea_ice/atm/hist/'
filename = path + 'f2000.T31T31.sea_ice.cam.h0.' + month + '.nc'
dssi = xr.open_dataset(filename, decode_cf=False)
TSsi = dssi['TS'][0,:,:]

diff = TSc - TSsi

diff.psy.plot.mapplot(title="Surface temperature [K]\nF2000_CAM5_T31T31-0009-01\nControl-Sea_Ice")
</pre>

<img src="../fig/TS_F2000_CAM5_T31T31_control-sea_ice-0009-01.png">

{% include links.md %}

