FROM ubuntu:16.04

ENV libgtextutils_version 0.7
ENV fastx_version 0.0.14

RUN apt-get update \
  && apt-get install --yes gcc g++ pkg-config wget \
  && wget https://github.com/agordon/libgtextutils/releases/download/${libgtextutils_version}/libgtextutils-${libgtextutils_version}.tar.gz \
  && tar -xzf libgtextutils-${libgtextutils_version}.tar.gz \
  && cd libgtextutils-${libgtextutils_version} \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && wget https://github.com/agordon/fastx_toolkit/releases/download/${fastx_version}/fastx_toolkit-${fastx_version}.tar.bz2 \
  && tar -xjf fastx_toolkit-${fastx_version}.tar.bz2 \
  && cd fastx_toolkit-${fastx_version} \
  && ./configure \
  && make \
  && make install \
  && cd ..

LABEL maintainer "christina.herrmann@unibas.ch"
