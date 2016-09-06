#!/bin/bash

echo -e "Building Data Science Spark docker images..."

function build_img() {
  local prefix=$1
  local imgname=$2
  local img="${prefix}/${imgname}"

  echo -e "Building docker $img..."

  pushd $(pwd)
  cd $imgname
  docker build -t $img .
  popd
}

IMGPREFIX=bwv988

build_img $IMGPREFIX ds-spark-base
build_img $IMGPREFIX ds-spark-master
build_img $IMGPREFIX ds-spark-worker
