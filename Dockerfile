FROM rocker/geospatial:4.0.3@sha256:b0c88617be37cf6e8a17c46d67f768001eab80a066f6eda890dacf082a5ed1ee

RUN set -x && \
  apt-get update

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r --error --ncpus -1 --repos 'https://cran.microsoft.com/snapshot/2020-12-19' \
    parzer \
    xml2 && \
  installGithub.r \
    r-lib/revdepcheck && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
