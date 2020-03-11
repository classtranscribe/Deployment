FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -qq update

RUN apt-get install -y apache2-utils openssl libssl1.0.0