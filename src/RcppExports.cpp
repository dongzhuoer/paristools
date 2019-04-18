// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include "../inst/include/paristools.h"
#include <Rcpp.h>
#include <string>
#include <set>

using namespace Rcpp;

// test_parse_CIGAR
List test_parse_CIGAR(String chrom, unsigned flag, unsigned long pos, String CIGAR, unsigned long SEQ_len);
static SEXP _paristools_test_parse_CIGAR_try(SEXP chromSEXP, SEXP flagSEXP, SEXP posSEXP, SEXP CIGARSEXP, SEXP SEQ_lenSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< String >::type chrom(chromSEXP);
    Rcpp::traits::input_parameter< unsigned >::type flag(flagSEXP);
    Rcpp::traits::input_parameter< unsigned long >::type pos(posSEXP);
    Rcpp::traits::input_parameter< String >::type CIGAR(CIGARSEXP);
    Rcpp::traits::input_parameter< unsigned long >::type SEQ_len(SEQ_lenSEXP);
    rcpp_result_gen = Rcpp::wrap(test_parse_CIGAR(chrom, flag, pos, CIGAR, SEQ_len));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_test_parse_CIGAR(SEXP chromSEXP, SEXP flagSEXP, SEXP posSEXP, SEXP CIGARSEXP, SEXP SEQ_lenSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_test_parse_CIGAR_try(chromSEXP, flagSEXP, posSEXP, CIGARSEXP, SEQ_lenSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// sam_to_loc_df
List sam_to_loc_df(DataFrame sam);
static SEXP _paristools_sam_to_loc_df_try(SEXP samSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< DataFrame >::type sam(samSEXP);
    rcpp_result_gen = Rcpp::wrap(sam_to_loc_df(sam));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_sam_to_loc_df(SEXP samSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_sam_to_loc_df_try(samSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// get_strand
std::string get_strand(const unsigned flag);
static SEXP _paristools_get_strand_try(SEXP flagSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< const unsigned >::type flag(flagSEXP);
    rcpp_result_gen = Rcpp::wrap(get_strand(flag));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_get_strand(SEXP flagSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_get_strand_try(flagSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// test_as_loc_df
List test_as_loc_df();
static SEXP _paristools_test_as_loc_df_try() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    rcpp_result_gen = Rcpp::wrap(test_as_loc_df());
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_test_as_loc_df() {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_test_as_loc_df_try());
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// cal_coverage_impl
List cal_coverage_impl(DataFrame loc_df);
static SEXP _paristools_cal_coverage_impl_try(SEXP loc_dfSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< DataFrame >::type loc_df(loc_dfSEXP);
    rcpp_result_gen = Rcpp::wrap(cal_coverage_impl(loc_df));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_cal_coverage_impl(SEXP loc_dfSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_cal_coverage_impl_try(loc_dfSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// test2
List test2(const DataFrame& df);
static SEXP _paristools_test2_try(SEXP dfSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< const DataFrame& >::type df(dfSEXP);
    rcpp_result_gen = Rcpp::wrap(test2(df));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_test2(SEXP dfSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_test2_try(dfSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// cpp_version
int cpp_version();
static SEXP _paristools_cpp_version_try() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    rcpp_result_gen = Rcpp::wrap(cpp_version());
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _paristools_cpp_version() {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_paristools_cpp_version_try());
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}

// validate (ensure exported C++ functions exist before calling them)
static int _paristools_RcppExport_validate(const char* sig) { 
    static std::set<std::string> signatures;
    if (signatures.empty()) {
        signatures.insert("List(*test_parse_CIGAR)(String,unsigned,unsigned long,String,unsigned long)");
        signatures.insert("List(*sam_to_loc_df)(DataFrame)");
        signatures.insert("std::string(*get_strand)(const unsigned)");
        signatures.insert("List(*test_as_loc_df)()");
        signatures.insert("List(*cal_coverage_impl)(DataFrame)");
        signatures.insert("List(*test2)(const DataFrame&)");
        signatures.insert("int(*cpp_version)()");
    }
    return signatures.find(sig) != signatures.end();
}

// registerCCallable (register entry points for exported C++ functions)
RcppExport SEXP _paristools_RcppExport_registerCCallable() { 
    R_RegisterCCallable("paristools", "_paristools_test_parse_CIGAR", (DL_FUNC)_paristools_test_parse_CIGAR_try);
    R_RegisterCCallable("paristools", "_paristools_sam_to_loc_df", (DL_FUNC)_paristools_sam_to_loc_df_try);
    R_RegisterCCallable("paristools", "_paristools_get_strand", (DL_FUNC)_paristools_get_strand_try);
    R_RegisterCCallable("paristools", "_paristools_test_as_loc_df", (DL_FUNC)_paristools_test_as_loc_df_try);
    R_RegisterCCallable("paristools", "_paristools_cal_coverage_impl", (DL_FUNC)_paristools_cal_coverage_impl_try);
    R_RegisterCCallable("paristools", "_paristools_test2", (DL_FUNC)_paristools_test2_try);
    R_RegisterCCallable("paristools", "_paristools_cpp_version", (DL_FUNC)_paristools_cpp_version_try);
    R_RegisterCCallable("paristools", "_paristools_RcppExport_validate", (DL_FUNC)_paristools_RcppExport_validate);
    return R_NilValue;
}

static const R_CallMethodDef CallEntries[] = {
    {"_paristools_test_parse_CIGAR", (DL_FUNC) &_paristools_test_parse_CIGAR, 5},
    {"_paristools_sam_to_loc_df", (DL_FUNC) &_paristools_sam_to_loc_df, 1},
    {"_paristools_get_strand", (DL_FUNC) &_paristools_get_strand, 1},
    {"_paristools_test_as_loc_df", (DL_FUNC) &_paristools_test_as_loc_df, 0},
    {"_paristools_cal_coverage_impl", (DL_FUNC) &_paristools_cal_coverage_impl, 1},
    {"_paristools_test2", (DL_FUNC) &_paristools_test2, 1},
    {"_paristools_cpp_version", (DL_FUNC) &_paristools_cpp_version, 0},
    {"_paristools_RcppExport_registerCCallable", (DL_FUNC) &_paristools_RcppExport_registerCCallable, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_paristools(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
