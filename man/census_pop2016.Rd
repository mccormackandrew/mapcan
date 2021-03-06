% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{census_pop2016}
\alias{census_pop2016}
\title{Census division population data for 2011 and 2016}
\format{A data.frame with 293 rows and 11 variables:
\describe{
  \item{census_division_code}{Uniquely identifies a census division (composed of the 2-digit
            province/territory unique identifier followed by the 2-digit
            census division code).}
  \item{census_division_name}{Census division name}
  \item{census_divison_type}{Census division type}
  \item{pr_sgc_code}{Province Standard Geographical Classification
                           (SGC) code.}
  \item{pr_english}{Province or territory name (English).}
  \item{population_2016}{2016 Population of Province}
  \item{population_density_2016}{Population density (individuals per square kilometer) in 2016}
  \item{land_area_2016}{Land area of census division}
  \item{population_2011}{2011 Population of Province}
  \item{pr_alpha}{Province or territory 2-letter identifier}
  \item{pr_french}{Province or territory name (French).}
  }}
\source{
\url{https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/comprehensive.cfm},
(under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
}
\usage{
census_pop2016
}
\description{
A data set with population data at the census level for 2011 and 2016
}
\keyword{datasets}
