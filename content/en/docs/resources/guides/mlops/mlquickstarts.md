---
title: "Finding a Machine Learning Quickstart"
date: 2020-03-13T15:03:05Z
linktitle: "ML Quickstarts Directory"
description: Directory of template Machine Learning projects.
weight: 10
aliases:
  - /documentation/mlops/mlquickstarts
---

This directory is intended to help you find your way around the Jenkins X MLOps Quickstarts Library and get you up and running rapidly with a template project based around the class of Machine Learning approach you wish to work with and the language and framework you prefer.

The directory is divided by target programming language (Python only at this stage, but with additional quickstarts to follow in other languages) and then by ML framework.

The section for each framework is then divided by class of ML approach and CPU/GPU-based solutions.

To create an instance of a project, find the title of the particular quickstart you wish to use and then select this from the list that is presented when you use the command:

```
> jx create mlquickstart
```


**Python Quickstarts:**
---
<img src="https://avatars-04.gitter.im/group/iv/4/57542d4cc43b8c601977b6ad?s=48" alt="LightGBM Logo" width="40" align="right">

---
## LightGBM
LightGBM is a gradient boosting framework that uses tree based learning algorithms. It is designed to be distributed and efficient with the following advantages:

- Faster training speed and higher efficiency.
- Lower memory usage.
- Better accuracy.
- Support of parallel and GPU learning.
- Capable of handling large-scale data.

LightGBM can outperform existing boosting frameworks on both efficiency and accuracy, with significantly lower memory consumption.

