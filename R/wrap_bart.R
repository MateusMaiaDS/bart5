## Bart
#' @useDynLib bart5
#' @importFrom Rcpp sourceCpp
#'
# A fucction to retrive the number which are the factor columns
base_dummyVars <- function(df) {
        num_cols <- sapply(df, is.numeric)
        factor_cols <- sapply(df, is.factor)

        return(list(continuousVars = names(df)[num_cols], facVars = names(df)[factor_cols]))
}

# Getting the BART wrapped function
#' @export
bart2 <- function(x_train,
                  y,
                  x_test,
                  n_tree = 2,
                  node_min_size = 5,
                  n_mcmc = 2000,
                  n_burn = 500,
                  alpha = 0.95,
                  beta = 2,
                  df = 3,
                  sigquant = 0.9,
                  kappa = 2,
                  scale_bool = TRUE,
                  stump = FALSE,
                  numcut = 100L, # Defining the grid of split rules
                  usequants = FALSE
                  ) {


     # Changing to a classification model
     if(length(unique(y))==2){
        class_model <- TRUE
     } else {
        class_model <- FALSE
     }

     if(class_model){
          if(!identical(sort(unique(y)),c(0,1))){
               stop(" Use the y as c(0,1) vector for the classification model.")
          }
     }

     # Verifying if x_train and x_test are matrices
     if(!is.data.frame(x_train) || !is.data.frame(x_test)){
          stop("Insert valid data.frame for both data and xnew.")
     }


     # Getting the valid
     dummy_x <- base_dummyVars(x_train)

     # Create a data.frame aux

     # Create a list
     if(length(dummy_x$facVars)!=0){
             for(i in 1:length(dummy_x$facVars)){
                     # See if the levels of the test and train matches
                     if(!all(levels(x_train[[dummy_x$facVars[i]]])==levels(x_test[[dummy_x$facVars[i]]]))){
                        levels(x_test[[dummy_x$facVars[[i]]]]) <- levels(x_train[[dummy_x$facVars[[i]]]])
                     }
                     df_aux <- data.frame( x = x_train[,dummy_x$facVars[i]],y)
                     formula_aux <- stats::aggregate(y~x,df_aux,mean)
                     formula_aux$y <- rank(formula_aux$y)
                     x_train[[dummy_x$facVars[i]]] <- as.numeric(factor(x_train[[dummy_x$facVars[[i]]]], labels = c(formula_aux$y)))-1

                     # Doing the same for the test set
                     x_test[[dummy_x$facVars[i]]] <- as.numeric(factor(x_test[[dummy_x$facVars[[i]]]], labels = c(formula_aux$y)))-1

             }
     }

     # Getting the train and test set
     x_train_scale <- as.matrix(x_train)
     x_test_scale <- as.matrix(x_test)

     # Scaling x
     x_min <- apply(as.matrix(x_train_scale),2,min)
     x_max <- apply(as.matrix(x_train_scale),2,max)

     # Storing the original
     x_train_original <- x_train
     x_test_original <- x_test


     # Normalising all the columns
     for(i in 1:ncol(x_train)){
             x_train_scale[,i] <- normalize_covariates_bart(y = x_train_scale[,i],a = x_min[i], b = x_max[i])
             x_test_scale[,i] <- normalize_covariates_bart(y = x_test_scale[,i],a = x_min[i], b = x_max[i])
     }



     # Creating the numcuts matrix of splitting rules
     xcut_m <- matrix(NA,nrow = numcut,ncol = ncol(x_train_scale))
     for(i in 1:ncol(x_train_scale)){

             if(nrow(x_train_scale)<numcut){
                        xcut_m[,i] <- sort(x_train_scale[,i])
             } else {
                        xcut_m[,i] <- seq(min(x_train_scale[,i]),
                                          max(x_train_scale[,i]),
                                          length.out = numcut+2)[-c(1,numcut+2)]
             }
     }


     # Scaling the y
     min_y <- min(y)
     max_y <- max(y)

     # Getting the min and max for each column
     min_x <- apply(x_train_scale,2,min)
     max_x <- apply(x_train_scale, 2, max)

     # Scaling "y"
     if(scale_bool){

        if(class_model){
                y_scale <- y
                tau_mu <- (n_tree*(kappa^2))/(9)

        } else {
                y_scale <- normalize_bart(y = y,a = min_y,b = max_y)
                tau_mu <- (4*n_tree*(kappa^2))
        }

     } else {
        y_scale <- y

        # Changing the prior to adapt the classifcation context
        if(class_model){
               tau_mu <- (n_tree*(kappa^2))/(9)
        } else {
               tau_mu <- (4*n_tree*(kappa^2))/((max_y-min_y)^2)
        }
     }

     # Getting the naive sigma value
     nsigma <- naive_sigma(x = x_train_scale,y = y_scale)

     # Calculating tau hyperparam
     a_tau <- df/2

     # Calculating lambda
     qchi <- stats::qchisq(p = 1-sigquant,df = df,lower.tail = 1,ncp = 0)
     lambda <- (nsigma*nsigma*qchi)/df
     d_tau <- (lambda*df)/2


     # Call the bart function
     if(class_model){
          tau_init <- 1
     } else {
          tau_init <- nsigma^(-2)
     }

     # Change the mu init
     mu_init <- 0.0

     # Creating the vector that stores all trees
     all_tree_post <- vector("list",length = round(n_mcmc-n_burn))



     # Generating the BART obj
     if(class_model){
          bart_obj <- cppbart_CLASS(x_train_scale,
                              y_scale,
                              x_test_scale,
                              xcut_m,
                              n_tree,
                              node_min_size,
                              n_mcmc,
                              n_burn,
                              tau_init,
                              mu_init,
                              tau_mu,
                              alpha,
                              beta,
                              a_tau,d_tau,
                              stump)
     } else {
          bart_obj <- cppbart(x_train_scale,
                              y_scale,
                              x_test_scale,
                              xcut_m,
                              n_tree,
                              node_min_size,
                              n_mcmc,
                              n_burn,
                              tau_init,
                              mu_init,
                              tau_mu,
                              alpha,
                              beta,
                              a_tau,d_tau,
                              stump)
     }


     if(class_model){
          y_hat_train_probit_post <- bart_obj[[1]]
          y_hat_test_probit_post <- bart_obj[[2]]
          y_hat_train_probit_mean <- apply(bart_obj[[1]],1,mean)
          y_hat_test_probit_mean <- apply(bart_obj[[2]],1,mean)
          y_hat_class <- ifelse(y_hat_train_probit_mean>0,1,0)
          y_hat_test_class <- ifelse(y_hat_test_probit_mean>0,1,0)

     } else {

          # For the regression model
          if(scale_bool){
               # Tidying up the posterior elements
               y_train_post <- unnormalize_bart(z = bart_obj[[1]],a = min_y,b = max_y)
               y_test_post <- unnormalize_bart(z = bart_obj[[2]],a = min_y,b = max_y)
               for(i in 1:round(n_mcmc-n_burn)){
                    all_tree_post[[i]] <-  unnormalize_bart(z = bart_obj[[4]][,,i],a = min_y,b = max_y)
               }
               tau_post <- bart_obj[[3]]/((max_y-min_y)^2)
               all_tau_post <- bart_obj[[7]]/((max_y-min_y)^2)
          } else {
               y_train_post <- bart_obj[[1]]
               y_test_post <- bart_obj[[2]]
               tau_post <- bart_obj[[3]]
               for(i in 1:round(n_mcmc-n_burn)){
                    all_tree_post[[i]] <-  bart_obj[[4]][,,i]
               }
               all_tau_post <- bart_obj[[7]]
          }
     }

     # Return the list object
     if(class_model){

          # Saving the objects into a list for the class model
          list_obj <- list(y_hat_probit_post = y_hat_train_probit_post,
                           y_hat_test_probit_post = y_hat_test_probit_post,
                           y_hat_train_probit_mean = y_hat_train_probit_mean,
                           y_hat_test_probit_mean = y_hat_test_probit_mean,
                           y_hat_class = y_hat_class,
                           y_hat_test_class = y_hat_test_class)
     } else {
          # Saving the objects into a list for the regression model
          list_obj <- list(y_hat = y_train_post,
               y_hat_test = y_test_post,
               tau_post = tau_post,
               all_tau_post = all_tau_post,
               all_tree_post = all_tree_post,
               prior = list(n_tree = n_tree,
                            alpha = alpha,
                            beta = beta,
                            tau_mu = tau_mu,
                            a_tau = a_tau,
                            d_tau = d_tau),
               mcmc = list(n_mcmc = n_mcmc,
                           n_burn = n_burn),
               data = list(x_train = x_train,
                           y = y,
                           x_test = x_test,
                           move_proposal = bart_obj[[5]],
                           move_acceptance = bart_obj[[6]]))
     }

     # Return the list with all objects and parameters
     return(list_obj)
}

