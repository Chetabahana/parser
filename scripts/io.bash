#!/bin/bash

# Adjust column numbers ('190') follow to your screen
printf -v res %190s
export hr=`printf '%s\n' "${res// /-}"`
export hrd=`printf '%s\n' "${res// /=}"`

# Unmark the 2 line below to see all commands available
#echo -e "\n$hr\nPATH COMMANDS\n$hr"
#compgen -c | xargs which -a | sort

# Name of current step
[ -f steps.csv ] && date +%s >> steps.csv || gcloud builds \
describe ${1} --format 'value(steps.name)' > steps.csv

# Take the last word only
STEPNAME=$(head -n 1 steps.csv | cut -d ';' -f `wc -l < steps.csv`)
BASENAME=$(basename $STEPNAME); BASENAME=${BASENAME##*-}; BASENAME=${BASENAME##*_};

bash scripts/${5}/$BASENAME.env ${1} ${2} ${3} ${4} ${5}
