#!/bin/sh

# Account credentials
for i in id_rsa common_env google_compute_engine; do
	if [ -f $HOME/.ssh/$i.enc ]  
	then
		gcloud kms decrypt \
		--keyring my-keyring --key $i \
		--plaintext-file $HOME/.ssh/$i \
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