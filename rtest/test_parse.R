
test.parse <- function() {
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"GET /index.html HTTP/1.0\" 200 3542"
  checkEquals("204.249.225.59", get.origin(line))
  checkEquals("200", get.code(line))
  checkEquals("/index.html", get.path(line), msg="parse the path")
  checkEquals("204.249.225.59", unlist(get.tuple(line))[1], msg="parse ip origin using get.tuple")
  checkEquals("/index.html", unlist(get.tuple(line))[2], msg="parse the path using get.tuple")
  line <- "foo.foo - - [28/Aug/1995:00:00:34 -0400] \"GET /index.html HTTP/1.0\" 404 3542"
  checkEquals("filter me", unlist(get.tuple(line))[1], msg="parse line with invalid return code.")
  line <- "foo.foo - - [28/Aug/1995:00:00:34 -0400] \"GET /index.gif HTTP/1.0\" 200 3542"
  checkEquals("filter me", unlist(get.tuple(line))[1])
  line <- "foo.foo - - [28/Aug/1995:00:00:34 -0400] \"GET /index.pdf HTTP/1.0\" 200 3542"
  checkEquals("foo.foo", unlist(get.tuple(line))[1])
  line <- "foo.foo - - [28/Aug/1995:00:00:34 -0400] \"GET /index.ps HTTP/1.0\" 200 3542"
  checkEquals("foo.foo", unlist(get.tuple(line))[1])
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"GET /index.html \" 200 3542"
  checkEquals("204.249.225.59", unlist(get.tuple(line))[1])
  checkEquals("/index.html", unlist(get.tuple(line))[2])
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"GET /index.htm \" 200 3542"
  checkEquals("/index.htm", unlist(get.tuple(line))[2])
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"GET /index.html \" 200 3542"
  checkEquals("/index.html", unlist(get.tuple(line))[2])
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"GET /index.pdf \" 200 3542"
  checkEquals("/index.pdf", unlist(get.tuple(line))[2])
  line <- "204.249.225.59 - - [28/Aug/1995:00:00:34 -0400] \"Head / \" 200 3542"
  checkEquals("filter me", unlist(get.tuple(line))[1])
}

test.deactivation <- function()
{
  DEACTIVATED('Deactivating this test function')
}
