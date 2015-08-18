#!/bin/bash
set -e

# inject WSRFLITEURL, because the container has no information about his global IP and DNS name
if [ -z "$WSRFLITEURL" ]; then
    echo >&2 'error: no wsrflite url given '
    echo >&2 '  Did you forget to add -e WSRFLITEURL=... ?'
    exit 1
fi
# enable to set port, when the docker bind port is not identical to the gateways bind port, unicore will not work
if [ -z "$GATEWAYPORT" ]
then
    echo >&2 'info: no gateway port given, will default to 8080 '
    echo >&2 '  configure it by using  -e GATEWAYPORT=... ?'
    GATEWAYPORT=8080
fi

# inject config and configure unicore
cd /opt/unicore
sed -i "s/hostname/${HOSTNAME}/g" configure.properties
sed -i "s/gwPort=8080/gwPort=${GATEWAYPORT}/g" configure.properties
python ./configure.py unicore
sed -i "s/WSRFLITEURL/${WSRFLITEURL}/g" registry/conf/wsrflite.xml unicorex/conf/wsrflite.xml 

# start unicore
./start.sh
sleep 2
tail  -f gateway/logs/gateway.log
