#!/bin/bash

set -o errexit # Exit immediately if a simple command exits with a non-zero status
set -o nounset # Report the usage of uninitialized variables

echo 'Create GitHub pull request'

if [ -z "${PR_BASE_BRANCH}" ]; then
  PR_BASE_BRANCH='master'
fi

cd ${PWD}/repository

echo 'Parse pull request subject...'
pull_request_subject=$(git log HEAD^..HEAD --pretty='%s')

echo 'Create pull request...'
hub pull-request -m "${pull_request_subject}" -b ${PR_BASE_BRANCH} -h ${PR_HEAD_BRANCH}

echo 'Done'
