#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
ln -s $HOME/.ssh /root/.ssh
chmod 600 /root/.ssh/*
git config --list
id
gcloud config list --format='value(core.account)'

echo "$hr\nSSH FILES\n$hr"
ls -lL /root/.ssh

echo "\n$hr\nENVIRONTMENT\n$hr"
export ORIGIN=$GIT_URL@github.com/${CF_REPO_OWNER}/${CF_REPO_NAME}.git
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

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
ls -al .
