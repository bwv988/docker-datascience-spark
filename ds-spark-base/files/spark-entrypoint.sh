#!/bin/bash

hadoop fs -mkdir /spark-logs

source /entrypoints/inject_spark_cfg.sh

exec $@
