
args = commandArgs(trailingOnly=TRUE)

.cran_packages <- c("rmarkdown", "devtools", "curl","dplyr","reshape2","tidyverse","magrittr","readr","stringr","data.table","svMisc","gtools","igraph","igraphdata","MCL","NetIndices","kernlab","smotefamily","pROC","FNN","ggplot2","gplots","RColorBrewer","vegetarian","vegan","knitr","rstudioapi","Rcpp","RMySQL","RSQLite","foreign","tidyr","lubridate","ggvis","rgl","htmlwidgets","leaflet","dygraphs","googleVis","car","mgcv","lme4","nlme","randomForest","multcomp","vcd","glmnet","survival","caret","shiny","maps","ggmap","zoo","xts","quantmod","parallel","XML","jsonlite","testthat","roxygen2")
.bioc_packages <- c("Biostrings","DESeq2","limma","pcaMethods","phyloseq","dada2","DECIPHER","phangorn")

.inst <- .cran_packages %in% installed.packages()
if(any(!.inst)) {install.packages(.cran_packages[!.inst], lib = args[1], contriburl = contrib.url('http://cran.r-project.org/'))};.inst <- .bioc_packages %in% installed.packages()

devtools::install_github("benjjneb/dada2")
devtools::install_github("joey711/phyloseq")

if(any(!.inst)) {source("http://bioconductor.org/biocLite.R"); biocLite(.bioc_packages[!.inst], ask = F)}

sapply(c(.cran_packages, .bioc_packages), require, character.only = TRUE)
