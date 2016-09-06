#!/bin/bash

source /entrypoints/inject_spark_cfg.sh

$SPARK_HOME/sbin/start-master.sh
exec tail -f $SPARK_HOME/logs/*
