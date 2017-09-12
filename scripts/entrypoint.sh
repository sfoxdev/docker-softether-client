#!/bin/sh
set -e

if [ "$1" = '/usr/vpnclient/vpnclient' ]; then

    if [ ! -L /usr/vpnclient/client_log ]; then
      mkdir -p /var/log/vpnclient/client_log
      ln -s /var/log/vpnclient/client_log /usr/vpnclient/client_log
    fi

    chown -R softether:softether /usr/vpnclient
    setcap 'cap_net_bind_service=+ep' /usr/vpnclient/vpnclient

    echo "Starting SoftEther VPN Client"
    exec su-exec softether sh -c "`echo $@`"
else
    exec "$@"
fi
