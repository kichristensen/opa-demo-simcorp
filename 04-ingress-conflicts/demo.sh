#!/bin/bash

echo "Creating ingress in production namespace..."
echo "kubectl apply -f ingress-ok.yaml -n production"
kubectl apply -f ingress-ok.yaml -n production

printf "\n\n"

echo "Creating ingress in staging namespace..."
echo "kubectl apply -f ingress-ok.yaml -n production"
kubectl apply -f ingress-ok.yaml -n staging