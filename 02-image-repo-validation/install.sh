#!/bin/bash

set -eE

trap 'echo "An error occured, policy was not deployed"' ERR

./cleanup.sh

kubectl create configmap image-repo-validation --from-file=image-repo-validation.rego -n opa

echo "Policy deployed!!!"

sleep 1
echo "Showing status..."

kubectl get configmap image-repo-validation -n opa -o yaml | ack --passthru 'openpolicyagent.org/policy-status:' -