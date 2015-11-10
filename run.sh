#!/usr/bin/env bash
export APP_NAME=emacs
export APP_VER=24.5
export APP_PLATFORM=x86_64
export APP_PKG_TYPE=rpm
export APP_TAG=centos_7.1.1503
export APP_PKG=$APP_NAME-$APP_VER-$APP_PLATFORM.$APP_PKG_TYPE
export DOCKER_MACHINE=default

rm -f $APP_PKG
docker-machine ssh $DOCKER_MACHINE -- rm -f $APP_PKG
docker run --rm \
       -v $(docker-machine ssh $DOCKER_MACHINE pwd):/pkgdir \
       andrewrothstein/docker-$APP_NAME-builder:$APP_TAG
docker-machine scp $DOCKER_MACHINE:$APP_PKG .
