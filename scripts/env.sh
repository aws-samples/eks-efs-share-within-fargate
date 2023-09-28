#!/bin/bash
# Export the referenced variables to be used further in the epics.

while [ -z "${ACCOUNT_ID// }" ]
do
  echo "Inform the AWS Account ID: "
  read ACCOUNT_ID
  export ACCOUNT_ID=$ACCOUNT_ID
done

while [ -z "${AWS_REGION// }" ]
do
  echo "Inform ypur AWS Region: "
  read AWS_REGION
  export AWS_REGION=$AWS_REGION
done

while [ -z "${CLUSTER_NAME// }" ]
do
  echo "Inform your Amazon EKS Cluster Name: "
  read CLUSTER_NAME
  export CLUSTER_NAME=$CLUSTER_NAME
done

while [ -z "${EFS_CREATION_TOKEN// }" ]
do
  echo "Inform the Amazon EFS Creation Token: "
  read EFS_CREATION_TOKEN
  export EFS_TOKEN=$EFS_CREATION_TOKEN
done

while [ -z "${KMS_KEY_ALIAS// }" ]
do
  echo "Inform your AWS KMS Key alias:"
  read KMS_KEY_ALIAS
  export KMS_KEY_ALIAS=$KMS_KEY_ALIAS
done