FROM bitnami/kubectl:latest

#Installing primary requirments
USER root
RUN apt-get update -y && apt-get install bash -y

RUN mkdir scripts/

COPY ./script/getPorts.sh scripts/