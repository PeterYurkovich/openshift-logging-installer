#!/bin/bash

if [ -z "$LOKI_PATH" ]
then
    echo "LOKI_PATH is not defined"
    exit 1
fi

if [ -z "$S3_BUCKET_NAME" ]
then
    echo "S3_BUCKET_NAME is not defined"
    exit 1
fi

if [ -z "$REGISTRY_ORG" ]
then
    echo "REGISTRY_ORG is not defined"
    exit 1
fi

echo "Creating namespaces"
oc create namespace openshift-operators-redhat
oc label ns/openshift-operators-redhat openshift.io/cluster-monitoring=true --overwrite

oc create namespace openshift-logging
oc label ns/openshift-logging openshift.io/cluster-monitoring=true --overwrite

echo "Installing Loki Operator"
cd "${LOKI_PATH}/operator"
make olm-deploy REGISTRY_ORG=$REGISTRY_ORG VARIANT=openshift

