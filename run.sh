#!/usr/bin/env bash
export APP_NAME=emacs
export APP_TAG=centos_7.1.1503
docker run --rm -v $(docker-machine ssh default pwd):/pkgdir andrewrothstein/docker-$APP_NAME-builder:$APP_TAG
