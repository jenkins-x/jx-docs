# Jenkins X Docs
<a id="markdown-jenkins-x-docs" name="jenkins-x-docs"></a>

This repository contains the source for [jenkins-x.io](http://jenkins-x.io/).

**NOTE:** Please browse these docs on [jenkins-x.io](http://jenkins-x.io/). Not all links work when browsing the Markdown files inside this repository.

----

<!-- TOC -->

- [Building the docs](#building-the-docs)
    - [Preparing the sources](#preparing-the-sources)
        - [Git submodules](#git-submodules)
    - [Downloading npm modules](#downloading-npm-modules)
    - [Running Hugo](#running-hugo)
        - [Locally](#locally)
        - [Dockerized](#dockerized)
- [Common Workflows](#common-workflows)
    - [Running spell check](#running-spell-check)
    - [Checking links, images, etc](#checking-links-images-etc)
    - [Adding redirects](#adding-redirects)
    - [Upgrading the enhancements content](#upgrading-the-enhancements-content)
- [Localization](#localization)
- [Contributing](#contributing)

<!-- /TOC -->

----

## Building the docs
<a id="markdown-building-the-docs" name="building-the-docs"></a>

### Preparing the sources
<a id="markdown-preparing-the-sources" name="preparing-the-sources"></a>

To edit the docs locally, you need to clone this repository:

```bash
git clone  --recurse-submodules --depth 1 https://github.com/jenkins-x/jx-docs.git
```

#### Git submodules
<a id="markdown-git-submodules" name="git-submodules"></a>

Notice the use of `--recurse-submodules` in the clone command above.
This option will pull in two git [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), namely  
[docsy](https://github.com/google/docsy) and [labs-enhancements](https://github.com/jenkins-x/enhancements).
If you already have a git clone without the submodules checked out you can run:

```bash
git submodule update --init --recursive
```

In subsequent updates of the sources via `git pull` also remember to pull the changes from the submodules:

```bash
git pull --recurse-submodules
```

you can view the commit sha of the sub-modules via:

```bash
git submodule status --recursive
```

### Downloading npm modules
<a id="markdown-downloading-npm-modules" name="downloading-npm-modules"></a>

After getting all the sources, you need to [install npm](https://www.npmjs.com/get-npm) and make sure the required npm modules are installed:

```bash
npm install
```

### Running Hugo
<a id="markdown-running-hugo" name="running-hugo"></a>

The site itself is built with [Hugo](https://gohugo.io/) and configured in [`config.toml`](./config.toml).
You have two options to run Hugo, either directly on your machine or via [Docker Compose](https://github.com/docker/compose).
The following two sections describe the two alternatives in more detail.

**NOTE:** Hugo renders the site in memory in development mode.
Per default, no content is written to disk.

#### Locally
<a id="markdown-locally" name="locally"></a>

If you want to build the site locally on your machine, you need to [install](https://gohugo.io/getting-started/installing) Hugo.
Check the [Makefile](./Makfile) for the latest recommended version use.
Once installed, you can run:

```bash
make server
```

You can now access the site under [localhost:1313](http://localhost:1313).

#### Dockerized
<a id="markdown-dockerized" name="dockerized"></a>

Instead of installing Hugo locally, you can use the provided `docker-compose.yml` to spin up the Hugo server in a containerized environment.
Make sure you have [Docker](https://docs.docker.com/install/) installed.

```bash
make compose-up
```

You can now access the site under [localhost:1313](http://localhost:1313).
The Hugo server is running in the background.
You can stop it via:

```bash
make compose-down
```

## Common Workflows
<a id="markdown-common-workflows" name="common-workflows"></a>

### Running spell check
<a id="markdown-running-spell-check" name="running-spell-check"></a>

We are not all masters of spelling, so luckily there are tools to help us fix that.
We are using [node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck) to run through all our markdown files and list any spelling issue or unknown word.

To make this as simple as possible, just run the following command:

```bash
make spellcheck
```

The report likely includes words that are spelt correctly, but that just means the spell checker is not aware of the correct spelling (happens a lot for technical terms, commands, etc.).
Please edit [`.spelling`](./.spelling) and add the unknown word.
Also, please try and keep the list alphabetically sorted, which makes it easier to navigate.

### Checking links, images, etc
<a id="markdown-checking-links-images-etc" name="checking-links-images-etc"></a>

To get help in checking all the links, we'll use [htmlproofer](https://github.com/chabad360/htmlproofer).

```bash
make linkcheck
```

**NOTE:** The initial run is really slow (due to external link checks) and that the cache is only build up when it finishes.

**NOTE:**: It's safe to ignore the `... x509: certificate ...` errors for now

### Adding redirects
<a id="markdown-adding-redirects" name="adding-redirects"></a>

If you move a page to a different location you can add a redirect via using an _aliases_ entry in the header of the page:

```yaml
aliases:
  - /some/old/path
  - /another/path
```  

### Upgrading the enhancements content
<a id="markdown-upgrading-the-enhancements-content" name="upgrading-the-enhancements-content"></a>

To upgrade to a new enhancements commit - we'll hopefully automate this soon!

```bash
cd content/en/docs/labs/enhancements
git checkout master
git pull
cd ..
git add enhancements
git commit -m "move to latest enhancements"
```

## Localization
<a id="markdown-localization" name="localization"></a>

To let more people know Jenkins X better, localization is essential and meaningful.
And we should keep some rules about this, please read related languages below:

- [Chinese](Localization_Chinese.md)

## Contributing
<a id="markdown-contributing" name="contributing"></a>

Please refer to the documentation contributing guide available at [Jenkins X website](https://jenkins-x.io/community/documentation/).