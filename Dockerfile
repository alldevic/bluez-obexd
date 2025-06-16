FROM debian:trixie-20250610-slim

RUN echo 'deb-src http://deb.debian.org/debian/ trixie main non-free-firmware non-free contrib' >> /etc/apt/sources.list


RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends --no-install-suggests --no-upgrade \
    build-essential

RUN apt-get build-dep -y bluez-obexd

WORKDIR /app/

COPY patches/ /app/patches

RUN apt-get source bluez-obexd=5.82 \
    && cd /app/bluez-5.82/ \
    && for i in /app/patches/*.patch; do patch -p1 < "$i"; done \
    && DEB_BUILD_OPTIONS=noautodbgsym dpkg-buildpackage -us -uc -B \
    && rm -rf /app/bluez-5.82/ \
    /app/bluez_5.82-1.1.debian.tar.xz \
    /app/bluez_5.82-1.1.dsc \
    /app/bluez_5.82.orig.tar.gz

ADD ./scripts/* .

CMD ["./make-out.sh"]
