---
title: Multi-Cluster
linktitle: Multi-Cluster
description: How to use multiple clusters with helm 3 and helmfile
weight: 100
---


We recommend using separate clusters for your `Preprod` and `Production` environments. This lets you completely isolate your environments which improves security.


## Setting up multi cluster

1. Follow new [getting started approach](/docs/v3/getting-started/) to setup a new Development Cluster (or skip this step if already in place). 

2. Follow the mentioned approach at the previous point in order to setup new and additional clusters for the desired remote environments:
    * For remote environments (e.g. `Preprod` and `Production`) you typically won't need lots of the development tools such as:
      * Lighthouse
      * Tekton
      * Webhooks
    * And install only services to run and expose your applications, e.g.:
      * Nginx-ingress
      * Cert-manager
3. Then when you have a git repository URL for your `Preprod` or `Production` cluster, [import the git repository](/docs/v3/develop/create-project/#import-an-existing-project) like you would any other git repository into your Development cluster using the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command (command should be run in the `jx` namespace):
    
    ```bash 
    jx project import --url https://github.com/myowner/my-prod-repo.git
    ```
    
    This will create a Pull Request on your development cluster git repository to link to the `Preprod` or `Production` git repository on promotions of apps. `N.B`: Jenkins-X will push additional configuration files to the created Pull Request, so it is recommended to wait until the Pull Request is auto-merged and avoid manual intervention.



Once everything is correctly setup, it will be possible to deploy applications to the newly created remote environment/s. 


     




