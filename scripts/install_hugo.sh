#!/bin/bash

HUGO_VERSION=0.57.2

# Dependency needed for hugo extended on travis
wget -q -O libstdc++6 http://security.ubuntu.com/ubuntu/pool/main/g/gcc-5/libstdc++6_5.4.0-6ubuntu1~16.04.10_amd64.deb
sudo dpkg --force-all -i libstdc++6

# And installing hugo itself

wget https://github.com/gohugoio/hugo/releases/download/v"$HUGO_VERSION"/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz -O /tmp/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz
tar -xzvf /tmp/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz

sudo mkdir -p /usr/local/bin
sudo mv hugo /usr/local/bin
