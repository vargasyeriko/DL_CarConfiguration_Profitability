library(keras);library(tensorflow)
library(tidyverse);library(reticulate);library(reshape)

#*************************Fitting a Deep Learning Model***************************************
#Training Process

#define entries as data.X and data.Y is the diacotomous if NM > 18000
data.X <- train_GC[ -c(1:40,149:150) ]
data.Y <- train_GC[-c(1:148)]

#Make both data frames to numeric matrices
x_data = data.matrix(data.X,  rownames.force = NA)
y_data = data.matrix(data.Y, rownames.force = NA)

head(x_data)
head(y_data)

#when you do the next one, two columns; 1st represents ydata =0 and 2nd represents ydata=1. 
#if order of new matrix is "0" "1" = ydata = 1, & "1" "0" = ydata = 0.'

#+++++++++++++++++++++++++
#use_condaenv(py36,conda="/Users/yerikovargas/anaconda3/envs/py36",required = FALSE)
#use_condaenv(condaenv = "py36", conda = "/Users/yerikovargas/anaconda3/envs/py36")
#+++++++++++++++++++++++++'

y_data_oneh=to_categorical(y_data, num_classes =2)
head(y_data_oneh)

#Define model Architecture
model = keras_model_sequential() %>%   
  layer_dense(units = 24, activation = "relu", input_shape = ncol(x_data)) %>%
  layer_dropout(0.1) %>%
  layer_dense(units = ncol(y_data_oneh), activation = "sigmoid")

#Define model Learning process
#Now it's time to define the loss and optimizer functions, and the metric to optimize.
#sgd= optimizer_sgd(lr=0.09  )
compile(model, loss = "binary_crossentropy", optimizer = optimizer_adam(lr=.001,), 
        metrics = "binary_accuracy")

#Initialize learning processs specify number of iterations, batch size etc. 
history = fit(model,  x_data, y_data_oneh, epochs = 10, batch_size = 64, validation_split = 0.2)

#plot the metrics by epoch
plot(history)

#Validating with unseen data, took it from another random sample defined as test_GC
x_test <- test_GC[ -c(1:40,149:150) ]
x_data_test = data.matrix(x_test,  rownames.force = NA)
head(x_data_test)
dim(x_data_test)

#predict using those entrances form test_GC, function to predict classes
y_data_pred=predict_classes(model, x_data_test)
glimpse(y_data_pred)

#Please note that the dimension is 3000 rows and 2 columns. 
#predict_classes automatically does the one-hot decoding. thus...
y_data_pred_oneh=predict(model, x_data_test)
dim(y_data_pred_oneh)
head(y_data_pred_oneh)

#Evaluating the model (Training vs. Test)
#Creating the "real" y target to compare against the predicted:
y_test <- test_GC[-c(1:148)]
head(y_test)

y_data_real = data.matrix(y_test,  rownames.force = NA)
y_data_real_oneh=to_categorical(y_data_real)
head(y_data_real_oneh)

#Accuracy based on data set that was trained with
evaluate(model, x_data, y_data_oneh, verbose = 0)

#Accuracy based on 25% of the data, sat approx 25 000 cars for evaluating accuracy & loss
evaluate(model, x_data_test, y_data_real_oneh, verbose = 0)



########################end---------------------------------------**********************************
########################end---------------------------------------**********************************


