# Amazon EKS Cluster with Amazon EFS Deployment with Terraform

## Deploy

The following instructions will guide you to deploy Amazon EKS and Amazon EFS resources in your AWS Account.

### Amazon EKS

```sh
$ git clone https://github.com/aws-samples/eks-efs-share-within-fargate.git
$ cd eks-efs-share-within-fargate/deployment/terraform
$ terraform init
$ terraform plan
$ terraform apply -target module.vpc -target module.eks -auto-approve
```
#### Validate

Use your Terraform output to configure your `kubeconfig` file and get access to your cluster.

```sh
$ terraform output configure_kubectl | jq -r | bash
```

Check that all your Pods are in `Running` status, and all the containers are Ready.

```sh
$ kubectl get pods -A
```
```sh
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   coredns-57b997855c-lv9x8              1/1     Running   0          2m4s
kube-system   coredns-57b997855c-vk6pc              1/1     Running   0          2m4s
kube-system   ebs-csi-controller-85fc957b9c-d6j8s   6/6     Running   0          15m
kube-system   ebs-csi-controller-85fc957b9c-szg7z   6/6     Running   0          15m
```

Validate that all your Nodes are Fargate profiles.

```sh
$ kubectl get nodes
```
```sh
NAME                                                STATUS   ROLES    AGE    VERSION
fargate-ip-10-0-10-193.us-west-2.compute.internal   Ready    <none>   102s   v1.27.1-eks-2f008fe
fargate-ip-10-0-26-193.us-west-2.compute.internal   Ready    <none>   105s   v1.27.1-eks-2f008fe
fargate-ip-10-0-34-207.us-west-2.compute.internal   Ready    <none>   15m    v1.27.1-eks-2f008fe
fargate-ip-10-0-34-29.us-west-2.compute.internal    Ready    <none>   15m    v1.27.1-eks-2f008fe
```

### Amazon EFS

## Tear down

```sh
$ cd eks-efs-share-within-fargate/deployment/terraform
$ terraform destroy
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.9 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.20 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_driver_irsa"></a> [ebs\_csi\_driver\_irsa](#module\_ebs\_csi\_driver\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.20 |
| <a name="module_ebs_kms_key"></a> [ebs\_kms\_key](#module\_ebs\_kms\_key) | terraform-aws-modules/kms/aws | ~> 1.5 |
| <a name="module_efs"></a> [efs](#module\_efs) | terraform-aws-modules/efs/aws | ~> 1.1 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.16 |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | aws-ia/eks-blueprints-addons/aws | ~> 1.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_storage_class_v1.efs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_fargate_profiles"></a> [additional\_fargate\_profiles](#input\_additional\_fargate\_profiles) | Map of additional Fargate Profile definitions to create | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configure_kubectl"></a> [configure\_kubectl](#output\_configure\_kubectl) | Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig |
