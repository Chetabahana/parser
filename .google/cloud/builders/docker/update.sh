#!/bin/sh

echo "\n$hr\nREBASE\n$hr"

USER=MarketLeader
REPO=Tutorial-Buka-Toko
UPSTREAM=https://github.com/mirumee/saleor.git

cd $HOME && rm -rf $REPO
git clone $ORIGIN && cd $REPO
[ `git rev-parse --abbrev-ref HEAD` != master ] && git checkout master

git remote add upstream $UPSTREAM
git pull --rebase upstream master
git reset --hard upstream/master

[ $BRANCH_NAME != 'master' ] && return
git push origin master --force
git status

#cd $REPO_NAME && git checkout -B Chetabahana && cd ..
#LOWER="`echo ${CF_REPO_OWNER} | tr '[:upper:]' '[:lower:]'`"
#find .io -type d -name $REPO_NAME -exec cp -frpvT {} $REPO_NAME \;
