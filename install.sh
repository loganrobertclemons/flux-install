#! /bin/bash

sudo chmod +x initKey.sh

#installs flux and helm operator that will kick off server deployment
./initKey.sh
./installFlux.sh
./installHelmOperator.sh
