#!/bin/sh

return

echo -e "$hr\nWHOAMI\n$hr"
whoami
echo $HOME

if [ ! -f $HOME/.cf/config ]
then
	gcloud source repos clone --verbosity=none `gcloud source \
	repos list --limit=1 --format 'value(REPO_NAME)'` .io
	[ ${4} != master ] && ( cd .io && git checkout ${4} && cd .. )
	find .io -type d -name ${2} -exec cp -frpT {} $HOME \;
fi

git config --list
id

if [ $PROJECT_ID = 'chetabahana' ]; then  
	echo -e "\n$hr\nAGENT\n$hr"
	eval `ssh-agent` && apt-get update > /dev/null
	apt-get --assume-yes install expect > /dev/null
	[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh 
	expect /root/.ssh/agent > /dev/null && ssh-add -l
fi

if [ $PROJECT_ID = 'marketleader' ]  
then 
	export GIT=https://chetabahana:`cat $HOME/.ssh/github_token`@github.com
	[ $REPO_NAME = 'Tutorial-Buka-Toko' ] && export BUILD='taxonomy'
else
	[ $BRANCH_NAME = 'master' ] && export tagname='chetabahana/branches'
fi

