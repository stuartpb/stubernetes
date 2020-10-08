# stubernetes-system

This kustomization defines the resources for the Stubernetes system, mostly in terms of HelmRelease objects installed using the GitOps Toolkit.

More full documentation of this is intended later, using a literate processing system like [Lit](https://github.com/vijithassar/lit).

## Installation

`kubectl apply -k https://github.com/stuartpb/stubernetes-core` will apply the core manifests that bootstrap this system to the cluster.

Make sure you have labeled nodes appropriately: nodes serving internal trafic should be labeled `st8s.testtrack4.com/zone=403`, and nodes serving storage should be labeled `st8s.testtrack4.com/storage-group=storberry`.
