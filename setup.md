---
title: Setup
---

Setup instructions will be sent by email to all participants with information on:

- How to get an account for computational resources with [Notur](https://www.metacenter.no/user/application/form/notur/) and project NN1000K
- How to get an account for storage resources with [NIRD/Norstore](https://www.metacenter.no/user/application/form/norstore/) and project NS1000K
- How to login (username and password) to the jupyterhub instance that we will be using for analyzing and visualizing model outputs.


For the course, you will need to bring your laptop:

### Linux users

Make sure you have installed a recent version of [google-chrome](https://www.google.com/chrome/) (required for the jupyterhub).
You may try to use other web browser but we cannot guarantee that all functionalities will be available.

### Mac-OSX users

You cannot use Safari for the Jupyterhub, so make sure you install a recent version of [google-chrome](https://www.google.com/chrome/).

In order to avoid issues with the local environment language/keyboard variables when login on Abel from your Mac you can either:
  Option A)
   On your Mac
     - Open a terminal
     - Go into the **Preferences**
     - Then into the **Advanced** tab for the terminal settings profile (Basic)
     - At the bottom **untick** the option to Set local environment variables on startup*
      (Note that this only affects new terminals, not those that are already open)

  Option B)
    On Abel
      - Set the language environment variable with the command **export LC_ALL=$LANG**
      - At the bottom **untick** the option to Set local environment variables on startup*

## Windows users

As for other operating systems, you would need a recent web browser and we strongly suggest to use [google-chrome](https://www.google.com/chrome) as all the tutorial has been tested with it.

In addition, you need to install [MobaXterm](https://mobaxterm.mobatek.net/) an enhanced terminal for Windows with X11 server, tabbed SSH client, network tools and much more.

Download the free version [here](https://mobaxterm.mobatek.net/download.html).

And follow the installation instructions. Let us know if you have any problems.

{% include links.md %}
