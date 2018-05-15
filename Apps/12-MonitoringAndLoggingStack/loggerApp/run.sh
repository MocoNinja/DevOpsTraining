#! /bin/bash
if [ -f ./logs/LOG.log ]; then
rm ./logs/LOG.log
fi
touch ./logs/LOG.log

sudo docker run -d -v $(pwd)/logs/LOG.log:/LOG.log logger-app
