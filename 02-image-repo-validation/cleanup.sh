#!/bin/bash

if kubectl get configmap image-repo-validation -n opa &> /dev/null; then
    echo "Deleting old configmap..."
    kubectl delete configmap image-repo-validation -n opa &> /dev/null
fi