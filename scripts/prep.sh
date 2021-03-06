#!/usr/bin/env bash

pushd () {
  command pushd "$@" > /dev/null
}

popd () {
  command popd "$@" > /dev/null
}

# Clone Repo
rm -rf outline
git clone https://github.com/outline/outline.git outline

# Enter Repo
pushd outline

# Checkout latest tagged version
LATEST_TAG=`git describe --tags $(git rev-list --tags --max-count=1)`
git checkout "${LATEST_TAG}"

# Apply Patches
git apply ../patches/*.patch

# Merge Dockerfiles
sed -i 's#outlinewiki/outline-base#deps#g' Dockerfile
cat Dockerfile.base Dockerfile > Dockerfile.tmp
mv Dockerfile.tmp Dockerfile

# Exit Repo
popd
