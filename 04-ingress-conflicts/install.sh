#!/bin/bash

set -eE

trap 'echo "An error occured, policy was not deployed"' ERR

./cleanup.sh

kubectl create configmap ingress-conflicts --from-file=ingress-conflicts.rego -n opa &> /dev/null
kubectl apply -f namespaces.yaml &> /dev/null

echo "Policy deployed!!!"