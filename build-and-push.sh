#!/bin/bash

PUSH="--push"

set -eux

VERSIONS=("$@")
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(24 22 20)
fi

docker buildx create --name container --driver=docker-container default || true

for v in "${VERSIONS[@]}"; do
    docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull ${PUSH} --target base --build-arg NODE_VERSION=${v} -f Dockerfile -t zcscompany/node:${v}-base .
    docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull ${PUSH} --target dev --build-arg NODE_VERSION=${v} -f Dockerfile -t zcscompany/node:${v}-dev .
    docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=true --builder=container --pull ${PUSH} --target dist --build-arg NODE_VERSION=${v} -f Dockerfile -t zcscompany/node:${v}-dist .
done

docker buildx stop container