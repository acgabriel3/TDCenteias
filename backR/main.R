
library(plumber)

api <- plumb("testePlumber.R")

api$run(port=8001)




