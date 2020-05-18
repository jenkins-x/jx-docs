---
title: Amazon 
linktitle: Amazon
description: Using Boot on Amazon (AWS)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-27
weight: 20
---

The information in this document assumes you have already created a Kubernetes cluster in AWS and you are now ready to `boot` your cluster with Jenkins X.

## Basic Configuration

Please set your provider to `eks` via this in your `jx-requirements.yml` to indicate you are using EKS:

```yaml
clusterConfig:
    provider: eks
```

If you wish to setup your EKS cluster by hand and not use [eksctl](https://eksctl.io/) then please specify `terraform: true` to indicate that you are setting up all of the AWS related cloud resources yourself and that you do not want `jx boot` attempting to set anything up.

We recommend using [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) as this works out of the box with kaniko for creating container images without needing a docker daemon and works well with ECR.

## Authentication Mechanisms
There are two standard authentication mechanisms that are recommended depending on use case: Enhanced permissions for the nodepool role, and IRSA.

### Enhanced permissions for the nodepool role
The default authentication and permissions mechanism used by EKS in order to give nodepool access to certain AWS services.

When an EKS cluster is created, the control plane for the cluster is managed directly by AWS but its nodepool and all the worker nodes are created as EC2 instances. These EC2 instances are assigned an IAM Role with specific permissions to allow these nodes to authenticate against AWS.

More policies can be added to these roles in order to provide permissions to every pod running in the cluster.

The issue with this mechanism is that by enhancing the permissions on the nodepool EC2 instances, every pod in the cluster will have every permission provided by the Role, which could raise security concerns.

Third party solutions like [kiam](https://github.com/uswitch/kiam) or [kube2iam](https://github.com/jtblin/kube2iam) can be used to provide permissions on a pod by pod basis but for Jenkins X it is recommended to use the official [IAMRoles for Service Accounts](https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts).

Note that this is the mechanism that *must* be used if the cluster was not created with [eksctl](https://github.com/weaveworks/eksctl), because only clusters created with `eksctl` are able to assign an Open ID Connect Provider that will make IAM Roles for Service Accounts work.

### IAM Roles for Service Accounts (IRSA)

In order to avoid the security concerns that enhanced permissions on the nodepool creates, it is recommended to use IRSA mechanisms to provide fine grained permissions at the Service Account level, meaning that a Role will be created and attached for every single Service Account that is used in the cluster.

When executing `jx boot` (and ensuring that the `--terraform` flag is set to `false`), a series of IAM Policies are created through CloudFormation stacks:

[jenkinsx-policies.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/kubeProviders/eks/templates/jenkinsx-policies.yml)

These policies are then exported as CloudFormation outputs following a defined format. For example:

```yaml
Export:
  Name: !Join [ "-", [ TektonBotPolicy, Ref: PoliciesSuffixParameter] ]
```

This policy performs a Join operation. A name is provided, in this case TektonBotPolicy; then a random suffix is appended to make the name unique.

The provided name will be used in the irsa.tmpl.yaml file.

The names of the outputs from jenkinsx-policies.yml are used in this file by processing it through Golang’s templating functionality, exporting the outputs of the CloudFormation stack under the .IAM.` prefix.

This means that the outputs from jenkins-x-policies.yml can be obtained and queried in this file, which will then be processed and run against the cluster.

For example, take this output from the CloudFormation stack:

```yaml
CFNTektonBotPolicy:
  Value:
  Ref: CFNJenkinsXPolicies
  Description: The ARN of the created policy
  Export:
    Name: !Join [ "-", [ TektonBotPolicy, Ref: PoliciesSuffixParameter] ]
```

And how we use its export name in the next file:

```yaml
{{- if .IAM.TektonBotPolicy }}
  - metadata:
      name: tekton-bot
      namespace: jx
      labels: {aws-usage: "jenkins-x"}
    attachPolicyARNs:
    - {{.IAM.TektonBotPolicy | quote}}
```

In this example we are taking the policy ARN created from the CloudFormation stack under a specific export name and using it in the IRSA template file. This will then create an IAM Role, attach the policy to it, then it will create a new ServiceAccount called tekton-bot with the necessary annotations to let it assume the created role.

If the ServiceAccount already exists, it will perform an upsert and just add the annotation.

A pod that uses that ServiceAccount will automatically assume that role in IAM and be granted access to the cloud services defined in the policy that was attached to its role.

If you need to add more permissions for other Service Accounts, just add them to [jenkinsx-policies.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/kubeProviders/eks/templates/jenkinsx-policies.yml) with an export name that can be referenced in [irsa.tmpl.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/kubeProviders/eks/templates/irsa.tmpl.yaml) and Jenkins X will create everything for you.

You can also simply add already created policies to your ServiceAccounts like this:

```yaml
  - metadata:
      name: jenkins-x-controllerbuild
      namespace: jx
      labels: {aws-usage: "jenkins-x"}
    attachPolicyARNs:
    - "arn:aws:iam::aws:policy/AmazonS3FullAccess"
```

Note: For now, this can only be done in the initial installation of Jenkins X and any adjustments need to be done manually by adding more permissions to the created IAM Policies.

## IAM Policies for Cluster Creation and Jenkins X Boot

Before getting into IRSA, we will define the minimum permissions needed to create an EKS cluster with `jx create cluster eks` and Jenkins X.

### IAM Policy for cluster creation

In order to create an EKS cluster, we make use of [eksctl](https://github.com/weaveworks/eksctl), which is the official tool to interact with EKS clusters.

There is no official policy documented by eksctl to get a cluster running, but there’s a very useful GitHub issue where users have been curating a comprehensive policy that should work for all cases: [https://gist.github.com/dgozalo/bc4b932d51f22ca5d8dad07d9a1fe0f2](https://gist.github.com/dgozalo/bc4b932d51f22ca5d8dad07d9a1fe0f2)

```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:GetRole",
                "iam:GetInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy",
                "iam:ListInstanceProfiles",
                "iam:AddRoleToInstanceProfile",
                "iam:ListInstanceProfilesForRole",
                "iam:PassRole",
                "iam:DetachRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:GetRolePolicy",
                "iam:DeleteServiceLinkedRole",
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": [
                "arn:aws:iam::<account_id>:instance-profile/eksctl-*",
                "arn:aws:iam::<account_id>:role/eksctl-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "cloudformation:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:CreateLaunchConfiguration",
                "autoscaling:DeleteLaunchConfiguration",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:DeleteAutoScalingGroup",
                "autoscaling:CreateAutoScalingGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ec2:DeleteInternetGateway",
            "Resource": "arn:aws:ec2:*:*:internet-gateway/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:DeleteSubnet",
                "ec2:DeleteTags",
                "ec2:CreateNatGateway",
                "ec2:CreateVpc",
                "ec2:AttachInternetGateway",
                "ec2:DescribeVpcAttribute",
                "ec2:DeleteRouteTable",
                "ec2:AssociateRouteTable",
                "ec2:DescribeInternetGateways",
                "ec2:CreateRoute",
                "ec2:CreateInternetGateway",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:CreateSecurityGroup",
                "ec2:ModifyVpcAttribute",
                "ec2:DeleteInternetGateway",
                "ec2:DescribeRouteTables",
                "ec2:ReleaseAddress",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:DescribeTags",
                "ec2:CreateTags",
                "ec2:DeleteRoute",
                "ec2:CreateRouteTable",
                "ec2:DetachInternetGateway",
                "ec2:DescribeNatGateways",
                "ec2:DisassociateRouteTable",
                "ec2:AllocateAddress",
                "ec2:DescribeSecurityGroups",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteNatGateway",
                "ec2:DeleteVpc",
                "ec2:CreateSubnet",
                "ec2:DescribeSubnets",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeImages",
                "ec2:describeAddresses",
                "ec2:DescribeVpcs",
                "ec2:CreateLaunchTemplate",
                "ec2:DescribeLaunchTemplates",
                "ec2:RunInstances",
                "ec2:DeleteLaunchTemplate",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:DescribeImageAttribute",
                "ec2:DescribeKeyPairs",
                "ec2:ImportKeyPair"
            ],
            "Resource": "*"
        }
    ]
}
```

### IAM Policy for Jenkins X Boot creation

A different policy is required for Jenkins X to be successful with the jx boot command.  Depending on the configuration present in jx-requirements.yml, we will attempt to interact with different cloud services like S3, DynamoDB or KMS.  This policy will allow the executing user the minimum permissions to be successful.

[https://gist.github.com/dgozalo/df514542b63ef05282cac793b433d74b](https://gist.github.com/dgozalo/df514542b63ef05282cac793b433d74b)

```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "s3:GetObject",
                "cloudformation:ListStacks",
                "cloudformation:DescribeStackEvents",
                "dynamodb:DescribeTable",
                "s3:CreateBucket",
                "kms:CreateKey",
                "s3:ListBucket",
                "s3:PutBucketVersioning",
                "cloudformation:DescribeStacks"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:GetPolicy",
                "ecr:CreateRepository",
                "iam:AttachUserPolicy",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "iam:CreateAccessKey",
                "iam:CreateOpenIDConnectProvider",
                "iam:CreatePolicy",
                "iam:DetachRolePolicy",
                "cloudformation:CreateStack",
                "cloudformation:DeleteStack",
                "ecr:DescribeRepositories",
                "iam:GetOpenIDConnectProvider"
            ],
            "Resource": [
                "arn:aws:iam::*:policy/CFN*",
                "arn:aws:iam::*:policy/*jenkins-x-vault*",
                "arn:aws:iam::*:oidc-provider/*",
                "arn:aws:iam::*:role/*addon-iamserviceaccoun*",
                "arn:aws:iam::*:user/*",
                "arn:aws:ecr:*:*:repository/*",
                "arn:aws:cloudformation:*:*:stack/JenkinsXPolicies*/*",
                "arn:aws:cloudformation:*:*:stack/*addon-iamserviceaccount*/*",
                "arn:aws:cloudformation:*:*:stack/*jenkins-x-vault*/*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:DetachRolePolicy",
                "iam:GetPolicy",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:GetOpenIDConnectProvider",
                "iam:CreateOpenIDConnectProvider"
            ],
            "Resource": [
                "arn:aws:iam::*:oidc-provider/*",
                "arn:aws:iam::*:role/*addon-iamserviceaccoun*",
                "arn:aws:iam::*:policy/CFN*"
            ]
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": [
                "arn:aws:eks:*:*:fargateprofile/*/*/*",
                "arn:aws:eks:*:*:cluster/*",
                "arn:aws:eks:*:*:nodegroup/*/*/*"
            ]
        }
    ]
}
```

The reason for these policies is further described for each cloud resource below.

#### IAM

In order to make IAM Roles for Service Accounts work, Jenkins X will create IAM Policies and Roles and then attach these policies to these roles.  These Roles are then annotated into selected Service Accounts so pods using them can assume the role.  In order to make IRSA work, Jenkins X needs to create an Open ID Connect Provider with IAM in order to authenticate the annotated pods.  Also, in order to make Vault work, we (for now) need to attach a policy, created just for Vault, into a provided IAM User.

#### CloudFormation

Jenkins X creates a series of CloudFormation stacks to prepare the platform for cluster installation. All IAM Policies created for IRSA are created as CloudFormation stacks.  Every cloud resource needed by Vault is also created by CloudFormation, but only if they are not provided in jx-requirements.yml already.

#### S3

Jenkins X uses S3 for Long Term Storage, that is, for logs archival and stashing of artifacts created in Pipelines.  Jenkins X Boot will attempt to check for existing S3 buckets and create them if they don’t exist.  It is also used by Vault, so there needs to be enough permissions for the executing user to interact with the service. Permissions to interact with the bucket however, is handled by IRSA and are only granted to the Vault pod.

#### DynamoDB

This service is used by Vault, so the executing user needs to have permissions to at least create the table. Permissions to interact with the table however, is handled by IRSA and are only granted to the Vault pod.

#### KMS

Vault needs to create a KMS key in order to encrypt its contents. Again, the executing user just needs permissions to create the Key. Permissions to interact with KMS however, is handled by IRSA and are only granted to the Vault pod.

#### ECR

Jenkins X will check if there is an ECR registry already created for a given application, and create it otherwise.

#### EKS

Jenkins X will need full permissions on EKS in order to operate without problems.  For further security, this policy can be modified to restrict its access to only certain resources and accounts.  For example, if you know the name of your cluster, you can modify the resources affected by the eks permission to limit its effect.

#### Vault

A special case - refer to [Configuring Vault for EKS](#configuring-vault-for-eks)

## Configuring Vault for EKS

When booting JX on an EKS cluster with Vault enabled, fields under vault.aws in the `jx-requirements.yml` file are required to enable Vault support.

Vault does not currently support Identity Access Management (IAM) Roles for Service Accounts, so you will be prompted to provide a preconfigured IAM User.

The `jx-requirements.yml` file contains the following settings for EKS Vault configuration:

```yaml
vault:
    aws:
      autoCreate: true
      iamUserName: <username>
