FROM rocker/geospatial:4.0.0

RUN set -x && \
  apt-get update

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r --error --repos 'http://mran.revolutionanalytics.com/snapshot/2020-05-15' \
    parzer \
    xml2 && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
