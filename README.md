# stubernetes

This is a monorepo of all the files I use to set up and maintain my personal bare-metal home Kubernetes cluster.

## core

The `core` directory contains the resources for the core components of the system that have priority over everything else.

## secrets/generic

The `secrets/generic` directory contains template resources to add external secrets to the repository (like API keys for outside services).

In development, I use a `secrets/actual` directory in my local machines' working directory based on these generic secrets, with the applicable fields replaced with the actual secret values.

## system

The `system` directory contains kustomizations for the system components that provide most infrastructure service on the cluster.

As of 2020-10-09, all values are part of the `base` manifests: a refactor is underway to split them out

## hack

These are scripts for maintaining the cluster in ways that can't be easily rolled out with `kubectl` commands.
