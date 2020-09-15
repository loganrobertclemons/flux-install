# Flux

initKey.sh grabs the repo from the user where the helmfiles live, creates the clusterrole for nginx binding, then creates the flux namespace and generates an ssh key. Then it creates an executable that attaches a deploy key to the repo specified earlier. Then it install flux and helm-operator on the cluster.

## Deploy
Add helm repo:
```
helm repo add fluxcd https://charts.fluxcd.io
```

Run install:
```
./install.sh
```

## Usage
Force flux sync:
```
fluxctl sync --k8s-fwd-ns=flux
```
