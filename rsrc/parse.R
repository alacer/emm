# This script parses log entries transforming them into tuples
# It parses out the origin of the request and the requested path.
# 
# inputs:  log.entry -- A single line from a web server log.
# outputs: origin -- The origin of the request received by web 
#                    server.
#          path -- The path to the requested item.
#
# The origin will be set to "filter me" if:
#   -- The return code is not 200
#   -- The requested file is not HTML, PDF, or PS
#   -- The origin is determined to be a bot

tuple <- unlist(get.tuple(log.entry))
origin <- tuple[1]
path <- tuple[2]





