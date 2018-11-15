#!/usr/bin/Rscript

args = commandArgs(trailingOnly=TRUE)

.inst_packages <- args[2:length(args)]

if(args[2] == "github_packages"){
  .github_package <- args[3:length(args)]
  .inst_packages <- unlist(lapply(sapply(.github_package, strsplit, "/"), '[[',2))
  .inst <- .inst_packages %in% installed.packages()
  if(any(!.inst)) {devtools::install_github(.github_package[!.inst])}
} else if(args[2] == "bioc_packages"){
  .inst <- .inst_packages %in% installed.packages()
  .inst_packages <- args[3:length(args)];.inst <- .inst_packages %in% installed.packages()
  if(any(!.inst)) {source("http://bioconductor.org/biocLite.R"); biocLite(.inst_packages[!.inst], ask = F)}
} else {
  .inst <- .inst_packages %in% installed.packages()
  if(any(!.inst)) {install.packages(.inst_packages[!.inst], lib=args[1], contriburl = contrib.url('http://cran.r-project.org/'))}
}

sapply(.inst_packages, require, character.only = TRUE)
