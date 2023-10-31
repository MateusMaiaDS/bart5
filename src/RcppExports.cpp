// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// cppbart
Rcpp::List cppbart(arma::mat x_train, arma::vec y_train, arma::mat x_test, arma::mat x_cut, int n_tree, int node_min_size, int n_mcmc, int n_burn, double tau, double mu, double tau_mu, double alpha, double beta, double a_tau, double d_tau, bool stump);
RcppExport SEXP _bart5_cppbart(SEXP x_trainSEXP, SEXP y_trainSEXP, SEXP x_testSEXP, SEXP x_cutSEXP, SEXP n_treeSEXP, SEXP node_min_sizeSEXP, SEXP n_mcmcSEXP, SEXP n_burnSEXP, SEXP tauSEXP, SEXP muSEXP, SEXP tau_muSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP a_tauSEXP, SEXP d_tauSEXP, SEXP stumpSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::mat >::type x_train(x_trainSEXP);
    Rcpp::traits::input_parameter< arma::vec >::type y_train(y_trainSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type x_test(x_testSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type x_cut(x_cutSEXP);
    Rcpp::traits::input_parameter< int >::type n_tree(n_treeSEXP);
    Rcpp::traits::input_parameter< int >::type node_min_size(node_min_sizeSEXP);
    Rcpp::traits::input_parameter< int >::type n_mcmc(n_mcmcSEXP);
    Rcpp::traits::input_parameter< int >::type n_burn(n_burnSEXP);
    Rcpp::traits::input_parameter< double >::type tau(tauSEXP);
    Rcpp::traits::input_parameter< double >::type mu(muSEXP);
    Rcpp::traits::input_parameter< double >::type tau_mu(tau_muSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< double >::type a_tau(a_tauSEXP);
    Rcpp::traits::input_parameter< double >::type d_tau(d_tauSEXP);
    Rcpp::traits::input_parameter< bool >::type stump(stumpSEXP);
    rcpp_result_gen = Rcpp::wrap(cppbart(x_train, y_train, x_test, x_cut, n_tree, node_min_size, n_mcmc, n_burn, tau, mu, tau_mu, alpha, beta, a_tau, d_tau, stump));
    return rcpp_result_gen;
END_RCPP
}
// up_tn_sampler
double up_tn_sampler(double mean_, double lower);
RcppExport SEXP _bart5_up_tn_sampler(SEXP mean_SEXP, SEXP lowerSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type mean_(mean_SEXP);
    Rcpp::traits::input_parameter< double >::type lower(lowerSEXP);
    rcpp_result_gen = Rcpp::wrap(up_tn_sampler(mean_, lower));
    return rcpp_result_gen;
END_RCPP
}
// lw_tn_sampler
double lw_tn_sampler(double mean_, double upper);
RcppExport SEXP _bart5_lw_tn_sampler(SEXP mean_SEXP, SEXP upperSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type mean_(mean_SEXP);
    Rcpp::traits::input_parameter< double >::type upper(upperSEXP);
    rcpp_result_gen = Rcpp::wrap(lw_tn_sampler(mean_, upper));
    return rcpp_result_gen;
END_RCPP
}
// cppbart_CLASS
Rcpp::List cppbart_CLASS(arma::mat x_train, arma::vec y_train, arma::mat x_test, arma::mat x_cut, int n_tree, int node_min_size, int n_mcmc, int n_burn, double tau, double mu, double tau_mu, double alpha, double beta, double a_tau, double d_tau, bool stump);
RcppExport SEXP _bart5_cppbart_CLASS(SEXP x_trainSEXP, SEXP y_trainSEXP, SEXP x_testSEXP, SEXP x_cutSEXP, SEXP n_treeSEXP, SEXP node_min_sizeSEXP, SEXP n_mcmcSEXP, SEXP n_burnSEXP, SEXP tauSEXP, SEXP muSEXP, SEXP tau_muSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP a_tauSEXP, SEXP d_tauSEXP, SEXP stumpSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::mat >::type x_train(x_trainSEXP);
    Rcpp::traits::input_parameter< arma::vec >::type y_train(y_trainSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type x_test(x_testSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type x_cut(x_cutSEXP);
    Rcpp::traits::input_parameter< int >::type n_tree(n_treeSEXP);
    Rcpp::traits::input_parameter< int >::type node_min_size(node_min_sizeSEXP);
    Rcpp::traits::input_parameter< int >::type n_mcmc(n_mcmcSEXP);
    Rcpp::traits::input_parameter< int >::type n_burn(n_burnSEXP);
    Rcpp::traits::input_parameter< double >::type tau(tauSEXP);
    Rcpp::traits::input_parameter< double >::type mu(muSEXP);
    Rcpp::traits::input_parameter< double >::type tau_mu(tau_muSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< double >::type a_tau(a_tauSEXP);
    Rcpp::traits::input_parameter< double >::type d_tau(d_tauSEXP);
    Rcpp::traits::input_parameter< bool >::type stump(stumpSEXP);
    rcpp_result_gen = Rcpp::wrap(cppbart_CLASS(x_train, y_train, x_test, x_cut, n_tree, node_min_size, n_mcmc, n_burn, tau, mu, tau_mu, alpha, beta, a_tau, d_tau, stump));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_bart5_cppbart", (DL_FUNC) &_bart5_cppbart, 16},
    {"_bart5_up_tn_sampler", (DL_FUNC) &_bart5_up_tn_sampler, 2},
    {"_bart5_lw_tn_sampler", (DL_FUNC) &_bart5_lw_tn_sampler, 2},
    {"_bart5_cppbart_CLASS", (DL_FUNC) &_bart5_cppbart_CLASS, 16},
    {NULL, NULL, 0}
};

RcppExport void R_init_bart5(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
