ARG BASE_IMAGE=tgagor/base:alpine
FROM ${BASE_IMAGE}

ARG JAVA_VERSION=17
RUN apk add --no-cache \
        amazon-corretto-${JAVA_VERSION} && \
    java -version
