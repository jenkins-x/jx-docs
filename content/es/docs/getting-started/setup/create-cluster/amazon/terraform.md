---
title: Crear clúster EKS con Terraform
linktitle: Terraform
description: ¿Cómo configurar un clúster EKS, requerimientos y Jenkins X con Terraform en AWS?
categories: [getting started]
keywords: [install,Kubernetes,aws,terraform]
weight: 65
---

Esta es una guía corta para configurar EKS en AWS utilizando Terraform donde se incluyen los requisitos necesarios para instalar Jenkins X y Vault. Se asume que está configurado el acceso a AWS y que está familiarizado con AWS, kubectl y Terraform.

El fragmento de código de Terraform agrupa los recursos necesarios para EKS en AWS. El resultado (output) de la ejecución será utilizado como parámetros en el comando `jx install`.

```tf
variable "region" {
}

variable "subnets" {
    type = "list"
}

variable "vpc_id" {
}

variable "key_name" {
    description = "SSH key name for worker nodes"
}

variable "bucket_domain" {
    description = "Suffix for S3 bucket used for vault unseal operation"
}

provider "aws" {
    region  = "${var.region}"
}

module "eks" {
    source       = "terraform-aws-modules/eks/aws"
    cluster_name = "${var.region}"
    subnets      = "${var.subnets}"
    vpc_id       = "${var.vpc_id}"
    worker_groups = [
        {
            autoscaling_enabled   = true
            asg_min_size          = 3
            asg_desired_capacity  = 3
            instance_type         = "t3.large"
            asg_max_size          = 20
            key_name              = "${var.key_name}"
        }
    ]
    version = "5.0.0"
}

# Needed for cluster-autoscaler
resource "aws_iam_role_policy_attachment" "workers_AmazonEC2ContainerRegistryPowerUser" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = "${module.eks.worker_iam_role_name}"
}

# Create S3 bucket for KMS
resource "aws_s3_bucket" "vault-unseal" {
    bucket = "vault-unseal.${var.region}.${var.bucket_domain}"
    acl    = "private"

    versioning {
        enabled = false
    }
}

# Create KMS key
resource "aws_kms_key" "bank_vault" {
    description = "KMS Key for bank vault unseal"
}

# Create DynamoDB table
resource "aws_dynamodb_table" "vault-data" {
    name           = "vault-data"
    read_capacity  = 2
    write_capacity = 2
    hash_key       = "Path"
    range_key      = "Key"
    attribute {
        name = "Path"
        type = "S"
    }

    attribute {
        name = "Key"
        type = "S"
    }
}

# Create service account for vault. Should the policy
resource "aws_iam_user" "vault" {
  name = "vault_${var.region}"
}

data "aws_iam_policy_document" "vault" {
    statement {
        sid = "DynamoDB"
        effect = "Allow"
        actions = [
            "dynamodb:DescribeLimits",
            "dynamodb:DescribeTimeToLive",
            "dynamodb:ListTagsOfResource",
            "dynamodb:DescribeReservedCapacityOfferings",
            "dynamodb:DescribeReservedCapacity",
            "dynamodb:ListTables",
            "dynamodb:BatchGetItem",
            "dynamodb:BatchWriteItem",
            "dynamodb:CreateTable",
            "dynamodb:DeleteItem",
            "dynamodb:GetItem",
            "dynamodb:GetRecords",
            "dynamodb:PutItem",
            "dynamodb:Query",
            "dynamodb:UpdateItem",
            "dynamodb:Scan",
            "dynamodb:DescribeTable"
        ]
        resources = ["${aws_dynamodb_table.vault-data.arn}"]
    }
    statement {
        sid = "S3"
        effect = "Allow"
        actions = [
                "s3:PutObject",
                "s3:GetObject"
        ]
        resources = ["${aws_s3_bucket.vault-unseal.arn}/*"]
    }
    statement {
        sid = "S3List"
        effect = "Allow"
        actions = [
            "s3:ListBucket"
        ]
        resources = ["${aws_s3_bucket.vault-unseal.arn}"]
    }
    statement {
        sid = "KMS"
        effect = "Allow"
        actions = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:DescribeKey"
        ]
        resources = ["${aws_kms_key.bank_vault.arn}"]
    }
}

resource "aws_iam_user_policy" "vault" {
    name = "vault_${var.region}"
    user = "${aws_iam_user.vault.name}"

    policy = "${data.aws_iam_policy_document.vault.json}"
}

resource "aws_iam_access_key" "vault" {
    user = "${aws_iam_user.vault.name}"
}

# Output KMS key id, S3 bucket name and secret name in the form of jx install options
output "jx_params" {
    value = "--provider=eks --gitops --no-tiller --vault --aws-dynamodb-region=${var.region} --aws-dynamodb-table=${aws_dynamodb_table.vault-data.name} --aws-kms-region=${var.region} --aws-kms-key-id=${aws_kms_key.bank_vault.key_id} --aws-s3-region=${var.region}  --aws-s3-bucket=${aws_s3_bucket.vault-unseal.id} --aws-access-key-id=${aws_iam_access_key.vault.id} --aws-secret-access-key=${aws_iam_access_key.vault.secret}"
}
```

Salvar como `eks.tf`

El módulo terraform-aws-modules/eks/aws va a guardar el fichero kubeconfig como `config`. Este podrá ser copiado o mezclado con el suyo `~/.kube/config`. Con esta configuración `jx install` puede ser iniciado utilizando los parámetros de salida de Terraform.
