# Softether VPN Client

SoftEther VPN Client

[![Docker Build Status](https://img.shields.io/docker/build/sfoxdev/softether-client.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/automated/sfoxdev/softether-client.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/pulls/sfoxdev/softether-client.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/stars/sfoxdev/softether-client.svg?style=flat-square)]()

## Usage

### Run container

```
docker run -d --cap-add NET_ADMIN -p 443:443/tcp -p 992:992/tcp -p 1194:1194/udp -p 5555:5555/tcp --name vpn-client sfoxdev/softether-client
```

```
docker run -d --privileged --net host --device=/dev/net/tun --cap-add NET_ADMIN -p 443:443/tcp -p 992:992/tcp -p 1194:1194/udp -p 5555:5555/tcp --name vpn-client sfoxdev/softether-client
```
VPN Client configuration
```
docker exec -it vpn-client /bin/sh
# cd /usr/vpncmd
# ./vpncmd
vpncmd command - SoftEther VPN Command Line Management Utility
SoftEther VPN Command Line Management Utility (vpncmd command)
Version 4.22 Build 9634   (English)
Compiled 2016/11/27 14:33:59 by yagi at pc30
Copyright (c) SoftEther VPN Project. All Rights Reserved.

By using vpncmd program, the following can be achieved.

1. Management of VPN Server or VPN Bridge
2. Management of VPN Client
3. Use of VPN Tools (certificate creation and Network Traffic Speed Test Tool)

Select 1, 2 or 3: 2

Specify the host name or IP address of the computer that the destination VPN Client is operating on.
If nothing is input and Enter is pressed, connection will be made to localhost (this computer).
Hostname of IP Address of Destination:

Connected to VPN Client "localhost".

VPN Client>NicCreate myadapter

VPN Client>AccountCreate myconnection

AccountCreate command - Create New VPN Connection Setting
Destination VPN Server Host Name and Port Number: [host or IP]:443
Destination Virtual Hub Name: HUB
Connecting User Name: test
Used Virtual Network Adapter Name: myadapter
The command completed successfully.

VPN Client>AccountPasswordSet myconnection

AccountPasswordSet command - Set User Authentication Type of VPN Connection Setting to Password Authentication
Please enter the password. To cancel press the Ctrl+D key.
Password: ********
Confirm input: ********
Specify standard or radius: standard
The command completed successfully.

VPN Client>


```


```
docker run -d --privileged --net host -v /srv/vpnclient/config:/etc/client:Z -v /srv/vpnclient/logs:/var/log/vpnclient:Z --cap-add NET_ADMIN -p 443:443/tcp -p 992:992/tcp -p 1194:1194/udp -p 5555:5555/tcp --name vpn-client sfoxdev/softether-client
```
