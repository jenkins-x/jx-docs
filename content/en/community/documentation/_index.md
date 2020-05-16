---
title:
linktitle: Writing Documentation
description: How to help improve the Jenkins X documentation
weight: 2
type: docs
no_list: true
menu:
  community:
    weight: 2
aliases:
    - docs/contributing/documentation/
---

We welcome your contributions to Jenkins X documentation whether you are a developer, an end user, or someone who can't stand seeing typos!

{{% alert %}}
If you're looking for the easiest way to correct existing content (typos etc.) have a look at the [Suggest Changes](/community/documentation/changes/) guide.
{{% /alert %}}

## Assumptions

This contribution guide takes a step-by-step approach in hopes of helping newcomers.
Therefore, we only assume the following:

* You are a fan of Jenkins X and enthusiastic about contributing to the project

Regardless your experience, there should be enough information in this documentation to get you up and running for contributing.

{{< alert >}}
If you're struggling at any point in this contribution guide, reach out to the Jenkins X community in [Jenkins X's Discussion forum](/community/).
{{< /alert >}}

## Getting Started

The first thing you'll need to do is get your local environment setup, so that you can add/change content and make sure it looks right before raising a pull request.

The source code for the documentation can be found in the [jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) GitHub repository.
You want to get a clone of this repository.

```bash
git clone  --recurse-submodules --depth 1 https://github.com/jenkins-x/jx-docs.git
```

If you are a newcomer to Git and not sure what to do with the above command, have a look at the [Step by Step setup](/community/documentation/step-by-step/) guide which guides you through the process of installing Git, forking a repository and finally cloning it locally onto your local machine.

## Local preview environment

The documentation (and the rest of the website) is generated using the static site generator [Hugo](https://gohugo.io).

Although Jenkins X offers preview environments, and they're used as part of the process of contributing documentation, it's usually faster to run the site locally and check that everything looks good for you, before you push your changes.

There are two different ways that you can run the site locally: using a locally installed version of Hugo or using a pre-baked Docker image that includes what's normally needed. Which approach you choose is fully up to you.

### Docker Compose method

If you haven't worked with Hugo before, or don't want to install it locally, this is your best option.

The first thing you'll need to make use of this approach is Docker installed on your local environment. How to install a Docker engine depends on your platform etc., so best to head over to [Docker](https://docs.docker.com/install/) to find the right one.

To make it as simple as possible, we've created and published Docker images installed with what's normally needed to run and work with Hugo, and have setup a `docker-compose.yml` file that will help you start up a preview server with a few helpful options.

In order to use this setup, first make sure you're in the folder with your local cloned copy of the `jx-docs` repo, then run the following command to download and start the Hugo server:

```sh
docker-compose up -d server
```

This will make the site available on [localhost:1313](http://localhost:1313/) and it will auto-update when you save changes to any of the files in the repo.

To be able to see what's going on, and know when the site is ready (can take a bit to process when you first start up), you can run this command (ctrl-c to stop watching the logs):

```sh
docker-compose logs -f server
```

You'll know the site is ready when you see something like:

```sh
server_1        | Watching for changes in /src/{assets,content,layouts,static,themes}
server_1        | Watching for config changes in /src/config.toml, /src/themes/docsy/config.toml
server_1        | Environment: "development"
server_1        | Serving pages from memory
server_1        | Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
server_1        | Web Server is available at //localhost:1313/ (bind address 0.0.0.0)
server_1        | Press Ctrl+C to stop
```

As you're changing things and adding new content, your local Hugo server might get a bit wonky at times or you'll want to see what errors it's throwing. Here's a few simple commands to work with your local Hugo:

#### See the Hugo Logs

```sh
docker-compose logs -f server
```

Leave `-f` off if you don't want new log entries to show up in your console. (ctrl-c to escape when `-f` is on)

#### Restart the Hugo Server

```sh
docker-compose restart server
```

#### Stop the Hugo Server

```sh
docker-compose stop server
```

### Local Hugo install method

For this method you need a recent extended version (we recommend version 0.67 or later) of Hugo to do local builds and previews of the Jenkins X documentation site.
If you install from the release page, make sure to get the extended Hugo version, which supports SCSS; you may need to scroll down the list of releases to see it.
Install Hugo following the [gohugo.io instructions](https://gohugo.io/getting-started/installing).

Check you're using `Hugo extended` and a version higher than `0.67.0` :

```sh
$ hugo version
Hugo Static Site Generator v0.58.3/extended darwin/amd64 BuildDate: unknown
```

The output should look similar to the one above.

#### Install PostCSS

To build or update your site’s CSS resources, you also need [PostCSS](https://postcss.org/) to create the final assets. If you need to install it, you must have a recent version of `NodeJS` installed on your machine so you can use `npm`, the Node package manager. By default `npm` installs tools under the directory where you run `npm install`:

```sh
sudo npm install -D --save autoprefixer
sudo npm install -D --save postcss-cli
```

Get local copies of the project submodules so you can build and run your site locally:

```sh
git submodule update --init --recursive
```

#### Starting the preview server

Build the site:

```sh
hugo server
```

It's ready when you see something like this:

```sh
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at //localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

Preview your site in your browser at: [localhost:1313](http://localhost:1313). You can use `Ctrl + c` to stop the Hugo server whenever you like.

It may be a good idea to run the server in a separate terminal so that you can keep it running while also using git or other commands.

## Contribution workflow

Now that you have your local preview environment, the [contribution workflow](/community/documentation/workflow/) documentation guides you through the steps to create your first pull request.

## Reference

The [references](/community/documentation/reference/) page contains more useful information when working with Hugo and the Jenkins X site.
