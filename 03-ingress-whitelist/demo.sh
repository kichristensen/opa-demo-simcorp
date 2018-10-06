#!/bin/bash

echo "Trying invalid ingress..."
echo "kubectl apply -f ingress-bad.yaml -n qa"
kubectl apply -f ingress-bad.yaml -n qa

printf "\n\n"

echo "Trying to create valid ingress..."
echo "kubectl apply -f ingress-ok.yaml -n production"
kubectl apply -f ingress-ok.yaml -n production