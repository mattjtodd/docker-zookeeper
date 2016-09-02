#!/bin/sh

set -e

ZK_VERSION=${1:-3.4.8}

TAG="utuba/zookeeper:$ZK_VERSION"

docker build --build-arg VERSION=$ZK_VERSION -t $TAG .

printf "\e[32mOk, Login to private repo and push with\n\n\e[1;34mdocker push $TAG \e[0m \n"
