# Devcontainer Features Collection

This repository vendors non-official devcontainer feature sources used across projects in `/workspace`.

## Publish Target

CI publishes features to GitHub Container Registry (GHCR) under:

- `ghcr.io/gudzenkov/devcontainer-features/<feature-id>:<major>`

Examples:

- `ghcr.io/gudzenkov/devcontainer-features/google-cloud-cli:1`
- `ghcr.io/gudzenkov/devcontainer-features/op:1`
- `ghcr.io/gudzenkov/devcontainer-features/jq-likes:1`
- `ghcr.io/gudzenkov/devcontainer-features/shell-history:1`

## Included features

- `google-cloud-cli` (`ghcr.io/gudzenkov/devcontainer-features/google-cloud-cli:1`) - vendored from `ghcr.io/dhoeric/features/google-cloud-cli:1`
- `jq-likes` (`ghcr.io/gudzenkov/devcontainer-features/jq-likes:1`) - vendored from `ghcr.io/eitsupi/devcontainer-features/jq-likes:2.1.1`
- `op` (`ghcr.io/gudzenkov/devcontainer-features/op:1`) - vendored from `ghcr.io/flexwie/devcontainer-features/op:1`
- `shell-history` (`ghcr.io/gudzenkov/devcontainer-features/shell-history:1`) - vendored from `ghcr.io/stuartleeks/dev-container-features/shell-history:0.0.3`

## Excluded

- All features from `ghcr.io/devcontainers/*`
- All features from `ghcr.io/devcontainers-extra/*`
