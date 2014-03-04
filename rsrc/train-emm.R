# This script loads the training set and trains an EMM model.
# The model is saved to disk after training.

library(rEMM)

# load the data set
stopifnot(file.exists("train.csv"))
all.visits <- read.table("train.csv", quote="\"")

# train the model
emm <- EMM(data=all.visits)

# save the model
save(emm, file="emm.RData")