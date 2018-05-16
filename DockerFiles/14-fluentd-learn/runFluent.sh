#!/bin/bash

sudo docker run -it -p 24224:24224 -v $(pwd)/logs:/fluentd/log --network="fluent-test" fluentd-custom
