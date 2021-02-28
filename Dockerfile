FROM rocker/geospatial:4.0.3@sha256:7a7ee47c8df20c5a2c3a2ccb01d5ec502e8a5589b612d9287bd2a880efcb7617

RUN set -x && \
  apt-get update

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r --error --ncpus -1 --repos 'https://cran.microsoft.com/snapshot/2021-02-27' \
    parzer \
    xml2 && \
  installGithub.r \
    r-lib/revdepcheck \
    r-lib/urlchecker && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
