#!/bin/sh

set -e

TAG="utuba/zookeeper:$ZK_VERSION"

for version in 3.4.8 3.5.0-alpha 3.5.1-alpha 3.5.2-alpha
do
  tag="utuba/zookeeper:$version"
  docker build --build-arg VERSION=$version -t $tag .
  docker push $tag 
done

