#!/bin/sh

# Private repository
# Set 'mirror configuration' of the private repository and IAM 
# role to the Builder. Then call it without any credential:

if [ ! -f $HOME/.ssh ]
then
    gcloud source repos clone --verbosity=none `gcloud source \
    repos list --limit=1 --format 'value(REPO_NAME)'` .io
    if [ $BRANCH_NAME != master ]
    then
        cd .io
        if grep -q origin/$BRANCH_NAME << EOF
`git branch -r`
EOF
        then
            git checkout $BRANCH_NAME
        fi
        cd ..
    fi
    find .io -type d -name $PROJECT_ID -exec cp -frpT {} $HOME \;
fi

# Account credentials
for i in id_rsa env_keys google_compute_engine; do
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
    echo "ZONE=$ZONE" >> $HOME/.ssh/env_keys
    echo "INSTANCE=$PROJECT_ID@$NAME" >> $HOME/.ssh/env_keys
fi

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nPROJECT CONFIG\n$hr"
gcloud config list --all

echo "\n$hr\nSYSTEM INFO\n$hr"
gcloud info
