#!/bin/bash

set -eux 

docker buildx create --name container --driver=docker-container default || true

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target base -f Dockerfile20 -t zcscompany/node:20-base .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dev -f Dockerfile20 -t zcscompany/node:20-dev .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dist -f Dockerfile20 -t zcscompany/node:20-dist .

docker buildx stop container
