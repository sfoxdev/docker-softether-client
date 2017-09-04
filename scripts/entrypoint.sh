#!/bin/sh
set -e

if [ "$1" = '/usr/vpnclient/vpnclient' ]; then

    # Linking Logs
    for d in server_log security_log packet_log;
    do
        if [ ! -L /usr/vpnclient/$d ]; then
          mkdir -p /var/log/vpnclient/$d
          ln -s /var/log/vpnclient/$d /usr/vpnclient/$d
        fi
    done

    chown -R softether:softether /usr/vpnclient
    setcap 'cap_net_bind_service=+ep' /usr/vpnclient/vpnclient

    echo "Starting SoftEther VPN Client"
    exec su-exec softether sh -c "`echo $@`"
else
    exec "$@"
fi
