# AGENTS.md

Builds the `zcscompany/node` Docker images published to Docker Hub (<https://hub.docker.com/r/zcscompany/node>). No application code, tests, lint, or typecheck. Source of truth for the supported version matrix is `build-and-push.sh`, not `README.md`.

## Files

- `Dockerfile` — 3 stages: `base` (`node:${NODE_VERSION}-trixie-slim`; renames the `node` user/group to `bob`, creates `/app`, `WORKDIR /app`, runs as `bob`), `dev` (`base` + copies `/fix-perm.sh`, entrypoint `sleep infinity`), `dist` (currently just `FROM base`, intentionally — no extra layers).
- `build-and-push.sh` — release flow.
- `fix-perm.sh` — copies into the `dev` image only.
- `README.md` — user-facing docs (currently stale on Node versions).

## Commands

- Release: `./build-and-push.sh` — requires Docker Hub auth (`docker login`). Creates the buildx builder `container` (docker-container driver, multi-platform `linux/amd64,linux/arm64`), pushes all 9 images (Node 20/22/24 × base/dev/dist) with `--sbom=true --provenance=true`, then stops the builder. Re-runs are safe (`docker buildx create ... || true`).
- Local single image: `docker build --pull --target <base|dev|dist> --build-arg NODE_VERSION=<20|22|24> -t zcscompany/node:<ver>-<stage> .`

## Gotchas

- Supported Node versions are 20, 22, and 24; `Dockerfile` default is 22. Any build of a `:20-*`/`:24-*` tag must pass `--build-arg NODE_VERSION=` or it silently builds 22.
- The README's example build commands omit the `--build-arg`; do not copy them verbatim.
- In-container user is `bob` (uid/gid 1000, home `/home/bob`, workdir `/app`). `DOCKER_USER`/`DOCKER_GROUP` are build ARGs only, not runtime env vars.
- `fix-perm.sh` re-aligns `bob`'s uid/gid to the host's: the host app's docker-compose invokes `/fix-perm.sh` at container startup with `FIX_UID`/`FIX_GID` set. Users/groups already occupying the target id are moved to 888.
- No CI is configured; pushes go straight to Docker Hub.