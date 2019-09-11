#!/bin/bash

set -o errexit # Exit immediately if a simple command exits with a non-zero status
set -o nounset # Report the usage of uninitialized variables

cd app
go test
