---
title: Azure
linktitle: Azure 
type: docs
description: Setting up TLS and DNS on Azure
weight: 90
---

## DNS zone creation

Create a common resource group dedicated to all your DNS zones:
```
$ az group create --name rg-dns --location westeurope
{
  "id": "/subscriptions/49721339-fe83-4562-afec-783c3f00c06f/resourceGroups/rg-dns",
  "location": "westeurope",
  "managedBy": null,
  "name": "rg-dns",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
```

Create an Azure DNS zone with the name of your domain:
```
$ az network dns zone create -g rg-dns -n foo.io
{
  "etag": "00000002-0000-0000-e2d9-80ef0df0d601",
  "id": "/subscriptions/49721339-fe83-4562-afec-783c3f00c06f/resourceGroups/rg-dns/providers/Microsoft.Network/dnszones/foo.io",
  "location": "global",
  "maxNumberOfRecordSets": 10000,
  "name": "foo.io",
  "nameServers": [
    "ns1-05.azure-dns.com.",
    "ns2-05.azure-dns.net.",
    "ns3-05.azure-dns.org.",
    "ns4-05.azure-dns.info."
  ],
  "numberOfRecordSets": 2,
  "registrationVirtualNetworks": null,
  "resolutionVirtualNetworks": null,
  "resourceGroup": "rg-dns",
  "tags": {},
  "type": "Microsoft.Network/dnszones",
  "zoneType": "Public"
}
```

## Domain DNS servers configuration

In your registrar admin panel, find the DNS servers section of the domain you want to use and replace the default ones by those from the first step:

![dns servers section](/images/v3/registrar_dns_servers.png)

![dns servers update](/images/v3/registrar_dns_servers_update.png)

Test the DNS delegation by adding a A record in the Azure DNS zone you've previously created:
```
$ az network dns record-set a add-record -g rg-dns -z foo.io -n potato -a 1.2.3.4
{
  "arecords": [
    {
      "ipv4Address": "1.2.3.4"
    }
  ],
  "etag": "a80b3397-dd76-4ad8-a789-0fd1dbd02d99",
  "fqdn": "potato.foo.io.",
  "id": "/subscriptions/49721339-fe83-4562-afec-783c3f00c06f/resourceGroups/rg-dns/providers/Microsoft.Network/dnszones/foo.io/A/potato",
  "metadata": null,
  "name": "potato",
  "provisioningState": "Succeeded",
  "resourceGroup": "rg-dns",
  "targetResource": {
    "id": null
  },
  "ttl": 3600,
  "type": "Microsoft.Network/dnszones/A"
}
```

Then check it:
```
$ nslookup potato.foo.io
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	potato.foo.io
Address: 1.2.3.4
```

You can finally remove this test A record:
`$ az network dns record-set a remove-record --resource-group rg-dns --zone-name foo.io --record-set-name "potato" --ipv4-address 1.2.3.4`

## Cluster creation

Generate a new infrastructure repository and a new a new cluster repository, then put this at the end of your **infrastructure** repository `values.auto.tfvars`:
```
subdomain = "jx"
apex_domain = "foo.io"
apex_domain_integration_enabled = "true"
apex_resource_group_name = "rg-dns"

```

Commit these changes:
```
$ git add values.auto.tfvars
$ git commit -m "chore: DNS configuration"
```

And create the cluster:
```
$ terraform init
$ terraform plan
$ terraform apply
```

## Cluster configuration

Once the cluster creation and the boot job is completed, configure TLS in `jx-requirements.yaml` in your **cluster** repository (don't forget to retrieve the boot changes before with `git pull`):
```
  ingress:
    domain: jx.foo.io
    externalDNS: true
    kind: ingress
    namespaceSubDomain: -jx.
    tls:
      email: "contact@foo.io"
      enabled: true
      production: false
```

Commit and push these changes:
```
$ git add values.auto.tfvars
$ git commit -m "chore: domain and TLS configuration"
$ git push
```

After the boot job, verify with:
`jx verify tls hook-jx.jx.foo.io  --production=false --timeout 20m`

When you're happy with your changes, you can set `production` to `true` to get a real certificate, then after the boot job, verify it with:
`jx verify tls hook-jx.jx.foo.io  --production=true --timeout 20m`

