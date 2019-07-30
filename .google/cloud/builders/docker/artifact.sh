#!/bin/sh

echo "\n$hr\nDOCKER VERSION\n$hr"
docker version

echo "\n$hr\nDOCKER INFO\n$hr"
docker info

echo "$hr\nIMAGE BUILDERS\n$hr"
docker images --all | sort

echo "\n$hr\nCURRENTLY RUNNING\n$hr"
docker ps
