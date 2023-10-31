# Sampling using a package and my implementation
Rcpp::sourceCpp("src/bart5_class.cpp")
set.seed(45)
n <- 100
x <- replicate(n = n,expr = up_tn_sampler(lower = 0))
y <- msm::rtnorm(n, 0, 1, lower = 0)


par(mfrow = c(1,2))
hist(x, main = "my_sampler")
hist(y, main = "msm_sampler")
par(mfrow = c(1,1))

# stats my sampler
mean(x)
sd(x)

# stats 'msm'
mean(y)
sd(y)


# ====== Doing for the upper
x <- replicate(n = n,expr = lower_tn_sampler(upper = 0))
y <- msm::rtnorm(n, 0, 1, upper =  0)


par(mfrow = c(1,2))
hist(x, main = "my_sampler")
hist(y, main = "msm_sampler")
par(mfrow = c(1,1))

# stats my sampler
mean(x)
sd(x)

# stats 'msm'
mean(y)
sd(y)


