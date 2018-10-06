#!/bin/bash

if kubectl get pod simcorp-image &> /dev/null; then
    kubectl delete pod simcorp-image
fi

echo "Trying to deploy image from Docker hub..."
echo "kubectl apply -f docker-hub-image.yaml"
kubectl apply -f docker-hub-image.yaml

printf "\n\n"

echo "Trying to deploy image from SimCorp registry..."
echo "kubectl apply -f docker-hub-image.yaml"
kubectl apply -f simcorp-image.yaml