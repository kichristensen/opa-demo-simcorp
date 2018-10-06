#!/bin/bash

set -eE

trap 'echo "An error occured, policy was not deployed"' ERR

./cleanup.sh

kubectl create configmap ingress-whitelist --from-file=ingress-whitelist.rego -n opa &> /dev/null
kubectl apply -f namespaces.yaml &> /dev/null

echo "Policy deployed!!!"