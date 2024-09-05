FROM ubuntu:22.04

RUN apt-get update

RUN apt-get -y install openssh-client git maven docker.io

RUN usermod -aG docker root
RUN chown root:docker /var/run/docker.sock
RUN chmod 660 /var/run/docker.sock

RUN apt-get clean