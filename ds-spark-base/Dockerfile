# Base docker file for Apache Spark Data Science container.
# FIXME: Removed verification of download temporarily!
# FIXME: Hard-coded Irish Apache mirror, but should use cloud-based one.
# FIXME: Should link hive-site.xml from Hive container, instead of copying it.

FROM analytics/hadoop-base

# Install Spark.
ENV SPARK_VERSION 2.0.0
ENV HADOOP_VERSION 2.7
ENV SPARK_DL_MIRROR=http://ftp.heanet.ie/mirrors/www.apache.org
ENV SPARK_DL_FILE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV SPARK_URL $SPARK_DL_MIRROR/dist/spark/spark-${SPARK_VERSION}/${SPARK_DL_FILE}.tgz
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION
ENV PATH $SPARK_HOME/bin:$PATH
RUN set -ex \
    && curl -kfSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz* \
    && mv /opt/$SPARK_DL_FILE $SPARK_HOME

# Install R, Pandas, SciPy, NumPy...
RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends  \
      libssl-dev \
      libcurl4-openssl-dev \
      python-numpy \
      python-scipy \
      python-matplotlib \
      python-pandas \
      python-sympy \
      python-nose \
      r-base \
      r-base-dev \
      r-recommended \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

COPY files/install.R /opt/inst.R
COPY files/spark-entrypoint.sh /entrypoints/spark-entrypoint.sh
COPY files/inject_spark_cfg.sh /entrypoints/inject_spark_cfg.sh
COPY files/runhistoryserver.sh /entrypoints/runhistoryserver.sh
COPY files/hive-site.xml $SPARK_HOME/conf/hive-site.xml

RUN set -ex \
  && R CMD BATCH /opt/inst.R /tmp/inst.R.out \
  && chmod a+x /entrypoints/spark-entrypoint.sh \
  && chmod a+x /entrypoints/runhistoryserver.sh \
  && echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> /opt/spark-$SPARK_VERSION/conf/spark-env.sh \
  && ln -s /usr/share/java/postgresql-jdbc4.jar /opt/spark-$SPARK_VERSION/jars/postgresql-jdbc4.jar

WORKDIR /workdir

ENTRYPOINT ["/entrypoints/spark-entrypoint.sh"]

CMD ["/entrypoints/runhistoryserver.sh"]
