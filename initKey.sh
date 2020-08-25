#! /bin/bash

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add fluxcd https://charts.fluxcd.io

helm repo update

read -p 'GitHub Repo: ' REPO
read -p 'GitHub Username: ' USERNAME
read -sp 'GitHub Password: ' PASSWORD

#creates the flux namespace and generates an ssh key
kubectl create namespace flux
ssh-keygen -t rsa -N '' -f id_rsa -C flux <<< y
kubectl create secret generic flux-ssh --from-file=identity=id_rsa -n flux

#creates an executable to be invoked that creates a git deploy key on the repo specified above
cat <<EOF >>git-key-deploy.sh
#! /bin/bash
curl \
  -X POST \
  -u ${USERNAME}:${PASSWORD} \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/${USERNAME}/${REPO}/keys \
  -d '{"key":"$(cat id_rsa.pub)","title":"flux-ssh"}'
EOF

chmod +x git-key-deploy.sh
./git-key-deploy.sh
rm git-key-deploy.sh
