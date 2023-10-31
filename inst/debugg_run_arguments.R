# Generating a simulation setting
library(mlbench)
n_ <- 250
sim_train <- as.data.frame(mlbench.circle(n = n_,d = 2))
sim_train$classes <- ifelse(sim_train$classes == 2, 1,0)
colnames(sim_train)[3] <- "y"
x_train <- x_test <- sim_train[,names(sim_train)!="y"]
y <- sim_train$y

n_tree = 20
n_mcmc = 2000
n_burn = 500
alpha = 0.95
beta = 2
dif_order = 0
nIknots = 20
df = 3
sigquant = 0.9
kappa = 2
scale_bool = TRUE
# Hyperparam for tau_b and tau_b_0
nu = 2
delta = 1
a_delta = 0.0001
d_delta = 0.0001
df_tau_b = 3
prob_tau_b = 0.9
stump <- FALSE
numcut <- 100L
usequants <- FALSE
node_min_size <- 5
