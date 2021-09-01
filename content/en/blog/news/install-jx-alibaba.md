---
title: "Installing Jenkins X on Alibaba Cloud Container Service"
date: 2019-06-17T07:36:00+02:00
description: >
    Install Jenkins X on Alibaba Cloud Container Service.
categories: [blog]
keywords: [alibaba,container,install,k8s]
slug: "alibaba-container-service-jenkins-x"
aliases: []
author: Carlos Sanchez
---


<figure>
<img src="/images/alibaba-cloud-logo.svg"/>
<figcaption>
<h5>Installing Jenkins X on Alibaba Cloud Container Service</h5>
</figcaption>
</figure>

# Installing Jenkins X in Alibaba Kubernetes Container Service

Jenkins X has just added initial support to install in [Alibaba Container Service](https://www.alibabacloud.com/product/container-service), its Kubernetes offering.

The following instructions allow installation in a managed Kubernetes cluster in any region outside of mainland China, where more configuration is needed avoid using Google services blocked by chinese authorities (Docker images in GCR). There is a [pending issue](https://github.com/jenkins-x/jenkins-x-platform/issues/5551) for that.

## Creating a Kubernetes Cluster

Alibaba requires several things in order to create a Kubernetes cluster, so it is easier to do it through the [web UI](https://cs.console.aliyun.com/) the first time.

The following services need to be activated: Container Service, Resource Orchestration Service (ROS), RAM, and Auto Scaling service, and created the [Container Service roles](https://www.alibabacloud.com/help/doc-detail/86484.htm?spm=a2c63.p38356.b99.38.663a333eMXExon).

If we want to use the command line we can install the [`aliyun`](https://github.com/aliyun/aliyun-cli) cli. I have added all the steps needed below in case you want to use it.

```sh
brew install aliyun-cli
aliyun configure
REGION=ap-southeast-1
```

The clusters need to be created in a VPC, so that needs to be created with VSwitches for each zone to be used.

```sh
aliyun vpc CreateVpc \
    --VpcName jx \
    --Description "Jenkins X" \
    --RegionId ${REGION} \
    --CidrBlock 172.16.0.0/12

{
    "ResourceGroupId": "rg-acfmv2nomuaaaaa",
    "RequestId": "2E795E99-AD73-4EA7-8BF5-F6F391000000",
    "RouteTableId": "vtb-t4nesimu804j33p4aaaaa",
    "VRouterId": "vrt-t4n2w07mdra52kakaaaaa",
    "VpcId": "vpc-t4nszyte14vie746aaaaa"
}

VPC=vpc-t4nszyte14vie746aaaaa

aliyun vpc CreateVSwitch \
    --VSwitchName jx \
    --VpcId ${VPC} \
    --RegionId ${REGION} \
    --ZoneId ${REGION}a \
    --Description "Jenkins X" \
    --CidrBlock 172.16.0.0/24

{
    "RequestId": "89D9AB1F-B4AB-4B4B-8CAA-F68F84417502",
    "VSwitchId": "vsw-t4n7uxycbwgtg14maaaaa"
}

VSWITCH=vsw-t4n7uxycbwgtg14maaaaa
```

Next, a keypair (or password) is needed for the cluster instances.

```sh
aliyun ecs ImportKeyPair \
    --KeyPairName jx \
    --RegionId ${REGION} \
    --PublicKeyBody "$(cat ~/.ssh/id_rsa.pub)"
```

The last step is to create the cluster using the just created VPC, VSwitch and Keypair. It's important to select the option *Expose API Server with EIP* (`public_slb` in the API json) to be able to connect to the API from the internet.

```sh
echo << EOF > cluster.json
{
    "name": "jx-rocks",
    "cluster_type": "ManagedKubernetes",
    "disable_rollback": true,
    "timeout_mins": 60,
    "region_id": "${REGION}",
    "zoneid": "${REGION}a",
    "snat_entry": true,
    "cloud_monitor_flags": false,
    "public_slb": true,
    "worker_instance_type": "ecs.c4.xlarge",
    "num_of_nodes": 3,
    "worker_system_disk_category": "cloud_efficiency",
    "worker_system_disk_size": 120,
    "worker_instance_charge_type": "PostPaid",
    "vpcid": "${VPC}",
    "vswitchid": "${VSWITCH}",
    "container_cidr": "172.20.0.0/16",
    "service_cidr": "172.21.0.0/20",
    "key_pair": "jx"
}
EOF

aliyun cs  POST /clusters \
    --header "Content-Type=application/json" \
    --body "$(cat create.json)"

{
    "cluster_id": "cb643152f97ae4e44980f6199f298f223",
    "request_id": "0C1E16F8-6A9E-4726-AF6E-A8F37CDDC50C",
    "task_id": "T-5cd93cf5b8ff804bb40000e1",
    "instanceId": "cb643152f97ae4e44980f6199f298f223"
}

CLUSTER=cb643152f97ae4e44980f6199f298f223
```

We can now download `kubectl` configuration with

```sh
aliyun cs GET /k8s/${CLUSTER}/user_config | jq -r .config > ~/.kube/config-alibaba
export KUBECONFIG=$KUBECONFIG:~/.kube/config-alibaba
```

Another detail before being able to install applications that use `PersistentVolumeClaims` is to [configure a default storage class](https://www.alibabacloud.com/help/doc-detail/86612.htm#a2c63.p38356.879954.i0.11497ec4J5rKJd). There are several volume options that can be listed with `kubectl get storageclass`.

```sh
NAME                          PROVISIONER     AGE
alicloud-disk-available       alicloud/disk   44h
alicloud-disk-common          alicloud/disk   44h
alicloud-disk-efficiency      alicloud/disk   44h
alicloud-disk-ssd             alicloud/disk   44h
```

Each of them matches the following cloud disks:

* alicloud-disk-common: basic cloud disk (minimum size 5GiB). Only available in some zones (us-west-1a, cn-beijing-b,...)
* alicloud-disk-efficiency: high-efficiency cloud disk, ultra disk (minimum size 20GiB).
* alicloud-disk-ssd: SSD disk (minimum size 20GiB).
* alicloud-disk-available: provides highly available options, first attempts to create a high-efficiency cloud disk. If the corresponding AZ's efficient cloud disk resources are sold out, tries to create an SSD disk. If the SSD is sold out, tries to create a common cloud disk.

To set SSDs as the default:

```sh
kubectl patch storageclass alicloud-disk-ssd \
    -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

**NOTE**: Alibaba cloud disks must be [more than 5GiB (basic) or 20GiB (SSD and Ultra)](https://www.alibabacloud.com/help/doc-detail/25513.htm#h2-url-2)) so we will need to configure any service that is deployed with PVCs to have that size as a minimum or the `PersistentVolume` provision will fail. The Jenkins X deployments [are already configured with this in mind](https://github.com/jenkins-x/cloud-environments/blob/master/env-alibaba/myvalues.yaml).

## Installing Jenkins X

Alibaba Kubernetes clusters won't be able to pull images from the insecure docker registry included in Jenkins X, we need to use Alibaba's Container Registry by going to [https://cr.console.aliyun.com](https://cr.console.aliyun.com) and setting a password.

Then we need to create a Container Registry namespace that allows us to push any image and make them public by default.

From the web UI we can create a Docker login password that we will be using later.

```sh
NAMESPACE=jenkins-x-$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z' | fold -w 6 | head -n 1)
cat << EOF > namespace.json
{
    "Namespace": {
        "Namespace": "${NAMESPACE}"
    }
}
EOF
aliyun cr PUT /namespace \
    --header "Content-Type=application/json" \
    --body "$(cat namespace.json)"

cat << EOF > namespace.json
{
    "namespace": {
        "namespace": "${NAMESPACE}",
        "defaultVisibility": "PUBLIC",
        "autoCreate": true
    }
}
EOF

aliyun cr POST /namespace/${NAMESPACE} \
    --header "Content-Type=application/json" \
    --body "$(cat namespace.json)"

```

Now we can install Jenkins X as usual, passing the `--provider alibaba` flag.

```sh
jx install \
    --provider alibaba \
    --default-admin-password=admin \
    --default-environment-prefix=jx-rocks \
    --tekton \
    --docker-registry=registry.${REGION}.aliyuncs.com \
    --docker-registry-org=${NAMESPACE} \
    -b
```

After installation we need to add the Container Registry credentials to the cluster, the Docker password we have previously created.

```bash
AUTH=$(echo -n "${DOCKER_USERNAME}:${DOCKER_PASSWORD}" | base64)
DATA=$(cat << EOF | base64
{
    "auths": {
        "registry.${REGION}.aliyuncs.com": {
            "auth": "${AUTH}"
        }
    }
}
EOF
)
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: jenkins-docker-cfg
  namespace: jx
data:
  config.json: ${DATA}
EOF
```

## Installing Addons

Addons can be installed normally with the caveat mentioned above about PVC minimum size. Which means that we may need to pass some Helm values to the `create addon` command, depending on the chart we are installing.

For instance to install Prometheus with 20Gi disks:

```sh
jx create addon prometheus \
    -s alertmanager.persistentVolume.size=20Gi,pushgateway.persistentVolume.size=20Gi,server.persistentVolume.size=20Gi
```

## Tekton

Tekton builds need to be configured to use PVCs bigger than 20Gi due to the same reasons. The default is to use 5GiB PVCs.

```sh
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-artifact-pvc
  namespace: jx
data:
  size: 20Gi
EOF
```
