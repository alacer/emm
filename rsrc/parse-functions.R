# This script contains functions used to parse a line from
# a web server log.

if (file.exists("../data/bot-list.RData")) {
  load("../data/bot-list.RData")  
} else {
  bot.list <- c("")
}

origin.pattern <- "^\\S+(\\.\\S+)*\\.\\S+"
path.pattern <- "\"GET\\s+([/\\w\\.-]*)+/?\\s+HTTP"

get.code <- function(log.entry) {
  # Returns the return code of a web server log entry.
  tokens = unlist(strsplit(x=log.entry, split="\\s+", perl=TRUE))
  code = tokens[length(tokens)-1]
  
  return(code)
}

get.path <- function(log.entry) {
  # Returns the path of the requested resource of a web server log entry.
  path <- regmatches(x=log.entry, m=regexpr(pattern=path.pattern, 
                                            text=log.entry, 
                                            perl=TRUE))
  path <- unlist(strsplit(x=path, split="\\s+", perl=TRUE))[2]
  
  return(path)
}

get.origin <- function(log.entry) {
  # Returns the originating ip or domain from a web server log entry.
  return(regmatches(x=log.entry, m=regexpr(pattern=origin.pattern, 
                                           text=log.entry, 
                                           perl=TRUE)))
}

get.tuple <- function(log.entry) {
  # Returns a two-item list containing the modified origin of the 
  # request and the path to the requested item.
  # The origin will be set to "filter me" if:
  #   -- The return code is not 200
  #   -- The requested file is not HTML, PDF, or PS
  #   -- The origin is determined to be a bot
  origin <- get.origin(log.entry)
  path <- get.path(log.entry)
  code <- get.code(log.entry)
  
  if (code != "200") {
    origin <- "filter me"
  } else if(is.null(path)) {
    origin <- "filter me"
  } else if(path == FALSE) {
    origin <- "filter me"
  } else if (grepl(pattern="\\S+\\.\\w+$", x=path, perl=TRUE)) {
    origin <- "filter me"
  } else if (origin %in% bot.list) {
    origin <- "filter me"
  }

  return(list(origin, path))
}

