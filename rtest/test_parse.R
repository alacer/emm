
test.parse <- function() {
  line <- "221.190.113.16 - - [26/Jan/2014:03:12:40 +0000] \"GET /index.php/blogs HTTP/1.1\" 200 36069"
  checkEquals("221.190.113.16", get.origin(line), msg="check origin is parsed correctly")
  checkEquals("200", get.code(line), msg="check status code is parsed correctly")
  checkEquals("/index.php/blogs", get.path(line), msg="check the path is parsed correctly")
  checkEquals("221.190.113.16", unlist(get.tuple(line))[1], msg="parse ip origin using get.tuple")
  checkEquals("/index.php/blogs", unlist(get.tuple(line))[2], msg="parse the path using get.tuple")
  
  line <- "126.214.102.105 - - [26/Jan/2014:08:18:32 +0000] \"GET /js/jquery-1.7.2.min.js HTTP/1.1\" 200 94843"
  checkEquals("filter me", unlist(get.tuple(line))[1], msg="filter out request for JS")
}

test.deactivation <- function()
{
  DEACTIVATED('Deactivating this test function')
}
