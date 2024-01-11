FROM ubuntu:22.04

COPY checkzones.sh /usr/local/bin/checkzones

RUN apt-get update \
    && apt-get install -y bind9utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
