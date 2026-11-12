FROM mariadb:latest
ENV MYSQL_DATABASE=my_app_db
ENV MARIADB_ROOT_PASSWORD=my-secret-pw
COPY mariadb-entrypoint /mariadb-entrypoint
RUN mysql -u root -p'my-secret-pw' < /mariadb-entrypoint/dhcpdb_create.sql && \
    mysql -u root -p'my-secret-pw' < /mariadb-entrypoint/user-create.sql
EXPOSE 3306

FROM alpine:latest
EXPOSE 67/udp
EXPOSE 8080/tcp
RUN apk update && \
    apk add alpine-sdk git autoconf automake meson openssl openssl-dev boost-dev mariadb-dev log4cplus log4cplus-dev && \
    cd /tmp && \
    wget https://downloads.isc.org/isc/kea/3.0.4/kea-3.0.4.tar.xz && \
    tar -xvf kea-3.0.4.tar.xz && \
    cd kea-3.0.4 && \
    meson setup build -D mysql=enabled && \
    meson compile -C build && \
    meson install -C build && \
    cd / && \
    rm -rf /tmp/kea-3.0.4 && \
    rm -rf /var/cache/apk/*

COPY start-dhcp-server.sh /start-dhcp-server.sh

ENTRYPOINT ["/start-dhcp-server.sh"]
