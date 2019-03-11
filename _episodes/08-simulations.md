---
title: "Setup model experiments"
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
- "For PhD students: define, numerically implement and scientifically evaluate their own *extreme* geo-engineering solution to conteract doubling CO2"
---

<img src="../fig/long_simulations.jpg">

# Introduce model experiments

**Master students will work in pairs** for this practical and are to choose an experiment, adapt the namelist or make dataset changes following one of the predefined scenarii, then **analyze the model outputs in pairs**. 

> ## PhD students only
>
> However, for **PhD students** a more challenging exercise will be to define their own **geo-engineering solution** in order to **counteract the effect of doubling CO2**. 
>
> This original geo-engineering solution must be **scientifically sound**, although it can be “extreme” (to some extent) and does not necessarily have to be feasible in the real world from a practical point of view.
> 
> The PhD students have to think about the **numerical implementation** of their solution in the model.
> 
> PhD students will also work in pairs and will use the **same model version** (CESM1.2.2 with CAM 5.3) but can set-up a more appropriate compset if needed.
> 
> In a first phase PhD students will have to **investigate several possible options** and assess their likely pros and cons.
> 
> That may require a **sensitivity analysis** and involve running short experiments (no more than 1 month each).
> 
> The PhD students will then quickly **present their favorite scenario for approval** before starting the actual simulations.
> 
> In a second phase the PhD students will run their experiment for a total of 14 months and analyze their results to evaluate the **effectiveness of the solution tested**, identify a region where the impact is most significant and quantify the changes.
{: .callout}


First choose your teammate: you will have to work together to set-up and run your experiment so make sure one of you has access to Abel.  

## Experiments

The goal is to run the experiment of your choice (to cherry pick from the list below) for a duration of 14 months, starting on 1st of January until 1st of March the following year. For this you will take the same restart file you already used for the test experiment of the previous practicals.

Each of the 4 experiments is given an explicit name: 

1.  **EXPNAME = CO2**
              Quadrupling of CO2 (change CO2 value to 1467 ppm > change the name list)
2.  **EXPNAME = rockies**
              Lowering of Rocky Mountains (set surface Geopotential to 0 from 30N to 50N and 235E to 260E  > change the input data set)
3.  **EXPNAME = sea_ice**
              Melt of Arctic sea ice (set sea ice fraction to zero North of 40N > change the input data set)
4.  **EXPNAME = SST**
              Super El Nino (add +6 K to tropical Central and East Pacific SST from 5S to 5N, 180W to 85W > change the input data set)
5.  **EXPNAME = himalaya**
              Lowering of Himalaya Mountains and Tibetan Plateau (set surface Geopotential to 0 from 30N to 50N and 70E to 100E > change the input data set)

Make sure you define an environment variable EXPNAME, **every time** you login <font color="red">on Abel</font>:  

    # define an environment variable for your experiment (CO2, rockies, sea_ice, SST or himalaya)
    
    export EXPNAME=CO2

Here is the list of tasks to perform for the experiment of your choice:  

1.  [Create a new case for your experiment](#Create-a-new-case-for-your-experiment)
2.  [Setup experiment duration (1 month)](#Setup-your-new-experiment-duration)
3.  [Changing namelist or dataset](#Changing-namelist-or-dataset)
4.  [Long experiment (14 months)](#Long-experiment-(14-months))
5. **Explain what you expect** (not having performed any numerical simulation yet) the effect of the change you have picked to be on the general circulation in the atmosphere and send us your text by email.

### Create a new case for your experiment

Use an appropriate name for your new experiment depending on what you selected (doubling CO2, sea_ice, etc.). 

Suggested **EXPNAME** were given above.  

To create a new case always involve executing the command create_newcase.  

<font color="red">On Abel:</font>

<pre>cd $HOME/cesm/cesm1_2_2/scripts

# Adjust EXPNAME depending on your experiment (CO2, rockies, sea_ice, SST, himalaya)

export EXPNAME=CO2

module load cesm/1.2.2

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

cp $CESM_DATA/../GEO4962/archive/f2000.T31T31.control/rest/0009-01-01-00000/* /work/users/$USER/f2000.T31T31.$EXPNAME/run/.
</pre>

Now depending on your experiment case, you would have either to change the namelist or to change the input dataset.

### Changing namelist or dataset 

*   [Quadrupling CO2](../09-CO2/index.html)
*   [Lowering Rocky mountains](../10-rocky/index.html)
*   [Melt of Artic sea ice](../11-sea-ice/index.html)
*   [Super El Nino](../12-sst/index.html)
*   [Lowering Himalaya mountains](../13-himalaya/index.html)

{% include links.md %}

