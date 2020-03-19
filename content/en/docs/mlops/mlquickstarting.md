---
title: "Using Machine Learning Quickstarts"
date: 2020-03-13T15:03:05Z
linktitle: "Using ML Quickstarts"
description: How to use Machine Learning quickstarts.
weight: 5
aliases:
  - /documentation/mlops/mlquickstarting
---

The Jenkins X MLOps Quickstarts Library provides template projects to make it quick and easy to set up everything you need to get started with a building a new ML-based asset.

Each quickstart project comprises two repositories, one which contains your training script and a second which takes the final model you have trained and wraps it as a RESTful service for deployment into your overall solution.

## Getting started
You can create an instance of a project using the command:

```
> jx create mlquickstart
```
and follow the instructions to select a template from the list.

Once the quickstart process completes, you will find two new projects in your current folder, one with the suffix `-training` and the other with the suffix `-service`.

The training project contains an example training script and some tests for the class of ML solution you selected. All the quickstarts are working examples, so you can see the solution in action and then start to modify it to meet your desired outcome.

The service project is designed to take your model and make it easy to wrap it in a microservice so you can deploy it into your application. Notice that at this stage, there is no model in this service project because you haven't trained it yet.

If you check the Git account you used to create the quickstart project, you will see that the two folders have been created as repositories and linked to your Jenkins X cluster.

Looking at your Jenkins X instance, you should be able to see that two builds have started for these projects. The service build will probably complete first, and it will create an instance of a new microservice in your staging environment, but this instance will fail to start and will end up in CrashLoopBackOff at this stage because it is waiting for the model to train.

The second build is training an example model. When this completes successfully, it will persist the model in ONNX format and will make a Pull Request against your service project to add the model and the training metrics to your service. If you check the repository for the service, you should be able to see the open PR and can verify the files that have been added.

At this stage, a preview environment will have been created for the service and you can verify its operation by connecting to it via a browser.

Once you are happy with the model, merge the PR and the service will be redeployed into staging with the model you trained.

You can watch this in action in the following video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/AqL_ME7BM6U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Customising your project
Now you are ready to go back to the local copy of your training project and can start editing the training script to change the model.

You will see that there are several steps annotated in the comments.

The first step is where you define success criteria for your training. We only want to go to the effort of deploying an instance of our model if we consider it sufficiently accurate for our purposes so you should always create one or more metrics by which you will later judge whether your training run was successful.

In the second step, we define the code to train your model. Feel free to change this to do what you want it to do.

In the third step is where we evaluate the trained model we hold in memory against the criteria you specified earlier. You are free to modify this code in line with your desired metrics.

Step four is only executed if your model passes the success threshold. If it does not, the training build is marked as 'failed' and stops. Within this step, we convert the in-memory model into ONNX format and persist it temporarily to the local filesystem of the container in which the training build is running. We also write any metrics data and plots we wish to persist into a folder called 'metrics'.

The training script exits at this point, however the Jenkins X pipeline for the training build will take the ONNX model and anything you placed in the 'metrics' folder and will create a PR against the service repo as shown earlier.

## Starting a training run
To trigger a training run after modifying the training script, you need to commit your changes to the remote repository associated with this project:

```
> git add app.py
> git commit -m "feat: Added new training feature..."
> git push
```

This will trigger Jenkins X to start a new training run which you can monitor via the UI or with:

```
> jx get build logs
```

## Additional training runs
If you would like to trigger a training run to start again without modifying the script, perhaps because your initial run failed to meet your success criteria you can run:

```
> jx start pipeline
```
and select the name of the training project you would like to trigger.

## Versioned assets
Every successful model trained creates a new version of your microservice. This enables you to do things like promoting an initial version of a model to your staging environment so that others on the team can focus on integrating your ML component with the rest of the application whilst you test alternate versions of the model in your preview environment to optimise performance. Once you are happy with your optimised model, you can promote it for integration by merging the Pull Request.

You can also use the git repository to go back to previous model instances in the event that you need to investigate any issues that might occur with deployed versions of earlier code. This gives you full traceability and an audit trail for your models.

Should you need to revert a model from a staging or production environment, you can simply change the revision number of the service application in the GitOps repo for the target environment to the last known good instance and commit your changes. Jenkins X will then update your environment as necessary.