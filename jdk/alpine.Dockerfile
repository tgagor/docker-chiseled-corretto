ARG BASE_IMAGE=alpine
FROM ${BASE_IMAGE}

# set default file encoding to UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# do not store cache or temp files in image
VOLUME ["/tmp",  "/var/cache/apk", "/var/tmp", "/root/.cache"]

# configure timezone
ARG TIMEZONE="UTC"
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo "$TIMEZONE" > /etc/timezone && \
    apk del tzdata && \
    date

# install dependencies/tools
# https://github.com/krallin/tini
RUN apk add --no-cache tini

ENTRYPOINT ["/sbin/tini", "--"]

# corretto part
# https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/generic-linux-install.html#alpine-linux-install-instruct
ARG JAVA_VERSION=17
RUN wget -O /etc/apk/keys/amazoncorretto.rsa.pub https://apk.corretto.aws/amazoncorretto.rsa.pub && \
    echo "https://apk.corretto.aws/" >> /etc/apk/repositories && \
    apk add --no-cache amazon-corretto-${JAVA_VERSION} && \
    java -version
