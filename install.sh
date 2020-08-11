#! /bin/bash

read -p 'GitHub Repo: ' REPO
read -p 'GitHub Username: ' USERNAME
read -p 'GitHub Email: ' EMAIL
read -sp 'GitHub Password: ' PASSWORD

#creates the flux namespace and generates an ssh key
kubectl create namespace flux
ssh-keygen -t rsa -N '' -f ~/flux-install/id_rsa -C flux <<< y
kubectl create secret generic flux-ssh --from-file=identity=id_rsa -n flux

#creates an executable to be invoked that creates a git deploy key on the repo specified above
cat <<EOF >>git-key-deploy.sh
#! /bin/bash
curl \
  -X POST \
  -u $USERNAME:$PASSWORD \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$USERNAME/$REPO/keys \
  -d '{"key":"$(cat ./flux-install/id_rsa.pub)","title":"flux-ssh"}'
EOF

sudo chmod +x git-key-deploy.sh
./git-key-deploy.sh
rm git-key-deploy.sh

#installs flux and helm operator that will kick off server deployment
./installFlux.sh
./installHelmOperator.sh

rm id_rsa
rm id_rsa.pub