#! /bin/bash

# This script is more for humans to act out manually than to actually
# set up and execute, but I've designed it so it would, in theory,
# set up a new system

# TODO: ensure that user is root

# TODO: Check if setup has anything to do at all
# (ie. bail if cluster is already up with stubernetes-core-helm-operator running)
if systemctl is-active --quiet iscsid; then
  # TODO: ensure we can resolve our own hostname
  kubeadm init
  if [[ -n NO_GODS_NO_MASTERS ]]; then
    kubectl taint nodes --all node-role.kubernetes.io/master-
  fi
  mkdir -p ~/.kube
  cp -i /etc/kubernetes/admin.conf ~/.kube/config
  # REMINDER: you'll want to put this stuff in your kubeconfig, too
  # TODO: install stubernetes-core helm chart
else
  # install dependencies (will do nothing if there's no change to be made)
  transactional-update pkg install open-iscsi e2fsprogs
  ## NOTE: I'm not sure if this piping-into-shell part actually works
  echo 'systemctl enable iscsid' | transactional-update --continue shell
  reboot
fi
