library(pacman)
p_load(tidyverse, devtools)


canada_squares <- read.csv("data-raw/canada_squares.csv")
canada_squares_provinces <- read.csv("data-raw/canada_squares_provinces.csv")

canada_squares_rows <- canada_squares
canada_squares_cols <- canada_squares

## This can surely be an apply statement
for(i in 1:nrow(canada_squares_rows)) {
  canada_squares_rows[i, ] <- seq(1, ncol(canada_squares_rows), 1)
}

for(i in 1:ncol(canada_squares_cols)) {
  canada_squares_cols[ , i] <- seq(1, nrow(canada_squares_cols), 1)
}

federal_riding_bins <- data.frame(district = gather(canada_squares)[,2],
                                province = gather(canada_squares_provinces)[,2],
                                y = gather(canada_squares_cols)[,2],
                                x = gather(canada_squares_rows)[,2]) %>%
  na.omit()

use_data(federal_riding_bins)

