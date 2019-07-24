#!/bin/sh

echo "\n$hr\nREBASE\n$hr"

USER=MarketLeader
REPO=Tutorial-Buka-Toko
UPSTREAM=https://github.com/mirumee/saleor.git
echo origin is $ORIGIN
cd $HOME && rm -rf $REPO
git clone $ORIGIN && cd $REPO
[ `git rev-parse --abbrev-ref HEAD` != master ] && git checkout master

git remote add upstream $UPSTREAM
git pull --rebase upstream master
git reset --hard upstream/master

[ $BRANCH_NAME != 'master' ] && return
git push origin master --force
git status
