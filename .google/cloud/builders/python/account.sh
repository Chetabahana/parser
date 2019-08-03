#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nSSH FILES\n$hr"
[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh
chmod 600 /root/.ssh/*
ls -lL /root/.ssh

echo "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo "\n$hr\nALL REPOSITORY\n$hr"
ls -al /

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

echo "\n$hr\nCLONE ORIGIN\n$hr"
REPO=$(basename $ORIGIN .git)
rm -rf $REPO && git clone $ORIGIN $REPO

cd $REPO
git checkout master
git branch -D Chetabahana
git branch -m Chetabahana
cd ..

echo "\n$hr\nCOPYING\n$hr"
FLOWNAME=Toko-Chetabahana
WORKFLOW=$FLOWNAME/branches/.google
FLOW_GIT=https://github.com/MarketLeader/$FLOWNAME.git

rm -rf $FLOWNAME && git clone $FLOW_GIT
cp -frpvT $WORKFLOW $REPO/.google
find .io -type d -name $REPO -exec cp -frpvT {} $REPO \;

echo "\n$hr\nORIGIN REPOSITORY\n$hr"
cd $REPO && ls -al .

[ $HOME = /root ] && return
echo "\n$hr\nPUSH REPOSITORY\n$hr"
ln -s $HOME/.ssh/push /bin/push
chmod +x /bin/push && push $ORIGIN
git gc --aggressive --prune=all
