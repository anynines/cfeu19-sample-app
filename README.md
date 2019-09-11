# CF Summit Europe 2019 - Sample App

This repository contains a sample application for the talk "Automated Side-by-Side development of applications for BOSH and Kubernetes" at the CF Summit Europe 2019.

## Overview

The sample application is written in Go and is using Go modules for dependency management. The repository also provides a Dockerfile and a docker-compose file to easily build and deploy the application locally.

## Build from source

This project requires Go 1.11 or newer.

```sh
git clone https://github.com/anynines/cfeu19-sample-app.git
cd cfeu19-sample-app
go build

# Run the binary
./cfeu19-sample-app
```

## Build with Docker

To run the application using Docker, the image can be build using

```sh
git clone https://github.com/anynines/cfeu19-sample-app.git
cd cfeu19-sample-app
docker build . --tag anyninesgmbh/cfeu19-sample-app:latest
```

or by docker-compose using

```sh
docker-compose build

# or running it directly with

docker-compose up
```
