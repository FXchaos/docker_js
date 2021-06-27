ARG CENTOS_VERSION=8.3.2011
ARG NODEJS_VERSION=14.17.1

FROM centos:$CENTOS_VERSION

RUN dnf -y upgrade
RUN dnf -y install gcc-c++ make python3 wget 

WORKDIR /tmp/build

ARG NODEJS_VERSION
RUN wget -qO- "https://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION.tar.gz" \
    | tar -xzv --strip-components=1 --no-same-owner \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && node --version \
    && npm --version

CMD ["/usr/sbin/init"]
