ARG BASE_IMAGE=alpine
FROM ${BASE_IMAGE} AS builder

RUN apk add --no-cache \
        bash \
        binutils

COPY jre-build.sh /usr/local/sbin/
RUN jre-build.sh --output /jre && \
    cd /jre && \
    env GZIP=-9 tar zcf legal.tar.gz legal && \
    rm -rf legal

FROM ${BASE_IMAGE}

RUN apk add --no-cache \
        java-common

ARG JAVA_VERSION=17
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-amazon-corretto-jre
COPY --from=builder /jre $JAVA_HOME

RUN ln -sf ${JAVA_HOME} /usr/lib/jvm/default-jvm && \
    java -version
