# DL_CarConfiguration_Profitability
Training Neural Network models to predict combinations of vehicle configurations under/over a certain cut of point of the net margins car brand-name

Here we fit a NN model to categorize car configuration into different profitability

## Conclusions/Further_Wrok

After realizing the power of neural nets, I found necessary to have multiple cutoff points as means to know where a specific car can be located in terms of the price. when the list of individual codes are given, we would like to know the price of a vehicle. One can think in two options:

#### a) fit a neural network able to predict the price of a configuration, that means instead of having one cutoff point and have predictions over/under it, now we are going to have a continuos response from the network. 

in Response to a) With a quarter of a million data set, we can observe several patterns. One way to start this vizualization is by knowing that a lot of cars are going to have same configuration. most of the cars made out of the same exact configurations, have many other factors for which the price varies. If the network predicts a price of a configuration shared by a lot of cars, then price could be more accurate and certanty can be found. What about predicting a configuration with 4 or 5 cars where prices truly are very different, the network would be less accurate. Having 5135 unique configurations, where the first 41 configurations most populated span the 51% of the data set, trully represents a lot of uncertanty for a lot of configurations. 

#### b) Create models with different cutoff points so that the network predicts if a car configuration is in an interval. One can disect the net margin vaiable and categorize it into many intervals. The network then can predict and give percentages of the most likely intervals a configuration can fall into.

In Response to b) This will deffenitey have good accuracies as we increment number of layers on the network, making a more complex model. Having 108 unique codes, represents a challenge as one would like to know what combination of codes will make the company loose less money. Thus, in terms of further analysis this route could have represented a problem as the numbers of parameters will be easily over 5000, also one could not disect the statistcs of how the model is predicting each code; in terms of where are the codes beings missclassified and what other codes are attached to.

## Start of the Analysis

 Serious thought was put into this and after going back and forth thinking in the best process to analyze this data it was realized to take the following steps to create the full analysis displayed here: https://cargo.site/Templates

### 1) Individual Code Analysis: Start by fitting three neural network models with different cutoff points, test the model with test data set to point at the missclassifications corresponding the cutoff points for cars avobe/below 10k, 14k and 18k, & count the number of codes baing classified as correct/below correct/above incorrect/below correct/above --> This to compare three different tables, sort the codes by 1*)counts_on_testdata 2*)missclasification this to see codes that span most of the data & observe the ones are being missclasified; compare the different cutoff points with this to analyse individual codes with that are the most frequent in data set

### 2) Reduced Model: In looking for this common set of variables to fit a reduced model, the analysis tended to include the codes that span most of the data set. We considered codes that are evenly distributed in the higher and lower range of the cutoff points for individual models, and the codes for which their frequency is high. Also, the misclassification columns could be compared. Misclassification among intervals it’s a good way of comparison. It helps to identify the codes that are attached to configuration believed to have greater returns, when in reality have less. Having more certainty about the configurations that produce less than expected would lead to average savings. then, we fit a Multivarite Logistic model; compare to NN model 

### 3) Create a table to understand what the model is predicting for each of the cutoff points, thus three outputs of predictions being compared to true fraction of the data set and to average net margin for each category
