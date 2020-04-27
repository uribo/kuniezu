FROM rocker/geospatial:3.6.3

RUN set -x && \
  apt-get update

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r \
    parzer && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
