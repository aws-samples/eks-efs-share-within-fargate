#!/bin/bash
# Export the referenced variables to be used further in the epics.

while [ -z "${ACCOUNT_ID// }" ]
do
  export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
done

while [ -z "${AWS_REGION// }" ]
do
  export AWS_REGION=$(aws configure get region)
done

while [ -z "${CLUSTER_NAME// }" ]
do
  echo "Inform your Amazon EKS Cluster Name: "
  read CLUSTER_NAME
  export CLUSTER_NAME=$CLUSTER_NAME
done

while [ -z "${EFS_CREATION_TOKEN// }" ]
do
  export EFS_CREATION_TOKEN=$(uuidgen)
done

#while [ -z "${KMS_KEY_ALIAS// }" ]
#do
#  echo "Inform your AWS KMS Key alias:"
#  read KMS_KEY_ALIAS
#  export KMS_KEY_ALIAS=$KMS_KEY_ALIAS
#done
