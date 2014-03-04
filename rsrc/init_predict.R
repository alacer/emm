# This is an initialization script. It assumes the existence of 
# three RData files: a trained emm model, a list of paths used
# in training, and a hash table of paths and their corresponding
# state ids. The list of paths is ordered in order of id (but
# it doesn't actually contain the ids).

# Make sure required libraries are installed and loaded.
#if (! ("rEMM" %in% rownames(installed.packages()))) {
#  install.packages("rEMM")
#} 
#if (! ("hash" %in% rownames(installed.packages()))) {
#  install.packages("hash")
#}

# Load required libraries
library(rEMM)
library(hash)

# Set the working directory
#setwd("~/streams/StreamsStudio/StreamsStudio/workspace/rproject/WSModel")

# Load the Model
stopifnot(file.exists("../data/emm.RData"))
load(file="../data/emm.RData")

# Load the pages hash table
stopifnot(file.exists("../data/page-hash.RData"))
load(file="../data/page-hash.RData")

# Load the pages list
stopifnot(file.exists("../data/page-list.RData"))
load(file="../data/page-list.RData")

