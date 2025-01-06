FROM {{ if .registry  }}{{ .registry }}/{{ end }}{{ if .prefix }}{{ .prefix }}/{{ end }}jdk:{{ .java }}-ubuntu{{ .ubuntu }} AS builder

COPY jre-build.sh /usr/local/sbin/
RUN apt-get update && \
    apt-get install -y binutils && \
    chmod +x /usr/local/sbin/jre-build.sh && \
    jre-build.sh --output /jre && \
    cd /jre && \
    env GZIP=-9 tar zcvf legal.tar.gz legal && \
    rm -rf legal

FROM {{ if .registry  }}{{ .registry }}/{{ end }}{{ if .prefix }}{{ .prefix }}/{{ end }}base:ubuntu{{ .ubuntu }}

RUN apt-get update && \
    apt-get install -y \
        java-common

ENV JAVA_HOME=/usr/lib/jvm/java-{{ .java }}-amazon-corretto-jre
RUN mkdir -p ${JAVA_HOME}
COPY --from=builder /jre $JAVA_HOME

RUN ls -la ${JAVA_HOME} && \
    ln -sf ${JAVA_HOME} /usr/lib/jvm/default-jvm && \
    ln -sf ${JAVA_HOME}/bin/java /usr/local/bin/java && \
    java -version
