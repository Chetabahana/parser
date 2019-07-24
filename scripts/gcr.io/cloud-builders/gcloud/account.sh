#!/bin/sh

# Script to bring in your account credentials and private repo
# Remove or mark the line below with '#' to run this script.
#return

# Private repository
# Set 'mirror configuration' of the private repository and IAM 
# role to the Builder. Then call it without any credential:

if [ ! -f $HOME/.ssh ]
then
	gcloud source repos clone --verbosity=none `gcloud source \
	repos list --limit=1 --format 'value(REPO_NAME)'` .io
	if [ $BRANCH_NAME != master ]
	then
	    cd .io && git checkout $BRANCH_NAME && cd ..
    fi
	find .io -type d -name $PROJECT_ID -exec cp -frpT {} $HOME \;
fi

# Account credentials
for i in id_rsa common_env json_key google_compute_engine; do
	if [ -f $HOME/.ssh/$i.enc ]  
	then
		if [ "$i" != "json_key" ]
		then
		    j=$i
	    else
		    read_lines $HOME/.ssh/common_env
		    j=$(basename $GOOGLE_APPLICATION_CREDENTIALS)
		fi
		gcloud kms decrypt \
		--keyring my-keyring --key $i \
		--plaintext-file $HOME/.ssh/$j \
		--ciphertext-file $HOME/.ssh/$i.enc \
		--location global
	fi
done	

# Private environtment
if [ ! -z "$(gcloud compute instances list)" ]
then
	NAME=`gcloud compute instances list --limit=1 \
	--format 'value(name)' --filter="status=('RUNNING')"`
	ZONE=`gcloud compute instances list --limit=1 \
	--format 'value(zone)' --filter="status=('RUNNING')"`
	echo "ZONE=$ZONE" >> $HOME/.ssh/common_env
	echo "INSTANCE=$PROJECT_ID@$NAME" >> $HOME/.ssh/common_env
fi