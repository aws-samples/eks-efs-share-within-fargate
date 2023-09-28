#!/bin/bash

BASEDIR=$(dirname "$0")

# Deploy Amazon EFS CSI driver into the cluster
kubectl create -f \
  https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/deploy/kubernetes/base/csidriver.yaml

# Deploy the Storage Class into the cluster
FILE_SYSTEM_ID=$(aws efs describe-file-systems --creation-token $EFS_CREATION_TOKEN --query 'FileSystems[].FileSystemId' --output text)
cat <<EOF | kubectl apply -f -
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
parameters:
  fileSystemId: $FILE_SYSTEM_ID
EOF