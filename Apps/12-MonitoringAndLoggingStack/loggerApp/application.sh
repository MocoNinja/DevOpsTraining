#! /bin/bash

if [ ! -f LOG.log ]; then
  touch LOG.log
fi

echo "HI" >> LOG.log
echo "I AM A LOGGER" >> LOG.log
sleep 5

i="0"

while [ $i -lt 1 ]; do
  echo "HOW IS IT GOING" >> LOG.log
  msg="I AM $(ifconfig | grep 'inet')"
  echo $msg >> LOG.log
  msg=$(date +%F--%T)
  echo "IT IS $msg" >> LOG.log
  sleep 10
done
