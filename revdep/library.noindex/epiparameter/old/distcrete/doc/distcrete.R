## ----echo = FALSE, results = "hide"--------------------------------------
knitr::opts_chunk$set(
  error = FALSE,
  fig.width = 7,
  fig.height = 5)
set.seed(1)

## ------------------------------------------------------------------------
curve(dgamma(x, 3), 0, 10, n = 301)

## ------------------------------------------------------------------------
d0 <- distcrete::distcrete("gamma", 1, shape = 3, w = 0)
d1 <- distcrete::distcrete("gamma", 1, shape = 3, w = 0.5)
x <- 0:10
y0 <- d0$d(x)
y1 <- d1$d(x)

par(mar=c(4.1, 4.1, 0.5, 0.5))
col <- c("gold", "steelblue3")
r <- barplot(rbind(y0, y1), names.arg = 0:10, beside = TRUE,
             xlab = "x", ylab = "Probability mass", las = 1,
             col = col)
legend("topright", c("w = 0", "w = 0.5"), bty = "n", fill = col)

## ------------------------------------------------------------------------
sum(d0$d(0:100))
sum(d1$d(0:100))

## ----echo = FALSE--------------------------------------------------------
par(mar=c(4.1, 4.1, 0.5, 0.5))
curve(dgamma(x, 3), 0, 10, n = 301, col = NA,
      xlab = "x", ylab = "Probability density", las = 1)
at <- 0:10
cols <- colorRampPalette(c("navy", "dodgerblue2"))(length(at))
for (i in seq_along(at)[-1]) {
  xx <- seq(at[i - 1], at[i], length.out = 21)
  polygon(c(xx, rev(xx)),
          c(dgamma(xx, 3), rep(0, length(xx))), col = cols[i],
          border = "grey")
}
curve(dgamma(x, 3), 0, 10, n = 301, add = TRUE)

## ----echo = FALSE--------------------------------------------------------
par(mar=c(4.1, 4.1, 0.5, 0.5))
curve(dgamma(x, 3), 0, 10, n = 301, col = NA,
      xlab = "x", ylab = "Probability density", las = 1)
at <- c(0, 0:9 + 0.5, 10)
cols <- colorRampPalette(c("navy", "dodgerblue2"))(length(at))
for (i in seq_along(at)[-1]) {
  xx <- seq(at[i - 1], at[i], length.out = 21)
  polygon(c(xx, rev(xx)),
          c(dgamma(xx, 3), rep(0, length(xx))), col = cols[i],
          border = "grey")
}
curve(dgamma(x, 3), 0, 10, n = 301, add = TRUE)

## ------------------------------------------------------------------------
par(mar=c(4.1, 4.1, 0.5, 0.5))
curve(pgamma(x, 3), 0, 10, n = 301, col = NA,
      xlab = "x", ylab = "Cumulative probability", las = 1)
at <- 0:10
cols <- colorRampPalette(c("navy", "dodgerblue2"))(length(at))
for (i in seq_along(at)[-1]) {
  xx <- seq(at[i - 1], at[i], length.out = 21)
  polygon(c(xx, rev(xx)),
          c(pgamma(xx, 3), rep(0, length(xx))), col = cols[i],
          border = "grey")
}
curve(pgamma(x, 3), 0, 10, n = 301, add = TRUE)

