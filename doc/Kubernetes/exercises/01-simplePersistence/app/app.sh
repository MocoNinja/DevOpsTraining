#!/bin/bash

FILE="/logs/log"

while [ "1" -lt "2" ]; do
    echo "HELLO" >>$FILE
    echo "IT IS $(date)" >>$FILE

    echo -e "THESE ARE MY IPs""\n""$(ifconfig | grep inet)" >>$FILE

    sleep 10
done
