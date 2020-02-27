## Getting started

Currently you will need a custom build of `jx` from this [Pull Request](https://github.com/jenkins-x/jx/pull/6664).

Also you will need to install [helmfile](https://github.com/roboll/helmfile) 

### Installing helmfile

On a mac you can install `helmfile` via:

``` 
brew install helmfile
```

Note this also installs a `helm` 3 binary on your `$PATH`


You also need to install these helm plugins:

```bash
helm plugin install https://github.com/aslafy-z/helm-git.git
helm plugin install https://github.com/databus23/helm-diff
```

### Setting up your secrets

write some installation secrets to a file using the template below, this is a temporary solution

```      
mkdir -p /tmp/.jx/localSecrets/currentCluster
vi /tmp/.jx/localSecrets/currentCluster/secrets.yaml
secrets:     
  adminUser:
    username: "admin"
    password: "" 
  hmacToken: "" 
  pipelineUser:
    username: ""  
    email: "" 
    token: "" 
```

Then define `JX_SECRETS_YAML` to point to this YAML file (wherever you put it):

```     
export JX_SECRETS_YAML=/tmp/.jx/localSecrets/currentCluster/secrets.yaml
```
    
### Using boot

Now run:

``` 
jx boot --helmfile
```

and follow the prompts.


### Uninstall

To uninstall your Jenkins X installation from the git clone of the boot configuration run:

```
helmfile destroy    
```        