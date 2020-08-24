#! /bin/bash

sudo chmod +x initKey.sh

helm repo add fluxcd https://charts.fluxcd.io
kubectl create namespace flux

#installs flux and helm operator that will kick off server deployment
./initKey.sh
./installFlux.sh
./installHelmOperator.sh

sudo rm -rf id_*
