#! /usr/bin/env bash

# Generates a combustion script to configure a fresh Stubernetes node for adminstration.
# usage: SET_HOSTNAME=foobar bash config-writers/combustion/write-combustion-script.sh >/run/media/$USER/ignition/combustion/script

echo "#!/usr/bin/bash"

# tell Combustion we want network access (for setting up systemd-networkd and/or root keys)
echo "# combustion: network"

if [[ -n $SET_HOSTNAME ]]; then
  echo "hostnamectl set-hostname $SET_HOSTNAME"
fi

if [[ -n $HASHED_ROOT_PASSWORD ]]; then
  echo "echo 'root:$HASHED_ROOT_PASSWORD' | chpasswd -e"
elif [[ -n $UNHASHED_ROOT_PASSWORD ]]; then
  echo "echo 'root:$(openssl passwd -6 "$UNHASHED_ROOT_PASSWORD")' | chpasswd -e"
fi

if [[ -n $ROOT_KEY_SOURCE ]]; then
  echo "mkdir -p /root/.ssh
curl $ROOT_KEY_SOURCE > /root/.ssh/authorized_keys
chmod 0600 /root/.ssh/authorized_keys"
fi

cat steps/disable-lid-switch.sh steps/kubic/setup-systemd-networkd.sh
