#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

## quiets concerns of R CMD check that no visible binding for global variable ‘riding_code’
if(getRversion() >= "2.15.1")  utils::globalVariables(c("riding_code"))
