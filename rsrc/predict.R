# This script is expecting to receive one line from the web server log file
# It parses the line to retrieve the origin of the request and the requested
# path. It then looks up the id for the requested path and calls the predict
# method of the trained emm.
#
# inputs:  path -- The path of the last reqested item.
# outputs: prediction -- A list of the twenty most likely next paths to be 
#                        reqested.

# prediction must be initialized as a vector. Despite what the IBM
# documentation states, Streams does not appear to be fond of R lists.
prediction <- vector()
last.request <- page.hash[[path]]
if (! is.null(last.request)) {
  liklihoods <- predict(emm, current_state=last.request, 
                        probabilities=TRUE)
  top.twenty <- names(sort(x=liklihoods, decreasing=TRUE)[1:20])
  for (i in 1:20) {
    prediction[[i]] <- toString(page.list[as.numeric(top.twenty[i])])
  } 
}

