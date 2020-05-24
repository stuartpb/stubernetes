# stubernetes-setup

Core definition files for my personal Kubernetes cluster.

## config.yaml

This defines the core k3os configuration, which is copied to `/var/lib/rancher/config.yaml`.

## manifests/cluster-dns.yaml

This is a copy of the coredns manifest that's been retooled to not conflict with the name used by k3s's default coredns service (which is forcibly deleted on startup due to the `--disable coredns` specified in config.yaml).

It is copied to `/var/lib/rancher/k3s/server/manifests/cluster-dns.yaml`, though it could also just be added to the cluster via `kubectl apply`.

## manifests/z.yaml

This is copied to `/var/lib/rancher/k3s/server/manifests/z.yaml` to make a stub version of the `coredns` ConfigMap to be used by `cluster-dns`.

It is named `z.yaml` so it will come after `coredns.yaml` lexically, as [k3s deletes disabled service assets in lexical order](https://github.com/rancher/k3s/issues/462#issuecomment-491180796). If the `coredns` manifest is restored, the ConfigMap will be deleted on every server boot, and then this manifest will recreate it so that `cluster-dns` can function.

Incidentally, I would *really really* like to not run this cluster on k3s.

## Out of scope

This repository does *not* include the YAML that the node was initialized with, which contains only my GitHub username for access by copying the SSH keys:

```yaml
sshAuthorizedKeys:
- github:stuartpb
```

(This also contained my Wi-Fi credentials originally, but I removed them after getting an Ethernet adapter.)
