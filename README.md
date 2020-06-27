# stubernetes-system

## helmreleases

This is a "Helmbag" repository of manifests

They are installed by the Helm Operator installed as part of the [stubernetes-core](https://github.com/stuartpb/stubernetes-core) chart.

Charts with their own namespace also include the namespace they're installed into.

## namespaces

Namespaces that span more than one chart (and the `stubernetes-system` namespace that contains the `HelmRelease`s) are defined here.

## storage

Experimental OpenEBS definitions are defined here.
