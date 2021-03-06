#!/bin/bash
set -eE

trap 'echo "Error while generating certificates"' ERR

echo "Generating certificates..."

openssl genrsa -out ca.key 2048 &> /dev/null
openssl req -x509 -new -nodes -key ca.key -days 100000 -out ca.crt -subj "/CN=admission_ca" &> /dev/null

cat >server.conf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
EOF

openssl genrsa -out server.key 2048 &> /dev/null
openssl req -new -key server.key -out server.csr -subj "/CN=opa.opa.svc" -config server.conf &> /dev/null
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 100000 -extensions v3_req -extfile server.conf &> /dev/null