Documentation is at [https://lightgbm.readthedocs.io/](https://lightgbm.readthedocs.io/)

**CPU-based:**

`ML-python-lightgbm-cpu` is a project for training and deploying tree based learning algorithms using the LightGBM library.

Training Script : [ML-python-lightgbm-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-lightgbm-cpu-training)

Service Wrapper : [ML-python-lightgbm-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-lightgbm-cpu-service)

---
<img src="https://pytorch.org/assets/images/logo-dark.svg" alt="PyTorch Logo" width="140" align="right">

## PyTorch
Pytorch is a rich ecosystem of tools, libraries, and more to support, accelerate, and explore AI development.

Documentation is at [https://pytorch.org/](https://pytorch.org/)
### Convolutional Neural Networks
**CPU-based:**

`ML-python-pytorch-cpu` is a simple example demostrating the use of Pytorch with a Convolutional Neural Network (AlexNet) for image recognition.

Training Script : [ML-python-pytorch-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-pytorch-cpu-training)

Service Wrapper : [ML-python-pytorch-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-pytorch-cpu-service)


### Multi-layer Perceptron Networks
**CPU-based:**

`ML-python-pytorch-mlpc-cpu` is a project for training and deploying Multi-layer Perceptron Networks in Pytorch.

Training Script : [ML-python-pytorch-mlpc-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-training)

Service Wrapper : [ML-python-pytorch-mlpc-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-service)

**GPU-based:**

`ML-python-pytorch-mlpc-gpu` is a project for training and deploying Multi-layer Perceptron Networks in Pytorch with CUDA acceleration.

Training Script : [ML-python-pytorch-mlpc-gpu-training](https://github.com/machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-training)

Service Wrapper : [ML-python-pytorch-mlpc-gpu-service](https://github.com/machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-service)

---
<img src="https://scikit-learn.org/stable/_static/scikit-learn-logo-small.png" alt="Scikit Logo" width="140" align="right">


## Scikit-Learn
Simple and efficient tools for predictive data analysis, accessible to everybody, and reusable in various contexts. 

Built on NumPy, SciPy, and matplotlib

Documentation is at: [https://scikit-learn.org/](https://scikit-learn.org/)

### K Nearest Neighbor Classification
**CPU-based:**

`ML-python-sklearn-knc-cpu` is a project for training and deploying K Nearest Neighbor Classification using the SciKit-Learn library.

Training Script : [ML-python-sklearn-knc-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-sklearn-knc-cpu-training)

Service Wrapper : [ML-python-sklearn-knc-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-sklearn-knc-cpu-service)

### Naive Bayes Classification
**CPU-based:**

`ML-python-sklearn-nbc-cpu` is a project for training and deploying Naive Bayes Classification using the SciKit-Learn library.

Training Script : [ML-python-sklearn-nbc-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-sklearn-nbc-cpu-training)

Service Wrapper : [ML-python-sklearn-nbc-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-sklearn-nbc-cpu-service)

### Random Forest Classification
**CPU-based:**

`ML-python-sklearn-rfc-cpu` is a project for training and deploying Random Forest Classifications using the SciKit-Learn library

Training Script : [ML-python-sklearn-rfc-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-sklearn-rfc-cpu-training)

Service Wrapper : [ML-python-sklearn-rfc-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-sklearn-rfc-cpu-service)

### Ridge Classification
**CPU-based:**

`ML-python-sklearn-rc-cpu` is a project for training and deploying Random Forest Classification using the SciKit-Learn library.

Training Script : [ML-python-sklearn-rc-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-sklearn-rc-cpu-training)

Service Wrapper : [ML-python-sklearn-rc-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-sklearn-rc-cpu-service)

### Support Vector Machines
**CPU-based:**

`ML-python-sklearn-svm-cpu` is a project for training and deploying Support Vector Machines using the SciKit-Learn library.

Training Script : [ML-python-sklearn-svm-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-sklearn-svm-cpu-training)

Service Wrapper : [ML-python-sklearn-svm-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-sklearn-svm-cpu-service)

---
<img src="https://www.gstatic.com/devrel-devsite/prod/vbc166ea82921a0c6d4f6ee6c94a3e0bcf7b885b334dd31c4592509cb25134992/tensorflow/images/lockup.svg" alt="TensorFlow Logo" width="140" align="right">

## TensorFlow
TensorFlow is an end-to-end open source platform for machine learning. It has a comprehensive, flexible ecosystem of tools, libraries and community resources that lets researchers push the state-of-the-art in ML and developers easily build and deploy ML powered applications.

Documentation is at [https://www.tensorflow.org/](https://www.tensorflow.org/)

### Classification (MNIST)
**CPU-based:**

`ML-python-tensorflow-mnist-cpu` is a project for training and deploying an MNIST classifier using TensorFlow.

Training Script : [ML-python-tensorflow-mnist-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-tensorflow-mnist-cpu-training)

Service Wrapper : [ML-python-tensorflow-mnist-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-tensorflow-mnist-cpu-service)

**GPU-based:**

`ML-python-tensorflow-mnist-gpu` is a project for training and deploying an MNIST classifier using TensorFlow with CUDA acceleration.

Training Script : [ML-python-tensorflow-mnist-gpu-training](https://github.com/machine-learning-quickstarts/ML-python-tensorflow-mnist-gpu-training)

Service Wrapper : [ML-python-tensorflow-mnist-gpu-service](https://github.com/machine-learning-quickstarts/ML-python-tensorflow-mnist-gpu-service)

---
<img src="https://xgboost.ai/images/logo/xgboost-logo.png" alt="XGBoost Logo" width="140" align="right">

## XGBoost
Scalable and flexible Gradient Boosting. Supports regression, classification, ranking and user defined objectives.

Documentation is at: [https://xgboost.readthedocs.io/en/latest/](https://xgboost.readthedocs.io/en/latest/)

### Gradient Boosted Decision Trees
**CPU-based:**

`ML-python-xgb-cpu` is a project for training and deploying gradient boosted decision trees using the XGBoost library.

Training Script : [ML-python-xgb-cpu-training](https://github.com/machine-learning-quickstarts/ML-python-xgb-cpu-training)

Service Wrapper : [ML-python-xgb-cpu-service](https://github.com/machine-learning-quickstarts/ML-python-xgb-cpu-service)

