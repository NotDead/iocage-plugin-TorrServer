#!/bin/sh

LOCATION=$(curl -s https://api.github.com/repos/YouROK/TorrServer/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/YouROK/TorrServer/releases/download/" substr($2, 2, length($2)-3) "/TorrServer-freebsd-amd64"}') \
; echo "$LOCATION" \
; curl -L -o /usr/local/lib/torr-server/TorrServer-freebsd-amd64 "$LOCATION"

chmod +x /usr/local/etc/rc.d/torr-server
chmod +x /usr/local/lib/torr-server/TorrServer-freebsd-amd64

export GODEBUG=madvdontneed=1

# Enable the service
sysrc -f /etc/rc.conf torr_server_enable="YES"

# Start the service
service torr-server start
