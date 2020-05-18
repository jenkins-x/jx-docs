---
title: Create Spring Boot
linktitle: Create Spring Boot
description: How to create new Spring Boot applications and import them into Jenkins X
weight: 40
aliases:
  - /docs/resources/guides/using-jx/common-tasks/create-spring/
  - /docs/resources/guides/using-jx/creating/create-spring/
---

Java microservices developers can leverage the opinionated resources and
preconfigured components of [Spring
Boot](https://spring.io/projects/spring-boot). This software framework
takes the Spring platform and adds preconfigured components, third-party
libraries, software packagers, and command-line tools for running
specialized scripts.

The aim of Spring Boot is to create Spring-based software such as
microservices, which can be deployed using the `java` command-line
runtime or standalone *Web Application Resource* (WAR) package files.
Spring Boot uses Spring as a foundation for development, and enhances it
with components that provides faster development and deployment,
opinionated configuration and setup to get started developing
microservices quickly, and a plugin framework that features Maven and
Gradle project support.

## Spring Boot and Jenkins X

You can incorporate Jenkins X into your Spring
Boot projects in two ways:

1.  By importing existing Spring Boot code using `jx import`

2.  By creating a Spring Boot application from scratch using
    `jx create spring`

## Importing existing Spring Boot projects

If you have an Spring Boot project (perhaps created using the [Spring Boot Initializr](http://start.spring.io/)) that you want to manage builds using
Jenkins X, you can use `jx import` to commit your
code to a Git service such as GitHub, add a `Dockerfile` to build your
Spring Boot project as a Docker image, a `pipeline.yaml` to your
`~/.jx/` directory that manages the development pipeline, and a Helm
chart for running as a package in Kubernetes.

1.  Change into your Spring Boot project directory:

```sh
cd my-springapp/
```

2.  Run the import from a command-line:

```sh
jx import
```

3.  The application asks for your Git username (such as `myuser`).

4.  The application asks if you wan to initialize your project in Git.

5.  The application asks you what organization to use for managing
    builds (for example, `myorg`)

6.  The application asks if you want to name your repository (such as
    `my-springapp`)

You can now perform builds, commit project code to your newly created
Git repository, and Jenkins X will automatically
process pull requests and create [previews](/docs/reference/preview/) of your applications for testing and validation.

## Creating a new Spring Boot application

If you are evaluating Spring Boot in your Jenkins X environment and need an application template of a Spring Boot project that is preconfigured with CI/CD pipeline and GitOps promotion, use `jx create` to make the preconfigured project.

1.  Run the Spring Boot creation via command-line:

```sh
jx create spring
```

2.  The application asks for your Git username (such as `myuser`)

3.  The application lets you choose your Git organization from an
    available list

4.  The application asks for a repository name, such as
    `my-springapp1`

5.  The application prompts you for the development language for your
    project (by default, `java`)

6.  The application prompts you for a group ID (by default,
    `com.example`)

7.  The application prompts you for any Spring Boot starters, or
    dependency descriptors that you can use to make your development
    smoother and quicker.

    We recommend at minimum the `Actuator` and `Web`
    dependencies, which you can activate by moving to those checkboxes
    and hitting the `Space Bar` to select them. The application
    prompts you to initialize Git

There is a [demo of using the command: jx create spring](/docs/resources/demos-talks-posts/create_spring/).

You can also pass certain options to the `jx create` command, such as specifying Spring Boot dependencies:

```sh
jx create spring -d web -d actuator
```

The `-d` argument lets you specify the Spring Boot dependencies you wish to add to your spring boot application. In the above example, the command calls the `web` argument, which passes in the Web Starter dependency to create RESTful web applications; the `actuator` dependency for monitoring the health and metrics your application.  When you omit the `-d` arguments and let the `jx` command prompt you to pick the dependencies via a CLI wizard

We recommend you always include the **actuator** dependency in your Spring Boot applications as it helps provide health checks for [Liveness and Readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/).

## Spring Boot projects managed by Jenkins X

The two methods of configuring Spring Boot projects in Jenkins X performs several actions:

-   Create a new Spring Boot application in a local subdirectory

-   Add your source code into a Git repository

-   Create a remote git repository on a git service, such as
    [GitHub](https://github.com)

-   Commit your code to the remote Git service

-   Adds default build files to your project:

    -   A `Dockerfile` to build your application as a docker image

    -   A `pipeline.yaml` to implement the CI / CD pipeline

    -   A helm chart to run your application inside Kubernetes

-   Registers a webhook (such as
    `http://hook-jx.192.169.1.100.nip.io/hook`) on the remote git
    repository

-   trigger the first pipeline build

You can now use your Git-enabled local project subdirectory to make
changes to your Spring Boot application, push those changes to Git, and
automatically have Jenkins X build, create
[previews](/docs/reference/preview/) for testing and validation, and [promote](/developing/promote/) your app to production for general usage.
