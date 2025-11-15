# Jenkins X Documentation

[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/jenkins-x/jx-docs)
[中文文档](./README_CN.md)

This repository contains the source files for [jenkins-x.io](http://jenkins-x.io/). For the best experience, please read the documentation at [jenkins-x.io](http://jenkins-x.io/) as some links may not work when viewing directly in this repository.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Building the Documentation](#building-the-documentation)
- [Development Tools](#development-tools)
- [Content Management](#content-management)
- [Contributing](#contributing)

## Prerequisites

- Git
- Node.js and npm
- Hugo (see [Makefile](./Makefile) for recommended version)
- Docker (optional, for containerized development)

## Getting Started

1. Clone the repository with submodules:
```bash
git clone --recurse-submodules --depth 1 https://github.com/jenkins-x/jx-docs.git
cd jx-docs
```

2. Install dependencies:
```bash
npm install
```

## Development Setup

### Git Submodules Management

This repository uses two submodules:
- [docsy](https://github.com/google/docsy) - Documentation theme
- [labs-enhancements](https://github.com/jenkins-x/enhancements) - Jenkins X enhancements

Common submodule operations:
```bash
# Update submodules after fresh clone
git submodule update --init --recursive

# Update submodules with latest changes
git pull --recurse-submodules

# Check submodule status
git submodule status --recursive
```

## Building the Documentation

### Local Development

1. Set required environment variable:
```bash
set HUGO_GH_ACCESS_TOKEN=<your_github_token>
```

2. Start Hugo server:
```bash
make server
```
Access the site at [http://localhost:1313](http://localhost:1313)

### Docker Development

1. Start the containerized environment:
```bash
make compose-up
```

2. Stop the environment:
```bash
make compose-down
```
Access the site at [http://localhost:1313](http://localhost:1313)

## Development Tools

### Spell Checker

Run spell check on markdown files:
```bash
make spellcheck
```
Add new valid words to [.spelling](./.spelling) file (maintain alphabetical order).

### Link Checker

Verify all links and images:
```bash
make linkcheck
```
> Note: Initial run may be slow due to external link validation.

## Content Management

### Page Redirects

Add redirects for moved content using YAML front matter:
```yaml
aliases:
  - /previous/path
  - /old/path
```

### Updating Content

#### Upgrade Enhancements
```bash
cd content/en/docs/labs/enhancements
git checkout master
git pull
cd ..
git add enhancements
git commit -m "chore: update enhancements content"
```

#### Upgrade Docsy Theme
```bash
cd themes/docsy
git pull origin master
git submodule update --init --recursive
```

### Localization

We welcome contributions in different languages. Please see language-specific guides:
- [Chinese Documentation Guide](Localization_Chinese.md)

## Contributing

For detailed contribution guidelines, please refer to our [Documentation Contributing Guide](https://jenkins-x.io/community/documentation/).

---

## Support

- [Jenkins X Website](https://jenkins-x.io)
- [Community](https://jenkins-x.io/community/)
