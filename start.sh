#!/bin/bash

curl $CONFIG_URL > /tmp/tilestache.cfg

sed -i -e "s/%MEMCACHE_PORT_11211_TCP_ADDR%/$MEMCACHE_PORT_11211_TCP_ADDR/g" /tmp/tilestache.cfg
sed -i -e "s/%MEMCACHE_PORT_11211_TCP_PORT%/$MEMCACHE_PORT_11211_TCP_PORT/g" /tmp/tilestache.cfg

sed -i -e "s/%SNW_MP_PORT_8080_TCP_ADDR%/$SNW_MP_PORT_8080_TCP_ADDR/g" /tmp/tilestache.cfg
sed -i -e "s/%SNW_MP_PORT_8080_TCP_PORT%/$SNW_MP_PORT_8080_TCP_PORT/g" /tmp/tilestache.cfg

cat /tmp/tilestache.cfg

gunicorn -k eventlet -w 4 -b :8080 "TileStache:WSGITileServer('/tmp/tilestache.cfg')"
