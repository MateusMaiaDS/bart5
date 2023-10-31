# Generating a simulation setting
rm(list=ls())
devtools::load_all()
library(mlbench)
n_ <- 250
sim_train <- as.data.frame(mlbench.circle(n = n_,d = 2))
sim_test <- as.data.frame(mlbench.circle(n = n_,d = 2))
sim_train$classes <- ifelse(sim_train$classes == 2, 1,0)
colnames(sim_train)[3] <- colnames(sim_test)[3] <- "y"
x_train <- sim_train[,names(sim_train)!="y"]
x_test <- sim_test[,names(sim_test)!="y"]
y <- sim_train$y

# Generating the bart model
bart_mod <- bart2(x_train = x_train,y = y,x_test = x_test,n_tree = 200,scale_bool = TRUE)

table(sim_test$y,bart_mod$y_hat_test_class)

dbarts_mod <- dbarts::bart(x.train = x_train,y.train = y,x.test = x_test)

plot(dbarts_mod$yhat.train %>% colMeans(), bart_mod$y_hat_train_probit_mean)
dbarts_mod_class <- ifelse(dbarts_mod$yhat.train %>% colMeans() > 0,1,0)
dbarts_mod_class_test <- ifelse(dbarts_mod$yhat.test %>% colMeans() > 0,1,0)

table(dbarts_mod_class,bart_mod$y_hat_class)
table(dbarts_mod_class,sim_train$y)
table(bart_mod$y_hat_class,sim_train$y)
table(dbarts_mod_class_test,sim_test$y)
