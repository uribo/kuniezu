% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_jpsegment.R
\docType{data}
\name{GeomJpSegment}
\alias{GeomJpSegment}
\alias{geom_jpsegment}
\title{Drawing a segment line segment that shows the boundary}
\usage{
geom_jpsegment(...)
}
\arguments{
\item{...}{other arguments passed on to \link[ggplot2:geom_segment]{geom_segment}.}
}
\value{
ggplot object and plot
}
\description{
Drawing a segment line segment that shows the boundary
}
\examples{
require("ggplot2")
require("sf")
move_jpn_rs(jgd2011_bbox) \%>\%
  ggplot() +
  geom_sf() +
  geom_jpsegment()
}
\seealso{
\link{move_jpn_rs}
}
\keyword{datasets}