```

For Vault support on EKS clusters, you must provide an **existing** IAM username in the `iamUserName` setting to use its Access Keys to authenticate the Vault pod against AWS.

The IAM user does not need any permissions attached to it. During the installation process, Jenkins X creates a new IAM Policy and attaches it to this user. These will essentially be the permissions that the Vault pod will use.

**Important**: A new set of Access Keys are created during Vault creation. There is a limit of 2 key pairs per IAM user, so ensure that there is at least one key slot free on the IAM user that you are providing. Otherwise, the Vault configuration will fail. If you do not want Jenkins X to create these keys, you can provide a key pair that you already created through the environment variables: **VAULT_AWS_ACCESS_KEY_ID** and **VAULT_AWS_SECRET_ACCESS_KEY**.

In the **install-vault** step, the jx boot process runs a CloudFormation stack in order to create every resource needed by Vault to work.

You can find the CloudFormation stack template [here](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/kubeProviders/eks/templates/vault_cf_tmpl.yml).

### Providing an Existing Vault Instance

If you want to provide an existing Vault instance instead of letting Jenkins X create one, you need to set Vault.aws.autoCreate to false.

You must provide the names of the existing resources in the `jx-requirements.yml` file:

```yaml
vault:
  aws:
    autoCreate: false
    iamUserName: acmeuser
    dynamoDBTable: ""
    dynamoDBRegion: ""
    kmsKeyId: ""
    kmsRegion: ""
    s3Bucket: ""
    s3Region: ""
    s3Prefix: ""
