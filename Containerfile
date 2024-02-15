FROM docker.io/amd64/alpine AS bootstrap
ARG ARCH
ARG VERSION

RUN apk add tar gzip curl
COPY sha256sums.txt /
RUN chimera_archive_name=chimera-linux-$ARCH-ROOTFS-$VERSION-bootstrap.tar.gz && \
    curl https://repo.chimera-linux.org/live/$VERSION/$chimera_archive_name -O && \
    grep $chimera_archive_name sha256sums.txt | sha256sum -c && \
    mkdir /chimera && tar xf $chimera_archive_name -C /chimera

FROM scratch

COPY --from=bootstrap /chimera /
