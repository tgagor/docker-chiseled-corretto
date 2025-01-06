ARG BASE_IMAGE=tgagor/base:ubuntu
FROM ${BASE_IMAGE}

ARG JAVA_VERSION=17
RUN apt-get update && \
    apt-get install -y java-${JAVA_VERSION}-amazon-corretto-jdk && \
    ln -s /usr/lib/jvm/java-${JAVA_VERSION}-amazon-corretto /usr/lib/jvm/default-jvm && \
    java -version
