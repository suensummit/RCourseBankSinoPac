data <- list()
N <- 100000

for (n in 1:N) {
  data[[n]] = data.frame(index = n, char = sample(letters, 1), z = runif(1))
  }

data[[1]]

head(do.call(rbind, data))

library(plyr)
head(ldply(data, rbind))
head(rbind.fill(data))

library(data.table)
head(rbindlist(data))

library(rbenchmark)
benchmark(do.call(rbind, data), ldply(data, rbind), rbind.fill(data), rbindlist(data))
