#!/bin/bash

export GO_VERSION
export GO_SRC=/usr/local/go

# SETUP the latest version of GOLANG
GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
GO_VERSION=${GO_VERSION#go}

# Get kernel name
kernel=$(uname -s | tr '[:upper:]' '[:lower:]')

# If already a Go installation cleaned it.
if [[ -d "$GO_SRC" ]]; then
    sudo rm -rf "$GO_SRC"
    sudo rm -rf "$GOPATH"
fi

# Download and install the package from google
curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | tar -v -C /usr/local -xz
# if USER set, then rebuild stdlib for faster builds
if [ ! -z "$USER" ]
    chown -R "$USER" /usr/local/go/pkg
fi
# Installation of CGO
CGO_ENABLED=0 go install -a -installsuffix cgo std