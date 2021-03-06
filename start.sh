#!/bin/bash

curl $CONFIG_URL > tilestache.zip

if [ ! -e tilestache.zip ]; then
    exit 1
fi

unzip tilestache.zip -d /tmp/tilestache


sed -i -e "s/%MEMCACHE_PORT_11211_TCP_ADDR%/$MEMCACHE_PORT_11211_TCP_ADDR/g" /tmp/tilestache/tilestache-cfg.json
sed -i -e "s/%MEMCACHE_PORT_11211_TCP_PORT%/$MEMCACHE_PORT_11211_TCP_PORT/g" /tmp/tilestache/tilestache-cfg.json

sed -i -e "s/%SNW_MP_PORT_8080_TCP_ADDR%/$SNW_MP_PORT_8080_TCP_ADDR/g" /tmp/tilestache/tilestache-cfg.json
sed -i -e "s/%SNW_MP_PORT_8080_TCP_PORT%/$SNW_MP_PORT_8080_TCP_PORT/g" /tmp/tilestache/tilestache-cfg.json

cat /tmp/tilestache/tilestache-cfg.json

gunicorn -k eventlet -w 4 -b :8080 "TileStache:WSGITileServer('/tmp/tilestache/tilestache-cfg.json')"
