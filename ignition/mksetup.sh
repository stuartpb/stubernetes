#! /usr/bin/env bash

# Generates a config.ign for use initializing a Stubernetes node.
# usage: bash mksetup.sh >/run/media/$USER/ignition/ignition/config.ign
# test: bash mksetup.sh | jq >/dev/null

# this script assumes you have curl

read -p "Hostname:" hostname

## inspired by https://stackoverflow.com/a/34576956/34799
arraylines () {
  sed 's/["\]/\\&/g;s/.*/'"$1"'"&"/;$!s/$/,/'
}

cat <<EOF
{
  "ignition": { "version": "3.1.0" },
  "passwd": {
    "users": [
      {
        "name": "stuart",
        "groups": "sudo",
        "sshAuthorizedKeys": [
$(curl -s https://github.com/stuartpb.keys | arraylines '          ')
        ]
      }
    ]
  },
  "storage": {
    "files": [
      {
        "filesystem": "root",
        "path": "/etc/hostname",
        "mode": 420,
        "overwrite": true,
        "contents": { "source": "data:,$hostname" }
      },
      {
        "filesystem": "root",
        "path": "/etc/sudoers",
        "mode": 440,
        "overwrite": true,
        "contents": { "source": "data:;base64,$(base64 -w0 sudoers)" }
      }
    ]
  }
}
EOF
