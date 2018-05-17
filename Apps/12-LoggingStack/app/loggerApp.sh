#!/bin/bash

i=$((i+1))

while [ $i -lt 100 ]; do
echo "HELLO, FRIEND" 
i=$((i+1))
echo "I AM $(ifconfig | grep inet)"
echo "IT IS $(date)"
sleep 10
done
