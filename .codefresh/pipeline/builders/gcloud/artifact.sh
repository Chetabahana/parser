#!/bin/sh

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo "\n$hr\nSYSTEM INFO\n$hr"
gcloud info

echo "$hr\nPROJECT CONFIG\n$hr"
gcloud config list --all

echo "\n$hr\nFILE SYSTEM\n$hr"
df -h

echo "\n$hr\nRAM\n$hr"
cat /proc/meminfo

echo "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo "\n$hr\nALL REPOSITORY\n$hr"
pwd
ls -al /

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

echo "\n$hr\nCF_VOLUME_PATH REPOSITORY\n$hr"
ls -al ${CF_VOLUME_PATH}
