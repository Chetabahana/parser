#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nSSH FILES\n$hr"
[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh
chmod 600 /root/.ssh/*
ls -lL /root/.ssh

if [ $PROJECT_ID = 'marketleader' ]  
then 
	[ $REPO_NAME = 'Tutorial-Buka-Toko' ] && export BUILD='taxonomy'
else
	[ $BRANCH_NAME = 'master' ] && export tagname='chetabahana/branches'
fi

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD
