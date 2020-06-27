#! /bin/bash

# This script is more for humans to act out manually than to actually
# set up and execute, but I've designed it so it would, in theory,
# set up a new system

# TODO: ensure that user is root

# TODO: Check if setup has anything to do at all
if systemctl is-active --quiet iscsid; then
  # TODO: ensure we can resolve our own hostname
  kubeadm init
  # TODO: install stubernetes-core helm chart
else
  # install dependencies (will do nothing if there's no change to be made)
  transactional-update pkg install open-iscsi e2fsprogs
  ## NOTE: I'm not sure if this piping-into-shell part actually works
  echo 'systemctl enable iscsid' | transactional-update --continue shell
  reboot
fi
