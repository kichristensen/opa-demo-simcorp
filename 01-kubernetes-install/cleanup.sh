#!/bin/bash

echo "Cleaning up in case OPA has already been installed..."
if kubectl get ns opa &> /dev/null; then
    kubectl delete ns opa &> /dev/null
    kubectl get ns opa &> /dev/null
    echo "Waiting for OPA namespace to be deleted..."
    count=0
    while [ $? -eq 0 ]; do
        count=$((count + 1))
        sleep 5
        if [ $((count % 5)) ]; then
            echo "Still waiting..."
        fi
        kubectl get ns opa &> /dev/null
    done
    echo "OPA namespace was deleted.."
fi

echo "Deleting old certificate files..."
rm -f ca.crt ca.key ca.srl server.conf server.crt server.csr server.key webhook-configuration.yaml