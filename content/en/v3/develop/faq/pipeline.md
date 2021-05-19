---
title: Pipelines
linktitle: Pipelines
type: docs
description: Questions about using Tekton pipelines with Jenkins X
weight: 200
---

## How do I diagnose a step in a pipeline?

If you are wondering what image, command, environment variables are being used in a step in the pipeline the simplest thing is to [open the octant console](/v3/develop/ui/octant/) via:

```bash 
jx ui
```

Then if you navigate to the pipeline you are interested in and select the envelope icon next to a step name that will take you to the Step details page. e.g. if you click on the icon pointed to by the big red arrow:

<figure>
<img src="/images/developing/octant-step-click.png" />
<figcaption>
<h5>Click on the step icon to see details of a step which then takes you to the step details page</h5>
</figcaption>
</figure>


<figure>
<img src="/images/developing/octant-step.png" />
<figcaption>
<h5>Step details page lets you see the command, image, environment variables and volumes</h5>
</figcaption>
</figure>

If that doesn't help another option is to [edit the pipeline step](/v3/develop/pipelines/#editing-pipelines) via the `.lighthouse/jenkins-x/release.yaml` or  `.lighthouse/jenkins-x/pullrequest.yaml` file to add the command: `sleep infinity` in the `script:` value before the command that is not working.

You can then `kubectl exec` into the pod at that step and look around and try running commands inside the pod/container.

e.g. using the pod name from the above page and the container name you can do something like:

```bash 
kubectl exec -it -c name-of-step-container name-of-pod sh
```
    
## How do I access a Secret from my pipeline?

Once you have a kubernetes Secret (see [how to create them](/v3/admin/setup/secrets/#create-a-new-secret)) you can access then in a pipeline either:

* as an [environment variable in a step](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables)
* via [a volume mount](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-files-from-a-pod)


## How do I configure pipelines to use GPUs?
 
 You can install the [nvidia k8s device plugin](https://github.com/NVIDIA/k8s-device-plugin) as a daemonset to expose which nodes have GPUs and their status.
 
 You can then view the nodes via:
 
 ```bash 
 kubectl get nodes "-o=custom-columns=NAME:.metadata.name,GPU:.status.allocatable.nvidia\.com/gpu"  
 ```
         
 You can then use the `resources` on your tekton steps as follows:
 
 ```yaml 
 - image: gcr.io/kaniko-project/executor:v1.3.0-debug
   name: build-my-image
   resources:
     limits:
       # This job requires an instance with 1 GPU, 4 CPUs and 16GB memory - g4dn.2xlarge
       nvidia.com/gpu: 1
   script: |
     #!/busybox/sh
 ```
             

## How can I use a monorepo?

If you have an existing monorepo you want to import into Jenkins X you can; just be aware that you'll have to [create and maintain your own pipelines](/v3/develop/pipelines/editing/) for your monorepo. 

We currently have no special tekton steps to analyse git changes and conditionally run different sets of tekton steps based on what has changed.

So you may need to write your own steps to handle this nicely based on whatever kind of monorepo you have. Or you may want to look at using a tool like [Bazel](https://bazel.build/) or some similar tool to implement your monorepo build and just invoke that from the Tekton pipeline. 

You could start with the automated CI/CD pipelines that most match your technology choices and edit them to suit.

There are a few tools around that could help:
              
* [bazel](https://bazel.build/)
* [lerna](https://github.com/lerna/lerna)
* [meta](https://github.com/mateodelnorte/meta) see the [blog post introducing meta](https://patrickleet.medium.com/mono-repo-or-multi-repo-why-choose-one-when-you-can-have-both-e9c77bd0c668)
                                                                                       
## How do I configure a different branch for releases?

If you look at the `postsubmits` section  of the [trigger config](/v3/develop/reference/pipelines/#lighthouse) in your `.lighthouse/jenkins-x/triggers.yaml` file you will see the post submits (which is prow/lighthouse terminology for release pipelines).

By default the `branches:` is setup with regular expressions for either `main` or `master` branches:


```yaml 
  ...
  postsubmits:
  - name: release
    context: "release"
    source: "release.yaml"
    branches:
    - ^main$
    - ^master$
```

Modify the `branches` to use a different regular expression to denote the branch(s) you wish to use to trigger a new release.
