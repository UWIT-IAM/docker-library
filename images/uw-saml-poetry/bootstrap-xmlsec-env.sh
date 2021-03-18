#!/usr/bin/env bash

set -e

BUILD_DEPS=(
  libxmlsec1-dev
  build-essential
  pkg-config
)

apt-get update
apt-get install -y ${BUILD_DEPS[@]} libxmlsec1-openssl
apt-get install -y libxmlsec1-openssl
pip install --no-cache-dir -U pip xmlsec 'uw-saml[python3-saml]'
apt-get -y remove ${BUILD_DEPS[@]} && apt-get -y clean && apt-get -y autoremove
