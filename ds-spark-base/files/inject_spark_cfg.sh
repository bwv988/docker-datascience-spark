#!/bin/bash

export SPARK_VERSION=2.0.2
export SPARK_HOME=/opt/spark-$SPARK_VERSION

# Look for SPARK config settings in the environment.
for c in `printenv | perl -sne 'print "$1 " if m/^SPARK_CONF_(.+?)=.*/'`; do
    name=`echo ${c} | perl -pe 's/___/-/g; s/__/_/g; s/_/./g'`
    var="SPARK_CONF_${c}"
    value=${!var}
    echo "Setting SPARK property $name=$value"
    echo $name $value >> $SPARK_HOME/conf/spark-defaults.conf
done
