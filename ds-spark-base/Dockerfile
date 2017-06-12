# Base docker file for Apache Spark Data Science container.
# FIXME: Removed verification of download temporarily!
# FIXME: Should link hive-site.xml from Hive container, instead of copying it.
# FIXME: Reduce size of container.

FROM bwv988/hadoop-base

# Install Spark, R, etc...
ENV SPARK_VERSION 2.1.1
ENV HADOOP_VERSION 2.7
ENV SPARK_MIRROR http://www-eu.apache.org
ENV SPARK_DL ${SPARK_MIRROR}/dist/spark
ENV SPARK_DL_FILE ${SPARK_DL}/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION
ENV PATH $SPARK_HOME/bin:$PATH

COPY files/spark-entrypoint.sh files/inject_spark_cfg.sh files/runhistoryserver.sh /entrypoints/
COPY files/install.R /opt/inst.R


RUN set -ex \
    && curl --retry 3 -kfSL "$SPARK_DL_FILE" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz* \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} $SPARK_HOME \
    && apt-get update && apt-get install -y --no-install-recommends  \
      libssl-dev \
      libcurl4-openssl-dev \
      python-tk \
      python-numpy \
      python-scipy \
      python-matplotlib \
      python-pandas \
      python-sympy \
      python-nose \
      python-pip \
      python-dev \
      libpostgresql-jdbc-java \
      build-essential \
      git \
      r-base \
      r-base-dev \
      r-recommended \
     && pip install -U scikit-learn \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* \
     && R CMD BATCH /opt/inst.R /tmp/inst.R.out \
     && chmod a+x /entrypoints/spark-entrypoint.sh \
     && chmod a+x /entrypoints/runhistoryserver.sh \
     && echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> /opt/spark-$SPARK_VERSION/conf/spark-env.sh \
     && ln -s /usr/share/java/postgresql-jdbc4.jar /opt/spark-$SPARK_VERSION/jars/postgresql-jdbc4.jar

COPY files/hive-site.xml $SPARK_HOME/conf/hive-site.xml

WORKDIR /workdir

ENTRYPOINT ["/entrypoints/spark-entrypoint.sh"]

CMD ["/entrypoints/runhistoryserver.sh"]
