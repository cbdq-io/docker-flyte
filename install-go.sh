#!/bin/sh
#############################################################################
# Install the go language from binary.
#############################################################################
GO_VERSION=1.23.6
HARDWARE_PLATFORM=$( uname -m )

case "$( uname -m )" in
  aarch64) URL="https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" ;;
  x86_64)  URL="https://go.dev/dl/go1.24.0.linux-amd64.tar.gz" ;;
  *)       URL="https://go.dev/dl/go${GO_VERSION}.linux-$( uname -m ).tar.gz" ;;
esac

echo "INFO: Using ${URL} for the ${HARDWARE_PLATFORM} platform."
wget -qO /tmp/go.tgz "$URL"
tar -C /usr/local -xzf /tmp/go.tgz
