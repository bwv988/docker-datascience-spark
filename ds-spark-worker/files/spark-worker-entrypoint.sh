#!/bin/bash

source /entrypoints/inject_spark_cfg.sh

if [ -z "$SPARK_MASTER_URL" ]; then
  echo "Spark master URL not specified, exiting."
  exit 2
fi

$SPARK_HOME/sbin/start-slave.sh "$SPARK_MASTER_URL"
exec tail -f $SPARK_HOME/logs/*
