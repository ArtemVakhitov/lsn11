FROM maven:3.9.9-eclipse-temurin-8-alpine

RUN apk update

RUN apk add git openssh-client docker

RUN addgroup root docker 