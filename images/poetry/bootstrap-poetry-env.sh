#!/usr/bin/env bash
set -e

BUILD_DEPS=('curl' 'build-essential' 'python3' 'python3-venv' 'python3-pip')
POETRY_INSTALL_URL=https://install.python-poetry.org

apt-get update
apt-get install --no-install-recommends -y ${BUILD_DEPS[@]}
curl -sSL $POETRY_INSTALL_URL | python3 -
apt-get remove -y ${BUILD_DEPS[@]}
apt-get -y clean
apt-get -y autoremove
