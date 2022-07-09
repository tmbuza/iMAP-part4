richness <- function(x) {
  sum(x > 0)
}

shannon <- function(x) {
  rabund <- x[x > 0]/sum(x)
  -sum(rabund * log(rabund))
}

simpson <- function(x) {
  n <- sum(x)
  1 - sum((x/n)^2)
}
