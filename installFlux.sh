##
# Install Flux
##
# 0 = Environment
##

if [ "$#" -ne 1 ]; then
  echo "Usage: ./installFlux"
  exit 1
fi

# set vars
ENVIRONMENT=$1

# Helm install flux
helm upgrade --install flux \
fluxcd/flux --version 1.3.0 \
-f values/flux-sbx.yaml \
-n flux