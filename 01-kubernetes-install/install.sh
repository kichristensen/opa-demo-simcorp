#!/bin/bash
set -eE

trap 'echo "An error occured, OPA was NOT deployed"' ERR

# Cleanup in case the command has already
./cleanup.sh

# Create OPA namespace
kubectl create namespace opa &> /dev/null

./generate-certs.sh

echo "Deploying OPA to K8S..."

# Install certificates
kubectl create secret tls opa-server --cert=server.crt --key=server.key -n opa &> /dev/null

# Deploy admission controller
kubectl apply -f admission-controller.yaml &> /dev/null

# Create and deploy webhook
cat > webhook-configuration.yaml <<EOF
kind: ValidatingWebhookConfiguration
apiVersion: admissionregistration.k8s.io/v1beta1
metadata:
  name: opa-validating-webhook
webhooks:
  - name: validating-webhook.openpolicyagent.org
    rules:
      - operations: ["CREATE", "UPDATE"]
        apiGroups: ["*"]
        apiVersions: ["*"]
        resources: ["*"]
    clientConfig:
      caBundle: $(cat ca.crt | base64 | tr -d '\n')
      service:
        namespace: opa
        name: opa
EOF

kubectl apply -f webhook-configuration.yaml &> /dev/null

echo "OPA deployed!!!"