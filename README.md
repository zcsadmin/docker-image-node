# ZCS Node docker images

Docker images used for ZCS Node applications.

ZCS Node docker images come in three flavours:

- `base`: base image, mainly used by other stages
- `dev`: image for local development
- `dist`: image for application distribution

Supported Node versions:

 - `Node 20`
 - `Node 22`
 - `Node 24`

Supported platforms:

- `linux/amd64`
- `linux/arm64`

## Build images

The tag suffix must match the `--build-arg NODE_VERSION` (e.g. use `NODE_VERSION=20` for `:20-*` tags).

### Base image

```bash
docker build --pull --target base --build-arg NODE_VERSION=20 -t zcscompany/node:20-base .
```

### Dev image

```bash
docker build --pull --target dev --build-arg NODE_VERSION=20 -t zcscompany/node:20-dev .
```

### Dist image

```bash
docker build --pull --target dist --build-arg NODE_VERSION=20 -t zcscompany/node:20-dist .
```

## Release

`./build-and-push.sh` builds and pushes all supported versions (`Node 20/22/24`) for `linux/amd64` and `linux/arm64` to Docker Hub. It requires `docker login`. Use `./build-and-push.sh <20|22|24>` to release a single version's 3 tags.

The images are also rebuilt and pushed automatically by CI whenever the upstream `node:*-trixie-slim` base images change.

## Docker hub repository

https://hub.docker.com/r/zcscompany/node


## Support

[Madnesslab Team @ Zucchetti Centro Sistemi](mailto:madnesslab@zcscompany.com)

