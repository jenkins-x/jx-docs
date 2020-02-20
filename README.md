# Jenkins X Docs

Documentation site for [Jenkins X](http://jenkins-x.io/)

**Please browse these docs** on the [http://jenkins-x.io/](http://jenkins-x.io/) site as the links don't all work when browsing the markdown files inside github

## Contributing to Jenkins X Documentation

Please visit the contributing guide for the documentation available at [Jenkins X website](https://jenkins-x.io/docs/contributing/documentation/).

## Adding redirects

If you move a page to a different location you can add a redirect via this in the header of the page...

```yaml
aliases:
  - /some/old/path
  - /another/path
```  

## Build the docs locally

To edit the docs locally and try out what the [website](http://jenkins-x.io/) will look like then you need to clone this repository:

```bash
$ git clone  --recurse-submodules --depth 1 https://github.com/jenkins-x/jx-docs.git
```   

If you already have a git clone then run

```bash
$ git submodule update --init --recursive
```   

## Download npm modules

Then you need to run this command to download the requirerd npm modules:
                                                                 

```bash
$ npm install
```   

### Dockerized Hugo

Instead of installing Hugo locally, you can use the included `docker-compose.yml` to spin up the Hugo server. Make sure you have Docker installed.

* Build and run the preview server: `docker-compose up -d server`
* go to http://localhost:1313 to view the site

### Local Hugo install

Then to view the docs in your browser, [install Hugo](https://gohugo.io/getting-started/installing).
Navigate to the directory, run hugo server, and open up the link:

```bash
$ cd jx-docs
$ hugo server

Started building sites ...
.
.
Serving pages from memory
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```
### Running spell check

We're not all masters of spelling, so luckily there's tools to help us fix that. We'll be using [node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck) to run through all our markdown files and list any spelling issue or unknown word it can find.

To make this as simple as possible, just run the following command

```bash
$ docker-compose up spellchecker
```

This will output any issue the spell checker have found.

It's likely that the report includes words that are spelled correctly, but that just means the spell checker is not aware of the correct spelling (happens a lot for technical terms, commands, etc.). Please edit the `.spelling` file and add the unknown word.
Also, please try and keep the list alphabetically sorted; makes it easier to navigate when you're looking for something

### Checking links, images, etc

To get help in checking all the links etc. we'll use the awesome tool [htmltest](https://github.com/wjdp/htmltest).

Make sure you've built the dockerized Hugo mentioned above. If you called it something else than `jx-docs/dev` adjust the first command to use your image tag
* Generate the resulting HTML:
  ```
  docker-compose run server -d public -s /src
  ```
* Run htmltest:
  ```
  docker-compose run linkchecker
  ```
  * note that initial run is really slow (due to external link checks) and that the cache is only build up when it finishes. You should run this before making changes

**Note**: It's safe to ignore the `... x509: certificate ...` errors for now

# Contribution

Please visit the contributing guide for the documentation available at [Jenkins X website](https://jenkins-x.io/docs/contributing/documentation/).

## Localization

In order to let more people know Jenkins X better, localization is very important and meaningful. And we should keep some rules about this, please read related languages below:

* [Chinese](Localization_Chinese.md)
