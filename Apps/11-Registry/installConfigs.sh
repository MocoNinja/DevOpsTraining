#! /bin/sh

BASE_DIR="/home/centos/docker/persistence"
CONF_DIR="./confs"

echo "Copying prometheus configuration..."
cp "$CONF_DIR/prometheus.yml" "$BASE_DIR/prometheus/"

echo "Copying elasticsearch configuration..."
cp "$CONF_DIR/elasticsearch.yml" "$BASE_DIR/elasticsearch/config/"
cp "$CONF_DIR/log4j2.properties" "$BASE_DIR/elasticsearch/config/"
