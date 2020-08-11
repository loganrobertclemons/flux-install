# Flux

## Prerequisites
Install fluxctl
```
brew install fluxctl
```

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
