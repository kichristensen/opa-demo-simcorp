#!/bin/bash

if kubectl get configmap ingress-conflicts -n opa &> /dev/null; then
    echo "Deleting old configmap..."
    kubectl delete configmap ingress-conflicts -n opa &> /dev/null
fi

if kubectl get ns production &> /dev/null; then
    echo "Deleting old production namespace..."
    kubectl delete ns production &> /dev/null
    kubectl get ns production &> /dev/null
    count=0
    while [ $? -eq 0 ]; do
        count=$((count + 1))
        sleep 5
        if [ $((count % 5)) ]; then
            echo "Still waiting..."
        fi
        kubectl get ns production &> /dev/null
    done
fi

if kubectl get ns staging &> /dev/null; then
    echo "Deleting old staging namespace..."
    kubectl delete ns staging &> /dev/null
    kubectl get ns staging &> /dev/null
    count=0
    while [ $? -eq 0 ]; do
        count=$((count + 1))
        sleep 5
        if [ $((count % 5)) ]; then
            echo "Still waiting..."
        fi
        kubectl get ns staging &> /dev/null
    done
fi

exit 0