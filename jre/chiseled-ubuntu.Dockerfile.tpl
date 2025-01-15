ARG USER=app
ARG UID=1001
ARG GROUP=app
ARG GID=1001
FROM {{ if .registry  }}{{ .registry }}/{{ end }}{{ if .prefix }}{{ .prefix }}/{{ end }}corretto:{{ .java }}-ubuntu{{ .ubuntu }}-jdk AS jre-builder

COPY jre-build.sh /usr/local/sbin/
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        ca-certificates-java \
        binutils && \
    chmod +x /usr/local/sbin/jre-build.sh && \
    jre-build.sh --output /jre && \
    cd /jre && \
    tar zcf legal.tar.gz legal && \
    rm -rf legal

FROM tgagor/chisel:{{ .ubuntu }} AS base-os
ARG USER
ARG UID
ARG GROUP
ARG GID

RUN mkdir -p /rootfs  && \
    chisel cut \
        # --release ubuntu-{{ .ubuntu }} \
        --root /rootfs \
        libc6_libs \
        libgcc-s1_libs \
        libstdc++6_libs \
        zlib1g_libs \
        libgraphite2-3_libs \
        libglib2.0-0t64_core \
        base-files_bin \
        base-files_chisel
RUN install -d -m 0755 -o $UID -g $GID /rootfs/home/$USER && \
    mkdir -p /rootfs/etc && \
    echo -e "root:x:0:\n$GROUP:x:$GID:" >/rootfs/etc/group && \
    echo -e "root:x:0:0:root:/root:/noshell\n$USER:x:$UID:$GID::/home/$USER:/noshell" >/rootfs/etc/passwd
RUN mkdir -p /rootfs/usr/lib/jvm/java-{{ .java }}-amazon-corretto-jre
COPY --from=jre-builder /jre /rootfs/usr/lib/jvm/java-{{ .java }}-amazon-corretto-jre

WORKDIR /rootfs
RUN ln -s --relative usr/lib/jvm/java-{{ .java }}-amazon-corretto-jre/bin/java usr/bin/

FROM scratch
ARG USER
ARG UID
ARG GROUP
ARG GID
USER $UID:$GID
ENV JAVA_HOME=/usr/lib/jvm/java-{{ .java }}-amazon-corretto-jre
COPY --from=base-os /rootfs /
# Workaround for https://github.com/moby/moby/issues/38710
COPY --from=base-os --chown=$UID:$GID /rootfs/home/$USER /home/$USER
ENTRYPOINT ["/usr/bin/java"]
