# Feature Engineering

## Table of contents
1. [Introduction](#introduction)
2. [General Guidelines](#general-concept)
2. [Data Cleaning](#data-cleaning)
    1. [Irrelevant data](#irrelevant-data)
    2. [Duplicates](#duplicates)
    2. [Syntax Errors](#syntax-errors)
    3. [Outliers](#outliers)
    4. [Missing Values](#missing-values)
    5. [Others](#others)
4. [Data Imbalance](#data-imbalance)    
3. [Feature Engineering Methods](feature-engineering-methods)
4. [Practice Examples](#practice-examples)
5. [Toolkit](#Toolkit)
6. [Additional Resources](#additional-resources)

<a name="introduction"></a>
## Introduction  

---

#### Definition:
>`feature Engineering` is the process of using domain knowledge to extract features from raw data. These features can be used to improve the performance of machine learning algorithms. Feature engineering can be considered as applied machine learning itself.

>`Feature` is an individual measurable property or characteristics of a phenomenon being observed. In statistics, this is generally known as the `independent variable`

>`Target` or Target Variable, is the feature of a data set you are trying to predict. In statistics, this is the `dependent variable`.

>`Continuous` features are features that are numerical in nature and represents a value. (e.g. A person's weight) 

>`Categorical` features are features that take on a limited, usually fixed, number of possible values. (e.g. Gender, country, age group.)

In other words: `Transforming data to create model inputs.` Unfortunately there is no "handbook" for feature engineering. It depends heavily on the problem on hand and is fairly open-ended. On average, a data scientist will spend most of their time on data cleansing and feature engineering. Keeping an eye on the [80/20 rule](https://www.investopedia.com/terms/1/80-20-rule.asp) is helpful to avoid spending too much time on this process.    
  
<a name="general-concept"></a>
## General Concept  

---

### 1. What are the limits on feature engineering

### Limits on Feature Engineering:  

Traditionally, there are two main problems that emerges: 

#### Eating up degrees of freedom: relatively small data sets
* \# of patients in trial
* \# of elections in Congress
* \# of respondents in survey
* If the data lives in a N x K matrix, K should be relatively small compared to N.

#### Relevance to hypothesis testing, emphasis on explanation
* Start with an equation defining the relationship between the key independent and dependent variables. 
* Other variables enter the model as controls, not really interested in their functional form. 

#### In modern data science applications, neither are an issue:
* Start with lots of data
* Care more about prediction than explanation. 

#### Limiting the number of initial features
* Adding many correlated predictions can decrease model performance  
* More variables make models less interpretable
* Models have to be generalizable to other data
    * Too much feature engineering can lead to overfitting
    * Close connection between feature engineering and cross validation

### 2. How do you construct "Good Features"?

#### This is the open-ended question in data science. 

* There are metrics, such as Pearson correlation coefficient, can help tell which features are useful one at a time.
    * However, this cannot determine which **set** of features work best together.
    * This is an NP complete problem.

* There are data analysis services that include automated feature engineering. 
    * It is better to add features explicitly, more control over exact features.

#### Additional Points 

* Start with a reasonable sized set of features
    * Include features suggested by domain knowledge
    * Test these out individually, build from bottom up

* Types and # of features depend on model used.
    * Can include more features if model does some feature selection
        * lasso regression, e.g., logit with || L_{1} || regularization (but not || L_{2}|| ridge)
        * GBM (Gradient Boosting Machine) with backward pruning (but not random forests)
        * Stepwise regression, either forward or backward feature selection
    * Some models are invariant to monotonic variable transformations
        * Tree based approaches divide variables into two groups at each branch.
    

<a name="data-cleaning"></a>
## Data Cleaning

---

In academic settings, such as kaggle, have nice clean data sets to learn machine learning processes. Real world data doesn't always like to play nice. Data sets can have missing values, syntax errors, irrelevant data, duplicates, etc. These issues need to be resolved before any feature engineering can be done.

>Garbage in, garbage out

#### General Process

* Remove duplicate or irrelevant observations
* Fix structural errors (standardization)
* Filtered unwanted outliers
* Handle missing data
* Validate and QA

<a name="irrelevant-data"></a>
### Irrelevant data

Irrelevant data is when the data on hand don't add any value. Generally, does not fit under the context of the problem being solved. For example, if you were doing a study on one city, other cities would be not be included. **Only if** one is sure the data is unimportant, it can be dropped. There is value in asking someone who is a domain expert prior to dropping the given data. 

<a name="duplicates"></a>
### Duplicates

Duplicates are data points that are repeated in a given data set. This can occur due to numerous reasons. For example, the data set comes from multiple sources. Or it could be as straightforward as hitting a submit button twice on a form.

<a name="standardisation"></a>
### Standardisation

All data in each feature variable should be in a standardized format. (e.g. All age is an integer. Strings are all lower case without special characters.)

<a name="syntax-errors"></a>
### Syntax Errors

**Remove white spaces:** Extra white spaces at the beginning or end of a string should be removed.  

    Wrong: 
    "   Hello World       "

    Correct:
    "Hello World"

**Pad strings:** Strings can be padded with spaces or other characters to reach a certain length.   

    Zip-code
    8904 => 08904 (5 digits)

    747 => 000747 (6 digits)

**Typos**: Fixing incorrectly entered data.

Example:  

| Gender|
| ------|
| m     |
| Male  |
| fmale |
| F     |
| Fem.  |

This categorical variable should only have 2 classes. In its current state, it can be considered as 5 different classes. Therefore, we need to determine the correct class and correct the issue.
>Bar graphs is a useful tool to visualize all unique values. One can notice some values are different but mean the same thing. (i.e. 'New York' and 'NY') Or, difference in capitalization. (i.e. 'trucks' and 'TRUCKS')

There are a few possible solutions:

1. Mapping
2. Pattern Matching
3. Fuzzy matching  

Given there aren't many errors, one can manually `map` each value to "female" or "male". This can be tedious with lots of errors in the data. 

    dataframe['Gender'].map({'m' : 'male', 'fmale' : 'female', ...})

`Pattern match:`Looking for specific patterns. (i.e. Look for the occurrences of F or f in the gender at the beginning of the string) 

    re.sub(r"\^f\$", 'Female', 'female', flags=re.IGNORECASE)

`Fuzzy matching` is an algorithm that identifies the distance between the expected string(s) and each of the given one. In this case, the number of operations needed to turn one string into another. (i.e. Turning 'm' into 'male' takes 3 operations and 5 for 'female'. Thus, it is higher likely to be 'male' )

| Gender| Male | Female |
| ------| :------: | :----: |
| m     |3|5|
| Male  |1|3|
| fmale |3|1|
| F     |5|3|
| Fem.  |5|3|

<a name="outliers"></a>
### Outliers

Outliers are any data points that are distinctively different from other observations. They could be real outliers or mistakes. Outliers can mislead the training process and create less accurate models. Thus, outliers should be removed. 

<img src="https://seaborn.pydata.org/_images/seaborn-boxplot-1.png" width="" height="300">

  
Box plots is a simple way to visualize numerical outliers.  

    X_train.boxplot()

Interquartile Range (IQR) can also be used to identify outliers in a given feature. Values that are outside a specified threshold (normally 1.5 x IDR above the 75th percentile and below the 25th percentile). 
    Q1 = X_train.quantile(0.25)
    Q2 = X_train.quantile(0.75)
    IQR = Q3 - Q1
    X_train_new = X_train[~((X_train < (Q1 - 1.5 * IQR)) | (X_train > (Q3 + 1.5 * IQR))).any(axis=1)]

<a name="missing-values"></a>
### Missing Values

Large data sets rarely tends to be perfectly filled. There are many reasons for why there are missing values. For example, the person collecting data may have forgotten. Missing data needs to be handled as they affect the training. 

There are a few ways to handle missing data: 

* Dropping missing data
    * Dropping specific rows of data
    * If a feature variable has >90% of missing values, it makes sense to drop the entire feature.
* Imputing (filling) missing values
    * Mean, Median and Mode
        * This method is fastest, but reduces variance in the data set.
    * For categorical models, missing values can be treated as its own category.
    * Linear regression
        * General process
            * Select predictors of the variable with missing values with a correlation matrix.
            * Using predictors as independent variable and the variable with missing data as dependent.
            * Create a regression equation to fill the missing values
        * Provides good estimates for the missing values.
        * Can deflate the standard error. 
        * Assumes there is a linear relationship between the variables used. (May not have linear relationship)

    * KNN (K Nearest Neighbors)
        * k neighbors are chosen based on some distance measure, and their average is used as an imputation estimate. This method requires the selection of the number of the nearest neighbors, and a distance metric. 
        * Works for both discrete and continuous attributes.
    
<a name="others"></a>
### Others 

WIP


<a name="data-imbalance"></a>
## Data Imbalance

---

A classification data set with skewed class proportions is called imbalanced. The classes that make up a larger proportion of the data set are called `majority classes`. The smaller proportion is known as `minority classes`. 

There are two main causes for imbalanced data: Data sampling, and properties of the domain.   

The methodology for how the data was collected/sampled from the problem domain. This might involve biases and errors during the data collection. Often in this case, the imbalance can be corrected by improved sampling methods, or correcting measurement errors.     

The imbalance might be a property of the problem domain. It could be that collecting observations in one class is more expensive in cost, time, computation, or other resources. Thus, making it infeasible or intractable to simply collect more samples from the domain. 

**Imbalanced data:**

| Severity of Imbalance | Proportion of Minority Class|
| :------:| :------:|
| Mild     | 20 - 40% of the data set|
| Moderate | 1-20% of the data set   |
| Severe  | <1% of the data set     |

<img src="https://i.imgur.com/JqMwoM2.png" width="" height="250">

 
For example: Fraud detection will naturally have a class imbalance. # of fraudulent transactions will tend to occur significantly less than legitimate transactions.   

Generally, class imbalance will cause the model to favor the majority class. The model is spending most of it's time on the majority classes, thus not learning enough from the minority classes. This is known as the [accuracy paradox](https://en.wikipedia.org/wiki/Accuracy_paradox): the model can have a high level of accuracy, but too crude to be useful. Thus, `precision` and `recall` are better measurement tools. **It's worth a shot to try training on the true distribution first.** If the model works well and generalizes, time is saved. Otherwise, there are methods to combat data imbalance. 

### 1. Random Undersampling and Oversampling 

<img src="https://miro.medium.com/max/2400/1*ENvt_PTaH5v4BXZfd-3pMA.png" width="800" height="300">

* **Random Undersampling:** Randomly removing examples in the minority class
* **Random Oversampling:** Randomly duplicating examples in the minority class

These two methods are referred as *"naive resampling"* as they assume nothing about the data and no heuristics are used. These methods are simple to implement and fast to execute, making it desirable on large and complex data sets.
The **disadvantage with undersampling is that it discards potentially useful data**. The main **disadvantage with oversampling, as exact copies are made on existing examples, is overfitting**. Additionally, due to the increased number of training example, the **learning time is also increased**. 

### 2. Downsampling and Upweighting

* **Downsampling:** Training on a disproportionately low subset of the majority class examples.
* **Upweighting:** Adding an example weight to the downsampled class.

First, the majority class is downsampled. For example: If our fraud data set is 1:100, we can downsample by a factor of 10. Now, our data is a 10% minority vs 90% majority classes. Much better for training. 

Next, weights are added to the downsampled class. In this case, weights refer to example weights, which means counting an individual example more importantly during training. For example, a factor of 10 would mean that the example is 10 times as important, compared to a weight of 1.  

    {Example Weight} = {Original Example Weight} * {Downsampling Factor}
In our previous case, we would have 1 (Original example weight) * 10 (Downsampling factor) = 10 (Example weight)

There are a few reasons to both downsampling and upweight the majority:  
* Faster convergence
    * The minority class appears more often, this helps the model converge faster.
* Calibration
    * Ensures our model output can still be interpreted as probabilities. 


### 3. Synthetic Minority Over-sampling Technique (SMOTE)

<img src="https://miro.medium.com/max/960/1*XvKkuORUzmJaz042NgB0oA.png" width="" height="250">

SMOTE look at the feature space for the minority data points and consider its *k* nearest neighbours. It creates new samples based on this algorithm. 



<a name="feature-engineering-methods"></a>
## Feature Engineering Methods

### Numerical Features

* See Single Variable Transformations


### Categorical Features

### General Features

Converting nonnumeric to numeric  
* Count # of times each value appears.
* One hot encoding
    * Also known as dummy variables  
    * Converts categorical variables into several binary columns, where 1 denotes the presence of that row belonging to the category.
* Feature hashing ('The hashing trick')
    * Method for turning arbitrary features into a sparse binary vector. 
    

### Binning/Bucketing

Works for both Categorical and Numerical data.

Binning makes the model more robust and prevents overfitting, at the cost on the performance. Binning data causes the data to be more regularized and loses some information.

### Normalization 

* **Scaling the data**
    * Often used with linear models and neural networks.
    * Sklearn has some scalers functions:
        * Minmax Scaler
            * Each value is subtracted by the minimum value of the respective feature, then divided by the range of original maximum and minimum of the same feature. Range between [0, 1]
        * Robust Scaler
            * Each value is subtracted by the median and divided by the interquartile range.
            * Values range will no longer be [0, 1]. Thus, `StandardScaler` is used to rescale each column to have 0 mean and 1 standard deviation.
* **Normalization using Standard Deviation**
    * Often used with linear models and neural networks.
* **Log-based transformation** 
    * Using a log transformation to normalize a feature, helps handle skewed data.
    * Reduces the effect of outliers, allowing the model to be more robust.
    * Values must be positive.
        * Can add 1 to all data if need be. 
    * Log transformation & GLM with log link are different.
     
    
### Single Variable Transformations

* x^2
* root x
* log x

### Two Variable Combinations

* Add: Sum similar scaled variables
* Subtract: Difference relative to baseline
* Multiply: Interactive effects
* Divide (Scaling/normalizing)

### Dimension Reduction

These are techniques to reduce the number of input variables in training data. High-dimensionality might mean hundreds,thousands, or even millions of input variables.

<img src="https://blog.bioturing.com/wp-content/uploads/2018/11/Blog_pca_6b.png" width="" height="250"> 

* PCA (Principal component analysis)
    * Converts n-dimensions of data into k-dimensions, where n > k, while maintaining as much information from the original dataset.   
    
* TSNE  (t-distributed stochastic neighbor embedding)
    * An unsupervised non-linear technique used for data exploration and visualizing higher-dimensional data.

<a name="practice examples"></a>
## practice examples 

[Kaggle Credit Card Fraud](https://www.kaggle.com/mlg-ulb/creditcardfraud)

<a name="additional-resources"></a>
## Additional Resources 

* [Google's Crash Course](https://developers.google.com/machine-learning/crash-course/representation/video-lecture)
* [Feature Engineering - David Epstein ODSC Boston 2015](https://opendatascience.com/feature-engineering-david-epstein/)
* [Fuzzy matching at scale](https://towardsdatascience.com/fuzzy-matching-at-scale-84f2bfd0c536)
* [The Quartz guide to bad data](https://github.com/Quartz/bad-data-guide)