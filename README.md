<!-- README.md is generated from README.Rmd. Please edit that file -->
mapcan
======

`mapcan` is an R package that provides convenient tools for plotting a variety of Canadian maps with the `ggplot2` package.

Tile grid map of Canadian federal electoral ridings
---------------------------------------------------

![](README-unnamed-chunk-3-1.png)

2015 Canadian federal election results
--------------------------------------

![](README-unnamed-chunk-5-1.png)

Provincial/territorial cartogram
--------------------------------

### Cartogram distorted by population

![](README-unnamed-chunk-6-1.png) \#\#\# Cartogram distorted by population (no territories)

``` r
ggplot(provinces_noterr_carto_df, aes(long, lat, group = group, fill = population)) +
  geom_polygon() +
  theme_light() +
  scale_fill_gradient(low = "wheat4", high = "wheat2") + 
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.text = element_blank(), 
        axis.title = element_blank(),
        legend.title = element_blank()) +
  coord_fixed()
```

![](README-unnamed-chunk-7-1.png)
