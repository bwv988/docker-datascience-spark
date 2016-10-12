#!/bin/bash

# Configure Hadoop cluster settings.
source /entrypoints/inject_hadoop_cfg.sh
source /entrypoints/inject_spark_cfg.sh

# Create Spark logs directory in HDFS.
hadoop fs -mkdir /spark-logs

exec $@
