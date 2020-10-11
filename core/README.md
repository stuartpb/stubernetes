# stubernetes-core

This is a Kustomization that installs the core components for Stubernetes:

- The Weave Net CNI
- The Flux GitOps Toolkit
- Resources to deploy [the rest of the system](https://github.com/stuartpb/stubernetes-system)

## Installing

`kustomize build github.com/stuartpb/stubernetes/core | kubectl apply -f -` or something like that - honestly, I currently just roll these out one by one from a checkout.
