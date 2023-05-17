#!/bin/bash

latest_version=$(curl -s https://api.github.com/repos/Ryujinx/release-channel-master/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
echo "Latest Ryujinx version: $latest_version"
sed -i "s/pkgver=.*/pkgver=$latest_version/" PKGBUILD
makepkg -fsiCc