#!/bin/sh

#Package
TAG="Chetabahana"
APP="gevent gunicorn"
DEV="gittle"

#Error trap
abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occurred. Exiting..." >&2
    exit 1
}
trap 'abort' 0
set -e

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo "\n$hr\nCLONE ORIGIN\n$hr"
rm -rf $REPO_NAME && git clone $ORIGIN $REPO_NAME && cd $REPO_NAME
[ `git rev-parse --abbrev-ref HEAD` != $TAG ] && git checkout $TAG

echo "\n$hr\nPIPENV\n$hr"
rm -rf $HOME/.local && mkdir $HOME/.local
export PATH=$HOME/.local/bin:$PATH

apt-get -y update \
  && apt-get install -y gettext \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

pip install --upgrade pip
pip install --upgrade setuptools
pip install --user pipenv

echo "\n$hr\nPIPFILE\n$hr"
cat Pipfile

echo "\n$hr\nDEFAULT\n$hr"
sed -i 's|.<|,<|g' Pipfile && sed -i 's|.>|,>|g' Pipfile
[ -n "$APP" ] && pipenv install $APP || pipenv sync

echo "\n$hr\nDEV\n$hr"
pipenv install $DEV --dev --system --deploy

echo "\n$hr\nGRAPH\n$hr"
pipenv graph

echo "\n$hr\nCHECK\n$hr"
pipenv check

echo "\n$hr\nBIN FILES\n$hr"
VENV=`pipenv --venv`
ls -al $VENV/bin

echo "\n$hr\nRECHECK\n$hr"
pipenv check

echo "\n$hr\nTRANSIFEX\n$hr"
pipenv run tx pull -l id

echo "\n$hr\nPIPLOCK\n$hr"
pipenv lock -r > requirements.txt
cat requirements.txt

echo "\n$hr\nDEV PIPLOCK\n$hr"
pipenv lock -r -d > requirements_dev.txt
cat requirements_dev.txt
trap : 0

echo "\n$hr\nPUSH\n$hr"
if grep -Fqe "error" << EOF
`pipenv check`
EOF
then
    return
else
   ln -s $HOME/.ssh/push $VENV/bin/push
   pipenv run chmod +x /bin/push
   pipenv run push $ORIGIN
fi
