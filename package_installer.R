#!/usr/bin/Rscript

args = commandArgs(trailingOnly=TRUE)

.inst_packages <- args[2:length(args)]
.inst <- .inst_packages %in% installed.packages()

if(args[2] == "github_packages"){
	.inst_packages <- args[3:length(args)];.inst <- .inst_packages %in% installed.packages()
	if(any(!.inst)) {devtools::install_github(.inst_packages[!.inst])}
	#split after / to get package name to require
}
if(args[2] == "bioc_packages"){
	.inst_packages <- args[3:length(args)];.inst <- .inst_packages %in% installed.packages()
	if(any(!.inst)) {source("http://bioconductor.org/biocLite.R"); biocLite(.inst_packages[!.inst], ask = F)}
}

if(any(!.inst)) {install.packages(.inst_packages[!.inst], lib=args[1], contriburl = contrib.url('http://cran.r-project.org/'))}

sapply(.inst_packages, require, character.only = TRUE)