```

Note: A pair of Access Keys will be created even if you set **autoCreate** to **false**. To prevent this, you can set an existing pair through environment variables: **VAULT_AWS_ACCESS_KEY_ID** and **VAULT_AWS_SECRET_ACCESS_KEY**.

## Configuring DNS and TLS on EKS

If you require custom Domain Name Service (DNS) and/or Transport Layer Security (TLS) support, follow the steps in this section.

### Configuring AWS Route 53

In order to configure your cluster to enable external DNS and TLS for its services and your applications, you must configure AWS Route53 appropriately.

An administrator should have a domain name registered with a name registrar, for example www.acmecorp.example, before configuring Route 53’s Hosted Zone settings. For more information, refer to [Getting Started with Amazon Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started.html) from the Amazon documentation.

1. Within the AWS Dashboard, navigate to the Region Selector dropdown and choose the region that you are going to work with.
2. Configure the following settings as described in [Creating a Public Hosted Zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) from the Amazon documentation:
    - Input a DNS suffix in DNS name, for example acmecorp.example
    - (Optional) input a Comment for your Hosted Zone
    - Choose Public as your Zone Type
    - Click Create

Once created, the Hosted Zone Details page loads. NS (Name server) and SOA (Start of Authority) records are automatically created for your domain (for example acmecorp.example)

### Configuring External DNS

Once you have configured AWS Route 53, you can browse the Hosted Zones page from the navigation pane for the selected region to set up your external domain.

NOTE: External DNS will automatically update DNS records if you reuse a domain name, so if you delete an old cluster and create a new one it will preserve the same domain configuration for the new cluster.

1. Choose a unique DNS name; you can use nested domains (for example, cluster1.acmecorp.example). Create a new Hosted Zone for this subdomain.
2. In the newly created Hosted Zone details page, copy all the nameservers from the NS recordset and annotate the name of your subdomain.
3. Go back to the Hosted Zone created for your apex domain, in this case acmecorp.example, and click on <create_record_set> to create a new record set.
    - Input the name of the subdomain in the Name field. In this case cluster1.acmecorp.example
    - Select NS as the Type
    - Input the nameservers that you copied from the subdomain Hosted Zone in the Value field
4. Click Create
5. Configure Jenkins X for the new domain names:
    - Open the `jx-requirements.yml` file in a text editor (such as TextEdit for macOS or gedit for Linux) and edit the ingress section at the root level.

        ```yaml
        ingress:
          domain: cluster1.acmecorp.example
          ignoreLoadBalancer: true
          externalDNS: true
          namespaceSubDomain: -jx.
          tls:
            email: certifiable@acmecorp.example
            enabled: true
            production: true
        ```

When you're ready to run `jx boot` this configuration will be applied to your cluster.
