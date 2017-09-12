FROM alpine:3.6
MAINTAINER SFoxDev <admin@sfoxdev.com>

ENV LANG="en_US.UTF-8" \
    SOFTETHER_VERSION="v4.22-9634-beta"

ADD scripts/ /
RUN set -ex ; \
    addgroup -S softether ; adduser -D -H softether -g softether -G softether -s /sbin/nologin ; \
    apk add --no-cache --virtual .build-deps gcc make musl-dev ncurses-dev openssl-dev readline-dev wget ; \
    chmod +x /entrypoint.sh ; \

    wget --no-check-certificate -O - https://github.com/SoftEtherVPN/SoftEtherVPN/archive/${SOFTETHER_VERSION}.tar.gz | tar xzf - ; \
    cd SoftEtherVPN-${SOFTETHER_VERSION:1} ; \

    cp src/makefiles/linux_64bit.mak Makefile ; \
    make ; make install ; make clean ; \

    strip /usr/vpnclient/vpnclient ; \
    mkdir -p /etc/vpnclient /var/log/vpnclient; ln -s /etc/vpnclient/vpn_client.config /usr/vpnclient/vpn_client.config ; \

    apk del .build-deps ; \
    apk add --no-cache --virtual .run-deps libcap libcrypto1.0 libssl1.0 ncurses-libs readline su-exec ; \

    cd .. ; \
    rm -rf /usr/vpnbridge /usr/bin/vpnbridge /usr/bin/vpncmd /usr/vpnserver /usr/bin/vpnserver /usr/bin/vpnclient \
        /patchs SoftEtherVPN-${SOFTETHER_VERSION:1} ;

EXPOSE 443/tcp 992/tcp 1194/udp 5555/tcp

VOLUME ["/etc/vpnclient", "/var/log/vpnclient"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/vpnclient/vpnclient", "execsvc"]
