# This script loads the training set and trains an EMM model.
# The model is saved to disk after training.

library(rEMM)
library(hash)

# load the data set
stopifnot(file.exists("../data/train.csv"))
all.visits <- read.table("../data/train.csv", quote="\"")

# train the model
emm <- EMM(data=all.visits)

# save the model
save(emm, file="../data/emm.RData")

# load page list
pages <- read.csv('../data/pages-ibm.csv')
page.list <- unlist(pages[1])
save(page.list, file="../data/page-list.RData")

# create page hash table
page.hash <- hash(keys=unlist(pages[1]), values=unlist(pages[2]))
save(page.hash, file="../data/page-hash.RData")

