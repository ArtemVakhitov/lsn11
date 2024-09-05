FROM ubuntu:22.04

RUN apt-get update

RUN apt-get -y install openssh-client git maven docker.io wget

RUN usermod -aG docker root

RUN apt-get clean