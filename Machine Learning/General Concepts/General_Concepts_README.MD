# General Concepts


## Table of contents
1. [Data Spliting (Train-Test Split)](#train-split)
    1. [Train](#train)
    1. [Testing](#test)
    1. [Holdout](#holdout)
    1. [Whole Process](#whole-process)
1. [Cross Validation](#cv)
1. [Supervised Learning](#supervised)
    1. [](#)
1. [Unsupervised Learning](#unsupervised)
    1. [](#)
1. [Additional Resources](#additional-resources)  

<a name="introduction"></a>
## Introduction

---

This section will cover more general concepts in machine learning that is applicable to all types of models. This will include topics such as: train-test split, cross-validation, supervised/unsupervised models, etc. Most of these concepts are required to understand what is going on in the other sections.

<a name="train-split"></a>
## Data Splitting (Train-Test Split)

---

**Definition:**  
>`Data splitting` is when a dataset is split into two or more subsets. Typically, a dataset is split into: **training**, **validation** (Sometimes known as **testing**), and **holdout** (Sometimes known as **testing**!) Yes, it can get confusing. An example of data split could be 60%, 20%, 20%, (Train, test, holdout). 

<img src="https://miro.medium.com/max/1400/1*Nv2NNALuokZEcV6hYEHdGA.png" width="" height="250">

All 3 bars added together is the original dataset. 

<a name="train"></a>
### Training

>The `train` dataset is the dataset used to train the model. 

### Validation (Testing)

>The `Validation` dataset is used to determine how well the model is doing. This dataset can be used to help tune the hyper parameters within a model. This dataset is sometimes known as the testing data. Be careful as this is seperate from the holdout data in the next section. 

### Holdout 

>The `Holdout` dataset is data that the model has never "seen" before. This is data that is set aside before the model is trained. The holdout dataset can be used to compare different models to see how well a model is doing. 

### Whole Process

Generally, the process looks like the following:

* Data is split into two groups. A general training and holdout dataset.
* The general training dataset is further split into training and validation.
* The model is trained on the training set.
* The model is tuned on the validation set.
* Repeat training and tuning with other models.
* Compare models by comparing accuracy with predicting on the test set.

<a name="Cross Validation"></a>
## Cross Validation

---

**Definition:**  
>`Cross-validation` is a resampling procedure used to evaluate machine learning models on a limited data sample. There are different types of cross-validation methods. For example: **K-folds**, or **Leave-one-out**. Instead of a traditional train-test-holdout, it becomes cross-validation-holdout. 

>In **K-folds cross-validation**, the dataset is split into k different "blocks". One block is treated as the validation, and the rest is the training. This is repeated until all blocks are used. **Leave-one-out** is similar to k-folds. However, instead of blocks, each individual row is treated as a "block". As a trade off, this method takes a long time to run. 

<img src="https://www.mathworks.com/discovery/cross-validation/_jcr_content/mainParsys/image.adapt.full.medium.jpg/1630394319812.jpg" width="" height="250">  

Example of 4-fold cross validation. (K = 4)

Some other cross-valid methods are **stratified cross-validation** and **time series cross-validation**

<a name="supervised"></a>
## Supervised Learning

---

<a name="unsupervised"></a>
## Unsupervised Learning

---

<a name="additional-resources"></a>
## Additional Resources

---