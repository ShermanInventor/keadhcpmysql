FROM tomcraftmc/log4cplus:latest
EXPOSE 67/udp
EXPOSE 8080/tcp
RUN apk update && \
    apk add procps alpine-sdk git autoconf automake openssl openssl-dev boost-dev libtool pkgconfig mariadb-dev
    cd /tmp && \
    wget https://downloads.isc.org/isc/kea/1.6.1/kea-1.6.1.tar.gz && \
    tar -xvf kea-1.6.1.tar.gz && \
    cd kea-1.6.1 && \
    autoreconf --install && \
    ./configure --with-mysql && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/* && \
    apk del alpine-sdk git autoconf automake pkgconfig && \
    rm -rf /var/cache/apk/*

COPY start-dhcp-server.sh /start-dhcp-server.sh

ENTRYPOINT ["/start-dhcp-server.sh"]
