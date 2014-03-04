library('RUnit')

source('../rsrc/parse-functions.R')

test.suite <- defineTestSuite(name = "r-tests",
                              dirs = file.path("../rtest"),
                              testFileRegexp = '^test_\\w+\\.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
