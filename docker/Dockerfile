# Validated with https://www.fromlatest.io/
FROM ubuntu:14.04
LABEL maintainer="hello@juanlu.space"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gcc \
  g++ \
  gfortran \
  libatlas-dev \
  libblas-dev \
  liblapack-dev \
&& rm -rf /var/lib/apt/lists/*

COPY install_pypy.sh /tmp
RUN /tmp/install_pypy.sh

ENV PATH="/opt/pypy/bin:${PATH}"
