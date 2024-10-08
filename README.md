# ZCS Node docker images

Docker images used for ZCS Node applications.

ZCS Node docker images come in three flavours:

- `base`: base image, mainly used by other stages
- `dev`: image for local development
- `dist`: image for application distribution

Supported Node versions:

 - `Node 20`

Supported platforms:

- `linux/amd64`
- `linux/arm64`

## Build images

### Base image

```bash
docker build --pull --target base -t zcscompany/node:20-base .
```

### Dev image

```bash
docker build --pull --target dev -t zcscompany/node:20-dev .
```

### Dist image

```bash
docker build --pull --target dist -t zcscompany/node:20-dist .
```

## Docker hub repository

https://hub.docker.com/r/zcscompany/node


## Support

[Madnesslab Team @ Zucchetti Centro Sistemi](mailto:madnesslab@zcscompany.com)

