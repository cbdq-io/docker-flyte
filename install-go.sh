#!/bin/sh
#############################################################################
# Install the go language from binary.
#############################################################################
GO_VERSION=1.23.6

case "$( uname -m )" in
  aarch64) URL="https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" ;;
  *)       URL="https://go.dev/dl/go${GO_VERSION}.linux-$( uname -m ).tar.gz" ;;
esac

wget -O /tmp/go.tgz "$URL"
tar -C /usr/local -xzf /tmp/go.tgz
