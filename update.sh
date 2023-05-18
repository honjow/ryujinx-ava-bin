#!/bin/bash

# 获取当前版本号
current_version=$(grep -oP 'pkgver=\K(.*)(?=$)' PKGBUILD)
echo "Current Ryujinx version: $current_version"

# 获取最新版本号
latest_version=$(curl -s https://api.github.com/repos/Ryujinx/release-channel-master/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
echo "Latest Ryujinx version: $latest_version"

# 检查最新版本号是否为空
if [[ -z "$latest_version" ]]; then
  echo "Failed to get the latest version. Please check your network connection or API response."
  exit 2  # 退出状态码表示获取最新版本号失败
fi

# 比较版本号
if [[ "$current_version" != "$latest_version" ]]; then
  # 检测到新版本号较大，执行后续步骤
  echo "Updating PKGBUILD to version $latest_version"
  
  # 替换版本号
  sed -i "s/pkgver=.*/pkgver=$latest_version/" PKGBUILD
  makepkg --printsrcinfo > .SRCINFO

  # 更新项目
  git add PKGBUILD
  git commit -m "Update to $latest_version"
  git push

  exit 0  # 退出状态码表示成功
else
  echo "No update needed. Current version is up to date."
  exit 1  # 退出状态码表示无需更新
fi