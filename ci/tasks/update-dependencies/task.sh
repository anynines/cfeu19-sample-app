#!/bin/bash

set -o errexit # Exit immediately if a simple command exits with a non-zero status
set -o nounset # Report the usage of uninitialized variables

updated_app_dir=${PWD}/updated-app
gin_gonic_gin_version=$(<${PWD}/deps/gin-gonic-gin/version)

git clone ${PWD}/app ${updated_app_dir}
cd ${updated_app_dir}

go get github.com/gin-gonic/gin@${gin_gonic_gin_version}

git add go.mod go.sum
git commit -m "Update Gin Web Framework to v${gin_gonic_gin_version}"
