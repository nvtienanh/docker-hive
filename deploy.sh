#!/bin/bash
set -e

if [ $# -eq 0 ]
    then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
    else
        BRANCH=$1
fi

if [ $BRANCH == "master" ]
then
    HIVE_VERSION="2.3.4"
    IMAGE_TAG="latest"
else
    HIVE_VERSION="$(echo $BRANCH | cut -d'-' -f1)"
    IMAGE_TAG=$BRANCH
fi

echo $BRANCH

deploy() {
    IMAGE_TAG=$1
    HIVE_VERSION=$2
    HADOOP_TAG=$3
    docker build \
     -t nvtienanh/hive:$IMAGE_TAG \
     --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
     --build-arg VCS_REF=`git rev-parse --short HEAD` \
     --build-arg HADOOP_TAG=$HADOOP_TAG \
     --build-arg HIVE_VERSION=$HIVE_VERSION .
    docker push nvtienanh/hive:$IMAGE_TAG
}


deploy $IMAGE_TAG $HIVE_VERSION 3.2.1-debian
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-base/CA79IP9AVi0mpSaTDfi9k4POrdQ=
