ARG BASE_IMAGE=tgagor/base:ubuntu
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
# ENV TERM xterm

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

VOLUME ["/tmp", "/var/tmp", "/var/cache/apt"]

RUN apt-get update && \
    apt-get install -y locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG

# install dependencies/tools
# https://github.com/krallin/tini
RUN apt-get update && \
    apt-get install -y tini

ENTRYPOINT ["/usr/bin/tini", "--"]

ARG JAVA_VERSION=17
RUN apt-get update && \
    apt-get install -y wget gpg && \
    wget -O - https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list && \
    apt-get install -y \
        ca-certificates-java \
        java-${JAVA_VERSION}-amazon-corretto-jdk && \
    ln -s /usr/lib/jvm/java-${JAVA_VERSION}-amazon-corretto /usr/lib/jvm/default-jvm && \
    apt-get purge -y wget gpg && \
    apt-get autoremove -y && \
    java -version
