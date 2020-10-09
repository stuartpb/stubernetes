# stubernetes-core

This is a Kustomization that installs the core components for Stubernetes:

- The Weave Net CNI
- The Flux GitOps Toolkit
- Resources to deploy [the rest of the system](https://github.com/stuartpb/stubernetes-system)

## Installing

`kubectl apply -k https://github.com/stuartpb/stubernetes-core`
