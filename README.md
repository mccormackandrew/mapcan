<!-- README.md is generated from README.Rmd. Please edit that file -->
mapcan
======

`mapcan` is an R package that provides convenient tools for plotting Canadian choropleth maps and choropleth alternatives.

Installing mapcan
-----------------

`library(devtools)`

`install_github("mccormackandrew/mapcan", build_vignettes = TRUE)`

I suggest that you pass the `build_vignettes = TRUE` to `install_github()`. The vignettes provide detailed guides on how `mapcan`'s functions operate.

Using mapcan
============

`mapcan` data are best utilized with `ggplot2`

``` r
library(mapcan)
library(tidyverse)
```

Tile grid map of Canadian federal electoral ridings
---------------------------------------------------

`riding_binplot()` can be used to create tile cartograms at federal and provincial riding levels (note that only Quebec provincial ridings are supported right now). Here is an example:

![](README-unnamed-chunk-3-1.png)

Perhaps you are averse to squares. That is ok. Try hexagons instead:

``` r
riding_binplot(riding_data = fed2015,
               # Use the party (winning party) varibale from fed2015
               value_col = party, 
               # Arrange by value_col within provinces
               arrange = TRUE,
               # party is a categorical variable
               continuous = FALSE,
               shape = "hexagon") +
  # Change the colours to match the parties' colours
  scale_fill_manual(name = "Party",
                    values = c("mediumturquoise", "blue", "springgreen3", "red", "orange")) +
  # mapcan ggplot theme removes axis labels, background grid, and other unnecessary elements when plotting maps
  theme_mapcan() +
  ggtitle("Hex tile map of 2015 federal election results")
```

![](README-unnamed-chunk-4-1.png)

Perhaps you are interested in provincial election results, not federal election results. That is also ok. Try plotting the Quebec 2018 provincial election results:

``` r
# Load data that will be plotted with riding_binplot 
riding_binplot(quebec_provincial_results,
               value_col = party,
               riding_col = riding_code, 
               continuous = FALSE, 
               provincial = TRUE,
               province = QC,
               shape = "hexagon") +
  theme_mapcan() +
  scale_fill_manual(name = "Winning party", 
                    values = c("deepskyblue1", "red","royalblue4",  "orange")) +
  ggtitle("Hex tile map of 2018 provincial election results")
```

![](README-unnamed-chunk-5-1.png)

Standard choropleth maps
------------------------

The `mapcan()` returns geographic coordinate data frames at census division, federal riding, and provincial levels.

![](README-unnamed-chunk-7-1.png)

Not interested in the territories? No problem.

![](README-unnamed-chunk-8-1.png)

Population cartograms
---------------------

`mapcan()` can also be used to plot population cartograms. Based on the geographic distribution of Canadians (most Canadians live near the US border and very few live in the north), these maps are highly distorted.

``` r
# Get census population data to use with geographic data
censuspop <- mapcan::census_pop2016

census_cartogram_data <- mapcan(boundaries = census,
       type = cartogram)

census_cartogram_data <- left_join(census_cartogram_data, censuspop)

ggplot(census_cartogram_data, aes(long, lat, group = group, fill = population_2016)) +
  geom_polygon() +
  scale_fill_viridis_c() +
  theme_mapcan() +
  coord_fixed() +
  ggtitle("Population cartogram of census division populations")
```

![](README-unnamed-chunk-9-1.png)

Shading the census divisions by population size shows how the cartogram inflates divisions with larger populations (i.e. Vancouver, Edmonton, Calgary, Toronto, and Montreal all become larger).
