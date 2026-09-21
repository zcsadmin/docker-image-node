# ZCS Node docker images

Docker images used for ZCS Node applications.

## Why a custom image?

ZCS applications standardize on their own runtime images instead of using the upstream ones directly, so that every technology shares the same conventions:

- **Non-root user `bob`**: containers run as the `bob` user (never `root`), with predictable uid/gid across images built from different base distributions.
- **A fix-perm script**: the `dev` image ships `/fix-perm.sh`, which re-aligns `bob`'s uid/gid to the developer's local user at container startup, so files and directories bind-mounted from the host keep the developer's ownership while running in the container.
- **`/app` as working directory**: every image works in `/app`, and mounted source code lives there.
- **Three flavours**: `base`, `dev` and `dist` provide the same mental model across projects, regardless of the underlying technology.

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

## Related projects

The same conventions are applied to the other ZCS runtimes:

- [docker-image-python](https://github.com/zcsadmin/docker-image-python) — ZCS Python docker images
- [docker-image-java](https://github.com/zcsadmin/docker-image-java) — ZCS Java docker images

## License

This code is released under the [MIT License](LICENSE).

## Docker hub repository

https://hub.docker.com/r/zcscompany/node

## Support

This code has been developed and released by Laboratorio della Follia, an R&D division of Zucchetti Centro Sistemi.

For support contact Michele Mondelli ([m.mondelli@zcscompany.com](mailto:m.mondelli@zcscompany.com)) or Claudio Cavina ([c.cavina@zcscompany.com](mailto:c.cavina@zcscompany.com)).
