#!/bin/bash

set -eux 

docker buildx create --name container --driver=docker-container default || true

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target base --build-arg NODE_VERSION=20 -f Dockerfile -t zcscompany/node:20-base .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dev --build-arg NODE_VERSION=20 -f Dockerfile -t zcscompany/node:20-dev .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dist --build-arg NODE_VERSION=20 -f Dockerfile -t zcscompany/node:20-dist .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target base --build-arg NODE_VERSION=22 -f Dockerfile -t zcscompany/node:22-base .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dev --build-arg NODE_VERSION=22 -f Dockerfile -t zcscompany/node:22-dev .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dist --build-arg NODE_VERSION=22 -f Dockerfile -t zcscompany/node:22-dist .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target base --build-arg NODE_VERSION=24 -f Dockerfile -t zcscompany/node:24-base .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dev --build-arg NODE_VERSION=24 -f Dockerfile -t zcscompany/node:24-dev .

docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull --push --target dist --build-arg NODE_VERSION=24 -f Dockerfile -t zcscompany/node:24-dist .

docker buildx stop container
