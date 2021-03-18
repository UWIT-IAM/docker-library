#!/usr/bin/env bash
set -e

BUILD_DEPS=('curl' 'build-essential')
POETRY_INSTALL_URL=https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py

apt-get update
apt-get install --no-install-recommends -y ${BUILD_DEPS[@]}
curl -sSL  $POETRY_INSTALL_URL | python
apt-get remove -y ${BUILD_DEPS[@]}
apt-get -y clean
apt-get -y autoremove
