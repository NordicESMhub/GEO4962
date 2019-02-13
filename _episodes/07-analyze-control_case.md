---
title: "Analyze and visualize control model outputs"
teaching: 0
exercises: 0
questions:
- "What is a control run?"
- "What is a climatology?"
- "How to compare model outputs with a climatology?"
objectives:
- "Learn about control run"
- "Learn to compare a control run with a climatology"
keypoints:
- "control run"
- "climatology"
---

*   [What is a control run?](#what-is-a-control-run)
*   [What is a climatology?](#what-is-a-climatology)
	*   [SPARC Climatology](#sparc-climatology)
*   [Compare the control run to the SPARC climatology](#compare-the-control-run-to-the-sparc-climatology)
	*   [Methodology](#methodology)
	*   [Exercice-1](#exercice-1)

# What is a control run?

A control run is a simulation undertaken with a model with known conditions for the ocean, atmosphere, etc.

In our case, the control run will be used as a reference to evaluate the impacts of different scenarii 
(changes made to the atmospheric composition such CO2 concentration increase, etc.).

The control run is representative of the conditions in years 2000 i.e. similar to today's climate. The idea was 
to generate the restart files (snapshot of the model state at a given point in time) from where you will be able to 
start your future experiments at year 9 and further compare your simulation outputs with the control run for the following years.

The control run model outputs are accessible from the Jupyterhub; for instance, from a Terminal:

~~~
ls $HOME/GEO4962/outputs/runs/f2000.T31T31.control/atm/hist
~~~
{: .language-bash}

~~~

f2000.T31T31.control.cam.h0.0001-01.nc  f2000.T31T31.control.cam.h0.0005-09.nc  f2000.T31T31.control.cam.h0.0010-05.nc
f2000.T31T31.control.cam.h0.0001-02.nc  f2000.T31T31.control.cam.h0.0005-10.nc  f2000.T31T31.control.cam.h0.0010-06.nc
f2000.T31T31.control.cam.h0.0001-03.nc  f2000.T31T31.control.cam.h0.0005-11.nc  f2000.T31T31.control.cam.h0.0010-07.nc
f2000.T31T31.control.cam.h0.0001-04.nc  f2000.T31T31.control.cam.h0.0005-12.nc  f2000.T31T31.control.cam.h0.0010-08.nc
f2000.T31T31.control.cam.h0.0001-05.nc  f2000.T31T31.control.cam.h0.0006-01.nc  f2000.T31T31.control.cam.h0.0010-09.nc
f2000.T31T31.control.cam.h0.0001-06.nc  f2000.T31T31.control.cam.h0.0006-02.nc  f2000.T31T31.control.cam.h0.0010-10.nc
f2000.T31T31.control.cam.h0.0001-07.nc  f2000.T31T31.control.cam.h0.0006-03.nc  f2000.T31T31.control.cam.h0.0010-11.nc
f2000.T31T31.control.cam.h0.0001-08.nc  f2000.T31T31.control.cam.h0.0006-04.nc  f2000.T31T31.control.cam.h0.0010-12.nc
f2000.T31T31.control.cam.h0.0001-09.nc  f2000.T31T31.control.cam.h0.0006-05.nc  f2000.T31T31.control.cam.h0.0011-01.nc
f2000.T31T31.control.cam.h0.0001-10.nc  f2000.T31T31.control.cam.h0.0006-06.nc  f2000.T31T31.control.cam.h0.0011-02.nc
f2000.T31T31.control.cam.h0.0001-11.nc  f2000.T31T31.control.cam.h0.0006-07.nc  f2000.T31T31.control.cam.h0.0011-03.nc
f2000.T31T31.control.cam.h0.0001-12.nc  f2000.T31T31.control.cam.h0.0006-08.nc  f2000.T31T31.control.cam.h0.0011-04.nc
f2000.T31T31.control.cam.h0.0002-01.nc  f2000.T31T31.control.cam.h0.0006-09.nc  f2000.T31T31.control.cam.h0.0011-05.nc
f2000.T31T31.control.cam.h0.0002-02.nc  f2000.T31T31.control.cam.h0.0006-10.nc  f2000.T31T31.control.cam.h0.0011-06.nc
f2000.T31T31.control.cam.h0.0002-03.nc  f2000.T31T31.control.cam.h0.0006-11.nc  f2000.T31T31.control.cam.h0.0011-07.nc
f2000.T31T31.control.cam.h0.0002-04.nc  f2000.T31T31.control.cam.h0.0006-12.nc  f2000.T31T31.control.cam.h0.0011-08.nc
f2000.T31T31.control.cam.h0.0002-05.nc  f2000.T31T31.control.cam.h0.0007-01.nc  f2000.T31T31.control.cam.h0.0011-09.nc
f2000.T31T31.control.cam.h0.0002-06.nc  f2000.T31T31.control.cam.h0.0007-02.nc  f2000.T31T31.control.cam.h0.0011-10.nc
f2000.T31T31.control.cam.h0.0002-07.nc  f2000.T31T31.control.cam.h0.0007-03.nc  f2000.T31T31.control.cam.h0.0011-11.nc
f2000.T31T31.control.cam.h0.0002-08.nc  f2000.T31T31.control.cam.h0.0007-04.nc  f2000.T31T31.control.cam.h0.0011-12.nc
f2000.T31T31.control.cam.h0.0002-09.nc  f2000.T31T31.control.cam.h0.0007-05.nc  f2000.T31T31.control.cam.h0.0012-01.nc
f2000.T31T31.control.cam.h0.0002-10.nc  f2000.T31T31.control.cam.h0.0007-06.nc  f2000.T31T31.control.cam.h0.0012-02.nc
f2000.T31T31.control.cam.h0.0002-11.nc  f2000.T31T31.control.cam.h0.0007-07.nc  f2000.T31T31.control.cam.h0.0012-03.nc
f2000.T31T31.control.cam.h0.0002-12.nc  f2000.T31T31.control.cam.h0.0007-08.nc  f2000.T31T31.control.cam.h0.0012-04.nc
f2000.T31T31.control.cam.h0.0003-01.nc  f2000.T31T31.control.cam.h0.0007-09.nc  f2000.T31T31.control.cam.h0.0012-05.nc
f2000.T31T31.control.cam.h0.0003-02.nc  f2000.T31T31.control.cam.h0.0007-10.nc  f2000.T31T31.control.cam.h0.0012-06.nc
f2000.T31T31.control.cam.h0.0003-03.nc  f2000.T31T31.control.cam.h0.0007-11.nc  f2000.T31T31.control.cam.h0.0012-07.nc
f2000.T31T31.control.cam.h0.0003-04.nc  f2000.T31T31.control.cam.h0.0007-12.nc  f2000.T31T31.control.cam.h0.0012-08.nc
f2000.T31T31.control.cam.h0.0003-05.nc  f2000.T31T31.control.cam.h0.0008-01.nc  f2000.T31T31.control.cam.h0.0012-09.nc
f2000.T31T31.control.cam.h0.0003-06.nc  f2000.T31T31.control.cam.h0.0008-02.nc  f2000.T31T31.control.cam.h0.0012-10.nc
f2000.T31T31.control.cam.h0.0003-07.nc  f2000.T31T31.control.cam.h0.0008-03.nc  f2000.T31T31.control.cam.h0.0012-11.nc
f2000.T31T31.control.cam.h0.0003-08.nc  f2000.T31T31.control.cam.h0.0008-04.nc  f2000.T31T31.control.cam.h0.0012-12.nc
f2000.T31T31.control.cam.h0.0003-09.nc  f2000.T31T31.control.cam.h0.0008-05.nc  f2000.T31T31.control.cam.h0.0013-01.nc
f2000.T31T31.control.cam.h0.0003-10.nc  f2000.T31T31.control.cam.h0.0008-06.nc  f2000.T31T31.control.cam.h0.0013-02.nc
f2000.T31T31.control.cam.h0.0003-11.nc  f2000.T31T31.control.cam.h0.0008-07.nc  f2000.T31T31.control.cam.h0.0013-03.nc
f2000.T31T31.control.cam.h0.0003-12.nc  f2000.T31T31.control.cam.h0.0008-08.nc  f2000.T31T31.control.cam.h0.0013-04.nc
f2000.T31T31.control.cam.h0.0004-01.nc  f2000.T31T31.control.cam.h0.0008-09.nc  f2000.T31T31.control.cam.h0.0013-05.nc
f2000.T31T31.control.cam.h0.0004-02.nc  f2000.T31T31.control.cam.h0.0008-10.nc  f2000.T31T31.control.cam.h0.0013-06.nc
f2000.T31T31.control.cam.h0.0004-03.nc  f2000.T31T31.control.cam.h0.0008-11.nc  f2000.T31T31.control.cam.h0.0013-07.nc
f2000.T31T31.control.cam.h0.0004-04.nc  f2000.T31T31.control.cam.h0.0008-12.nc  f2000.T31T31.control.cam.h0.0013-08.nc
f2000.T31T31.control.cam.h0.0004-05.nc  f2000.T31T31.control.cam.h0.0009-01.nc  f2000.T31T31.control.cam.h0.0013-09.nc
f2000.T31T31.control.cam.h0.0004-06.nc  f2000.T31T31.control.cam.h0.0009-02.nc  f2000.T31T31.control.cam.h0.0013-10.nc
f2000.T31T31.control.cam.h0.0004-07.nc  f2000.T31T31.control.cam.h0.0009-03.nc  f2000.T31T31.control.cam.h0.0013-11.nc
f2000.T31T31.control.cam.h0.0004-08.nc  f2000.T31T31.control.cam.h0.0009-04.nc  f2000.T31T31.control.cam.h0.0013-12.nc
f2000.T31T31.control.cam.h0.0004-09.nc  f2000.T31T31.control.cam.h0.0009-05.nc  f2000.T31T31.control.cam.h0.0014-01.nc
f2000.T31T31.control.cam.h0.0004-10.nc  f2000.T31T31.control.cam.h0.0009-06.nc  f2000.T31T31.control.cam.h0.0014-02.nc
f2000.T31T31.control.cam.h0.0004-11.nc  f2000.T31T31.control.cam.h0.0009-07.nc  f2000.T31T31.control.cam.h0.0014-03.nc
f2000.T31T31.control.cam.h0.0004-12.nc  f2000.T31T31.control.cam.h0.0009-08.nc  f2000.T31T31.control.cam.h0.0014-04.nc
f2000.T31T31.control.cam.h0.0005-01.nc  f2000.T31T31.control.cam.h0.0009-09.nc  f2000.T31T31.control.cam.h0.0014-05.nc
f2000.T31T31.control.cam.h0.0005-02.nc  f2000.T31T31.control.cam.h0.0009-10.nc  f2000.T31T31.control.cam.h0.0014-06.nc
f2000.T31T31.control.cam.h0.0005-03.nc  f2000.T31T31.control.cam.h0.0009-11.nc  f2000.T31T31.control.cam.h0.0014-07.nc
f2000.T31T31.control.cam.h0.0005-04.nc  f2000.T31T31.control.cam.h0.0009-12.nc  f2000.T31T31.control.cam.h0.0014-08.nc
f2000.T31T31.control.cam.h0.0005-05.nc  f2000.T31T31.control.cam.h0.0010-01.nc  f2000.T31T31.control.cam.h0.0014-09.nc
f2000.T31T31.control.cam.h0.0005-06.nc  f2000.T31T31.control.cam.h0.0010-02.nc  f2000.T31T31.control.cam.h0.0014-10.nc
f2000.T31T31.control.cam.h0.0005-07.nc  f2000.T31T31.control.cam.h0.0010-03.nc  f2000.T31T31.control.cam.h0.0014-11.nc
f2000.T31T31.control.cam.h0.0005-08.nc  f2000.T31T31.control.cam.h0.0010-04.nc  f2000.T31T31.control.cam.h0.0014-12.nc
jupyter-annefou@resbaz:~/GEO4962/outputs/runs/f2000.T31T31.control/atm/hist$ ls
f2000.T31T31.control.cam.h0.0001-01.nc  f2000.T31T31.control.cam.h0.0005-09.nc  f2000.T31T31.control.cam.h0.0010-05.nc
f2000.T31T31.control.cam.h0.0001-02.nc  f2000.T31T31.control.cam.h0.0005-10.nc  f2000.T31T31.control.cam.h0.0010-06.nc
f2000.T31T31.control.cam.h0.0001-03.nc  f2000.T31T31.control.cam.h0.0005-11.nc  f2000.T31T31.control.cam.h0.0010-07.nc
f2000.T31T31.control.cam.h0.0001-04.nc  f2000.T31T31.control.cam.h0.0005-12.nc  f2000.T31T31.control.cam.h0.0010-08.nc
f2000.T31T31.control.cam.h0.0001-05.nc  f2000.T31T31.control.cam.h0.0006-01.nc  f2000.T31T31.control.cam.h0.0010-09.nc
f2000.T31T31.control.cam.h0.0001-06.nc  f2000.T31T31.control.cam.h0.0006-02.nc  f2000.T31T31.control.cam.h0.0010-10.nc
f2000.T31T31.control.cam.h0.0001-07.nc  f2000.T31T31.control.cam.h0.0006-03.nc  f2000.T31T31.control.cam.h0.0010-11.nc
f2000.T31T31.control.cam.h0.0001-08.nc  f2000.T31T31.control.cam.h0.0006-04.nc  f2000.T31T31.control.cam.h0.0010-12.nc
f2000.T31T31.control.cam.h0.0001-09.nc  f2000.T31T31.control.cam.h0.0006-05.nc  f2000.T31T31.control.cam.h0.0011-01.nc
f2000.T31T31.control.cam.h0.0001-10.nc  f2000.T31T31.control.cam.h0.0006-06.nc  f2000.T31T31.control.cam.h0.0011-02.nc
f2000.T31T31.control.cam.h0.0001-11.nc  f2000.T31T31.control.cam.h0.0006-07.nc  f2000.T31T31.control.cam.h0.0011-03.nc
f2000.T31T31.control.cam.h0.0001-12.nc  f2000.T31T31.control.cam.h0.0006-08.nc  f2000.T31T31.control.cam.h0.0011-04.nc
f2000.T31T31.control.cam.h0.0002-01.nc  f2000.T31T31.control.cam.h0.0006-09.nc  f2000.T31T31.control.cam.h0.0011-05.nc
f2000.T31T31.control.cam.h0.0002-02.nc  f2000.T31T31.control.cam.h0.0006-10.nc  f2000.T31T31.control.cam.h0.0011-06.nc
f2000.T31T31.control.cam.h0.0002-03.nc  f2000.T31T31.control.cam.h0.0006-11.nc  f2000.T31T31.control.cam.h0.0011-07.nc
f2000.T31T31.control.cam.h0.0002-04.nc  f2000.T31T31.control.cam.h0.0006-12.nc  f2000.T31T31.control.cam.h0.0011-08.nc
f2000.T31T31.control.cam.h0.0002-05.nc  f2000.T31T31.control.cam.h0.0007-01.nc  f2000.T31T31.control.cam.h0.0011-09.nc
f2000.T31T31.control.cam.h0.0002-06.nc  f2000.T31T31.control.cam.h0.0007-02.nc  f2000.T31T31.control.cam.h0.0011-10.nc
f2000.T31T31.control.cam.h0.0002-07.nc  f2000.T31T31.control.cam.h0.0007-03.nc  f2000.T31T31.control.cam.h0.0011-11.nc
f2000.T31T31.control.cam.h0.0002-08.nc  f2000.T31T31.control.cam.h0.0007-04.nc  f2000.T31T31.control.cam.h0.0011-12.nc
f2000.T31T31.control.cam.h0.0002-09.nc  f2000.T31T31.control.cam.h0.0007-05.nc  f2000.T31T31.control.cam.h0.0012-01.nc
f2000.T31T31.control.cam.h0.0002-10.nc  f2000.T31T31.control.cam.h0.0007-06.nc  f2000.T31T31.control.cam.h0.0012-02.nc
f2000.T31T31.control.cam.h0.0002-11.nc  f2000.T31T31.control.cam.h0.0007-07.nc  f2000.T31T31.control.cam.h0.0012-03.nc
f2000.T31T31.control.cam.h0.0002-12.nc  f2000.T31T31.control.cam.h0.0007-08.nc  f2000.T31T31.control.cam.h0.0012-04.nc
f2000.T31T31.control.cam.h0.0003-01.nc  f2000.T31T31.control.cam.h0.0007-09.nc  f2000.T31T31.control.cam.h0.0012-05.nc
f2000.T31T31.control.cam.h0.0003-02.nc  f2000.T31T31.control.cam.h0.0007-10.nc  f2000.T31T31.control.cam.h0.0012-06.nc
f2000.T31T31.control.cam.h0.0003-03.nc  f2000.T31T31.control.cam.h0.0007-11.nc  f2000.T31T31.control.cam.h0.0012-07.nc
f2000.T31T31.control.cam.h0.0003-04.nc  f2000.T31T31.control.cam.h0.0007-12.nc  f2000.T31T31.control.cam.h0.0012-08.nc
f2000.T31T31.control.cam.h0.0003-05.nc  f2000.T31T31.control.cam.h0.0008-01.nc  f2000.T31T31.control.cam.h0.0012-09.nc
f2000.T31T31.control.cam.h0.0003-06.nc  f2000.T31T31.control.cam.h0.0008-02.nc  f2000.T31T31.control.cam.h0.0012-10.nc
f2000.T31T31.control.cam.h0.0003-07.nc  f2000.T31T31.control.cam.h0.0008-03.nc  f2000.T31T31.control.cam.h0.0012-11.nc
f2000.T31T31.control.cam.h0.0003-08.nc  f2000.T31T31.control.cam.h0.0008-04.nc  f2000.T31T31.control.cam.h0.0012-12.nc
f2000.T31T31.control.cam.h0.0003-09.nc  f2000.T31T31.control.cam.h0.0008-05.nc  f2000.T31T31.control.cam.h0.0013-01.nc
f2000.T31T31.control.cam.h0.0003-10.nc  f2000.T31T31.control.cam.h0.0008-06.nc  f2000.T31T31.control.cam.h0.0013-02.nc
f2000.T31T31.control.cam.h0.0003-11.nc  f2000.T31T31.control.cam.h0.0008-07.nc  f2000.T31T31.control.cam.h0.0013-03.nc
f2000.T31T31.control.cam.h0.0003-12.nc  f2000.T31T31.control.cam.h0.0008-08.nc  f2000.T31T31.control.cam.h0.0013-04.nc
f2000.T31T31.control.cam.h0.0004-01.nc  f2000.T31T31.control.cam.h0.0008-09.nc  f2000.T31T31.control.cam.h0.0013-05.nc
f2000.T31T31.control.cam.h0.0004-02.nc  f2000.T31T31.control.cam.h0.0008-10.nc  f2000.T31T31.control.cam.h0.0013-06.nc
f2000.T31T31.control.cam.h0.0004-03.nc  f2000.T31T31.control.cam.h0.0008-11.nc  f2000.T31T31.control.cam.h0.0013-07.nc
f2000.T31T31.control.cam.h0.0004-04.nc  f2000.T31T31.control.cam.h0.0008-12.nc  f2000.T31T31.control.cam.h0.0013-08.nc
f2000.T31T31.control.cam.h0.0004-05.nc  f2000.T31T31.control.cam.h0.0009-01.nc  f2000.T31T31.control.cam.h0.0013-09.nc
f2000.T31T31.control.cam.h0.0004-06.nc  f2000.T31T31.control.cam.h0.0009-02.nc  f2000.T31T31.control.cam.h0.0013-10.nc
f2000.T31T31.control.cam.h0.0004-07.nc  f2000.T31T31.control.cam.h0.0009-03.nc  f2000.T31T31.control.cam.h0.0013-11.nc
f2000.T31T31.control.cam.h0.0004-08.nc  f2000.T31T31.control.cam.h0.0009-04.nc  f2000.T31T31.control.cam.h0.0013-12.nc
f2000.T31T31.control.cam.h0.0004-09.nc  f2000.T31T31.control.cam.h0.0009-05.nc  f2000.T31T31.control.cam.h0.0014-01.nc
f2000.T31T31.control.cam.h0.0004-10.nc  f2000.T31T31.control.cam.h0.0009-06.nc  f2000.T31T31.control.cam.h0.0014-02.nc
f2000.T31T31.control.cam.h0.0004-11.nc  f2000.T31T31.control.cam.h0.0009-07.nc  f2000.T31T31.control.cam.h0.0014-03.nc
f2000.T31T31.control.cam.h0.0004-12.nc  f2000.T31T31.control.cam.h0.0009-08.nc  f2000.T31T31.control.cam.h0.0014-04.nc
f2000.T31T31.control.cam.h0.0005-01.nc  f2000.T31T31.control.cam.h0.0009-09.nc  f2000.T31T31.control.cam.h0.0014-05.nc
f2000.T31T31.control.cam.h0.0005-02.nc  f2000.T31T31.control.cam.h0.0009-10.nc  f2000.T31T31.control.cam.h0.0014-06.nc
f2000.T31T31.control.cam.h0.0005-03.nc  f2000.T31T31.control.cam.h0.0009-11.nc  f2000.T31T31.control.cam.h0.0014-07.nc
f2000.T31T31.control.cam.h0.0005-04.nc  f2000.T31T31.control.cam.h0.0009-12.nc  f2000.T31T31.control.cam.h0.0014-08.nc
f2000.T31T31.control.cam.h0.0005-05.nc  f2000.T31T31.control.cam.h0.0010-01.nc  f2000.T31T31.control.cam.h0.0014-09.nc
f2000.T31T31.control.cam.h0.0005-06.nc  f2000.T31T31.control.cam.h0.0010-02.nc  f2000.T31T31.control.cam.h0.0014-10.nc
f2000.T31T31.control.cam.h0.0005-07.nc  f2000.T31T31.control.cam.h0.0010-03.nc  f2000.T31T31.control.cam.h0.0014-11.nc
f2000.T31T31.control.cam.h0.0005-08.nc  f2000.T31T31.control.cam.h0.0010-04.nc  f2000.T31T31.control.cam.h0.0014-12.nc
~~~
{: .output}

# What is a climatology?

A Climatology is a climate data series.

In this lesson, we will use climatological data issued from the [Stratosphere-troposphere Processes And their Role in Climate](https://www.sparc-climate.org/) project (SPARC) 
and in particular the [Temperature and Zonal Wind Climatology](https://www.sparc-climate.org/data-centre/data-access/reference-climatology/randals-climatologies/temperature-wind-climatology/).


## SPARC Climatology


These data sets provide an updated climatology of zonal mean temperatures and winds covering altitudes 0-85 km. They are based on combining data from a variety of sources, and represent the time period 1992-1997.


The zonal mean temperature climatology is derived using UK Met Office (METO) analyses over 1000-1.5 hPa, combined with Halogen Occultation Experiment (HALOE) temperature climatology over pressures 1.5-0.0046 hPa (~85 km).

<img src="https://www.sparc-climate.org/wp-content/uploads/sites/5/2018/01/DC-TZWClim-temperature_anim.gif">



The monthly zonal wind climatology is derived from the UARS Reference Atmosphere Project (URAP), combining results from METO analyses with winds the UARS High Resolution Doppler Imager (HRDI). Details from the URAP winds are described in Swinbank and Ortland (2003).

<img src="https://www.sparc-climate.org/wp-content/uploads/sites/5/2018/01/DC-TZWClim-zonal_wind_anim.gif">

[NCAR's Climate Data Guide](https://climatedataguide.ucar.edu/) (CDG) provides more information (search SPARC) including strengths and weaknesses of assorted data sets.

# Compare the control run to the SPARC climatology

## Methodology


## Exercice-1

1.  <font color="red">How well does CAM5 (T31/L30, 5 yr control run) represent observations?</font>

1.  Select T,U,hyam,hybm,PS (use ncks) for all the model outputs of the control experiment (/projects/NS1000K/GEO4962/outputs/runs/f2000.T31T31.control/atm/hist). Save these new output files in the directory $HOME/GEO4962/control/.
2.  Use ncra to get an average for all the January months. Repeat it for each month (February to December).
3.  Use [zonal_2.ncl](http://www.ncl.ucar.edu/Applications/Scripts/zonal_2.ncl) and [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) to get a zonal mean and interpolate to pressure levels. Make sure you choose your pressure levels (change the variable **pnew** in [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) so you can easily compare with SPARC climatology).
4.  You may use [sparc_2.ncl](https://www.ncl.ucar.edu/Applications/Scripts/sparc_2.ncl) to get plots similar to those we got with the SPARC climatology. You can also use panoply (or python).

<font color="red">Fulfill the first exercise until the next practical on March 3, 2019!</font>


<font color="red">On NIRD (login.nird.sigma2.no):</font>


<pre>cd /projects/NS1000K/GEO4962/outputs/runs/f2000.T31T31.control/atm/hist
</pre>

-  <font color="red">How many years did we run?</font>
-  <font color="red">What is the output frequency?</font>



1.  [Selection of variables of interest and visualization](#Selection-of-variables-of-interest-and-visualization)
2.  [Computation of yearly or zonal mean](#Computation-of-yearly-or-zonal-means)
3.  [Conversion from Sigma coordinates to pressure levels](#Conversion-from-Sigma-coordinates-to-pressure-levels)

### **NIRD**

#### Setup on NIRD

<font color="red">On NIRD:</font>

<pre>export PATH=/projects/NS1000K/panoply/4.4.3/:$PATH
</pre>

*Notes: this is to allow you to use panoply (without installing it), also the modules cdo and ncl are already loaded by default.*


#### Selection of variables of interest and visualization

Here we are going to use [ncks](http://nco.sourceforge.net/nco.html#ncks-netCDF-Kitchen-Sink).

**ncks** stands for "NetCDF Kitchen Sink" and it will allow us to extract a subset of the data (for instance to produce a new netCDF file containing only the temperature variable T) from an input-file (in this example the file corresponds to the month of January of the 5th year simulated).

<font color="red">On NIRD:</font>

<pre>mkdir -p $HOME/GEO4962/control
ncks -v T f2000.T31T31.control.cam.h0.0005-01.nc $HOME/GEO4962/control/T_f2000.T31T31.control.cam.h0.0005-01.nc
</pre>

We are now going to use **panoply** to visualize the temperature field.

<font color="red">On NIRD:</font>

<pre>panoply.sh</pre>

This opens a window where you can select the file that was just created (T_f2000.T31T31.control.cam.h0.0005-01.nc) in the directory $HOME/GEO4962/control. 

Then double click on the line with "   T       Temperature       Geo2D   " and click on the **Create** button.

<img src="../fig/panoply.png">

Explore other types of plot with panoply.

Back to **ncks**, several variables can be extracted at the same time.

<font color="red">On NIRD:</font>

<pre>
ncks -v T,U,hyam,hybm,PS f2000.T31T31.control.cam.h0.0003-03.nc $HOME/GEO4962/control/TU_f2000.T31T31.control.cam.h0.0003-03.nc
ncks -v T,U,hyam,hybm,PS f2000.T31T31.control.cam.h0.0004-12.nc $HOME/GEO4962/control/TU_f2000.T31T31.control.cam.h0.0004-12.nc
ncks -v T,U,hyam,hybm,PS f2000.T31T31.control.cam.h0.0005-01.nc $HOME/GEO4962/control/TU_f2000.T31T31.control.cam.h0.0005-01.nc
</pre>

-  <font color="red">Use panoply to visualize your new netCDF files</font>
-  <font color="red">Use a shell loop to extract T and U (and hyam, hybm and PS) from all the model outputs (control experiment) and store the resulting netCDF files in $HOME/GEO4962/control/</font>

(Example of solution (to run from the folder containing the .nc files): for file in *.nc; do ncks -v T,U,hyam,hybm,PS $file $HOME/GEO4962/control/TU_$file; done)


##### Compute yearly or zonal means

TODO


##### Convert to Pressure levels

The vertical coordinate in CESM is what is called a *hybrid sigma-pressure system*. In this system, the upper regions of the atmosphere are discretized by pressure only. Lower vertical levels use the sigma (i.e. the pressure at a given level divided by the surface pressure ) vertical coordinate *smoothly merged in*, with the lowest levels being pure sigma.

It is therefore **wrong** to assume that these sigma levels are the same as pressure levels and one has instead to converts from the hybrid coordinates to pressure levels in order to create plots, etc. 

For this purpose several tools have been developped at NCAR to perform the [vertical interpolation](http://www.ncl.ucar.edu/Applications/vert_interp.shtml).

In this lesson we are going to use the **vert_1.ncl** script.

1.  Download [vert_1.ncl](http://www.ncl.ucar.edu/Applications/Scripts/vert_1.ncl) and transfer it to NIRD. Here we assume you have your vert_1.ncl script in **$HOME/GEO4962/control/**.

2.  Edit vert_1.ncl (use your favourite editor such as emacs or vi) and change the input file name (in this example we use the month of March from the third simulation year):

    <pre>   fn  = "TU_f2000.T31T31.control.cam.h0.0003-03.nc" ; define filename
    </pre>

3.  Then run your script with ncl.

<font color="red">On NIRD:</font>

<pre>
ncl vert_1.ncl
</pre>

The desired pressure levels defined in the script are:

<pre>  pnew = (/ 850.0,700.0,500.0,300.0,200.0 /)        
</pre>

This script also produces 3 contour plots showing the temperature at 850mb, 500mb and 200mb:

<img src="../fig/T850-500-200.png">

{% include links.md %}

