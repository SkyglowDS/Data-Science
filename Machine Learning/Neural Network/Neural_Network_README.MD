# Neural Networks

### Table of contents:  
1. [Introduction](#introduction)
1. [Convolutional Neural Network (CNN)](#cnn)
    1. [Definition](#cnn-definition)
    1. [Use case](#cnn-use)
    1. [Layers](#cnn-layers)
1. [Recurrent Neural Networks (RNN)](#rnn)
    1. [Definition](#rnn-definition)
    1. [Use case](#rnn-use)
    1. [Layers](#rnn-layers)
1. [Generative Adversarial Networks (GANs)](#gans)
    1. [Definition](#gan-definition)
    1. [Use case](#gan-use)
    1. [Layers](#gan-layers)
1. [Optimization](#optimization)
	1. [Gradient Descent](#gradient)
1. [Metrics](#metrics)
1. [Common Issues](#common-issues)
1. [Additional Resources](#additional-resources)

<a name="introduction"></a>
## Introduction

Neural networks are a set of algorithms, modeled loosely after the human brain, that are designed to recognize patterns. They interpret sensory data through a kind of machine perception, labeling or clustering raw input.

There are many types of neural networks. This image gives a general overview: 

<img src = "../../_img/_neural_network/NNZoo.png">

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="cnn"></a>
## Convolutional Neural Network (CNN)

<a name="cnn-definition"></a>
### Definition 

A convolutional neural network consists of an input and an output layer, as well as multiple hidden layers. The hidden layers of a CNN typically consist of a series of convolutional layers that convolve with a multiplication or other dot product. The activation function is commonly a RELU layer, and is subsequently followed by additional convolutions such as pooling layers, fully connected layers and normalization layers, referred to as hidden layers because their inputs and outputs are masked by the activation function and final convolution. The final convolution, in turn, often involves backpropagation in order to more accurately weight the end product.

<a name="cnn-use"></a>
### Common use case:

Best to apply CNN to data that have spatial features. 

* Image Classification
* Object Detection
    * Location of object within an image
    * Used in self-driving cars
* Text Classification 
    * Classifying document types
* Speech recognition


<a name="cnn-layers"></a>
### Layers
They can be broken up into different layers:


#### Convolutional Layers

![Convolved Feature](https://miro.medium.com/max/526/1*GcI7G-JLAQiEoCON7xFbhg.gif)

1. Convolutional layers are able to detect patterns.
    * Patterns defined as edges, corners, circles, squares, etc. 
    * Deeper networks can have more sophisticated features (e.g. Eyes in image)
2. Filters are used to reduce the image size. (e.g. 3 x 3 block is slid one pixel group at a time and a dot product is used.) 
    * Filters can be used to detect edges. (e.g. Vertical edges, horizontal edges)
    * More complex filters can detect more complex patterns. 

Code Example
```
model.add(Conv2D(64, (3, 3), activation='relu'))
```
This is an example of a 2D convolution layer where there is 64 filters and a kernel size of 3x3. The activation function used is [ReLU](https://en.wikipedia.org/wiki/Rectifier_(neural_networks)). 

#### Pooling Layer  

![Pooling Layer](https://miro.medium.com/max/396/1*uoWYsCV5vBU8SHFPAPao-w.gif)  

1. Pooling layers are responsible for reducing the spatial size of the Convolved Feature.
    * Decreases the computational power required to process data through dimensionality reduction.
    * Useful for extracting dominant features
2. Two types of Pooling
    1. Max pooling
        * Returns maximum value from the portion covered by the kernel
        * Often acts as a Noise Suppressant: discards the noisy activations and preforms de-noising along with dimensionality reduction. 
    2. Average Pooling
        * Returns average of all the values from the portion of the image covered by the kernel

Code Example
```
model.add(MaxPooling2D(pool_size=(2, 2)))
```
This is an example of a max pooling layer. The size of the pool is 2x2.  

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="rnn"></a>
## Recurrent Neural Network (CNN)


<a name="rnn-definition"></a>
### Definition 

<a name="rnn-use"></a>
### Common use case:

<a name="rnn-layers"></a>
### Layers

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="gans"></a>
## Generative Adversarial Networks (GANs)


<a name="gans-definition"></a>
### Definition 

<a name="gans-use"></a>
### Common use case:

<a name="gans-layers"></a>
### Layers

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="optimization"></a>
## Optimization 

<a name="gradient"></a>
### Gradient Descent

<!-- ![Optimizers](https://towardsdatascience.com/teach-yourself-data-science-in-10-years-3-lessons-from-peter-norvig-director-of-machine-867e3218ce42) -->

Optimization algorithms helps minimize or maximize an Error function (aka Objective function)  

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="metrics"></a>
## Metrics 

Metrics are used to evaluate the performance of a Neural Network model.   

Example of metrics provided by keras:
```
375/375 [==============================] - 1046s 3s/step - loss: 1.2243 - accuracy: 0.5703 - val_loss: 1.1730 - val_accuracy: 0.5771
```
+ 375/375 defines the number of steps taken. 
+ 1046s is total time taken for this particular epoch. 
+ `Loss`, `accuracy`, `val_loss`, `val_accuracy` are provided. 

#### Loss  

Neural networks are mostly trained using gradient methods by an iterative process of decreasing a loss function. This can also be referred to as a cost function. The value calculated by the loss function is referred to as simply `loss`. The `loss` is designed with two crucial properties: 1. The less its value is, the better the model fits the given data. 2. It should be differentiable. 

A loss value can start at 1.2243 as in the example above and decrease down to < 1 as the model continues to train. 

#### Accuracy

`Accuracy` metric is only valid for classification tasks. `Accuracy` is not differentiable nor continuous so it cannot be directly used to optimize the model. It denotes what percent is correctly classified to its true values. Higher is better.   

#### val_loss & val_accuracy

The definitions are the same as `Loss` and `Accuracy`. The only difference is that these are applied to validation set.  

#### Early Stopping

Early stopping is a method that allows an arbitrary large number of training epochs and stops the training once the model performance stops improving on the validation dataset. 

Examples of Early stopping

```
earlystop = EarlyStopping(monitor = 'val_loss',mode = 'min',verbose=1, patience=5)

learning_rate_reduction = ReduceLROnPlateau(monitor='val_loss', 
                    patience=2, 
                    verbose=1, 
                    factor=0.5, 
                    min_lr=0.00001)

callbacks =  [earlystop, learning_rate_reduction]
``` 

`EarlyStopping` method is the keras implementation. In this example, it is monitoring `val_loss`. `mode` determines if the training will stop when the quantity monitored is increasing or decreasing. `patience` is the number of epochs that produced the monitored quantity with no improvement. 

`ReduceLROnPlateau` method reduces the Learning Rate (LR) when keras detects there is a slow down in metrics. In this example, the `min_lr` or minimum learning rate delta needs to be 0.00001. 

More arguments can be found in the [keras documentation on Early Stopping](https://keras.io/callbacks/)

<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="common-issues"></a>
## Common Issues

First steps:  

1. Check error message
    * Generally tells you what and where the exact issue is.
    * Use search engine for more specific error messages. 
2. Check variable names
    * Wrong variable names or path names to data will cause issues. 

Issues I have seen: 
 
1. Loss turns into NaN. 
    * Caused by model diverging invalid value
    * Possible solutions:
        1. Reduce learning rate.
        2. Check possibilities of division by zero.
        3. Check issue with input data.
    * [Reference](https://stackoverflow.com/questions/33962226/common-causes-of-nans-during-training)

TBD 
<p align="right">(<a href="#back-to-top">back to top</a>)</p>

<a name="additional-resources"></a>
## Additional Resources 

WIP

<p align="right">(<a href="#back-to-top">back to top</a>)</p>
