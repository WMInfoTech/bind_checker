FROM ubuntu:16.04

MAINTAINER Phil Fenstermacher

RUN apt-get update && apt-get install -y bind9utils
