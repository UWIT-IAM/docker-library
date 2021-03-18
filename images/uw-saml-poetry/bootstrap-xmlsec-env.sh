#!/usr/bin/env bash

set -e

BUILD_DEPS=(
  libxmlsec1-dev
  build-essential
  pkg-config
)

apt-get update
apt-get install -y ${BUILD_DEPS[@]} libxmlsec1-openssl
poetry install && rm pyproject.toml && rm poetry.lock
apt-get -y remove ${BUILD_DEPS[@]} && apt-get -y clean && apt-get -y autoremove
