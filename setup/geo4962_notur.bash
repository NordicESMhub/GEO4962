#!/bin/bash

# create cesm directory

module load cesm/1.2.2

if [ ! -d "$HOME/cesm" ]; then
  mkdir $HOME/cesm
  fi

  cd $HOME/cesm

  rsync -avz ${USER}@abel.uio.no:$CESM_HOME/cesm1_2_2 .

  cd $HOME/cesm/cesm1_2_2/scripts 

  if [ ! -d "/work/users/$LOGNAME/inputdata" ]; then
    ./link_dirtree $CESM_DATA /work/users/$LOGNAME/inputdata
  fi

  if [ ! -f "~/.ccsm_proj" ]; then
cat > ~/.ccsm_proj << EOFM
nn1000k
EOFM
  fi
