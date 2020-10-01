#! /usr/bin/env bash

# Generates a config.ign for use booting a system with my authorized keys.
# usage: bash config-imagers/ignition/mkrootkey.sh >/run/media/$USER/ignition/ignition/config.ign
# test: bash config-imagers/ignition/mkrootkey.sh | jq >/dev/null

# this script assumes you have curl and base64

keysource="https://github.com/stuartpb.keys"

if [[ -n $EMBED_KEYS ]]; then
  if command -v jq >/dev/null 2>&1; then
    keysource="data:,$(curl -s "$keysource" | jq -sRr @uri)"
  else
    keysource="data:;base64,$(curl -s "$keysource" | base64 -w0)"
  fi
fi

cat <<EOF
{
  "ignition": { "version": "3.1.0" },
  "storage": {
    "files": [
      {
        "filesystem": "root",
        "path": "/root/.ssh/authorized_keys",
        "mode": 600,
        "overwrite": true,
        "contents": { "source": "$keysource" }
      }
    ]
  },
  "systemd": {
 		"units": [{
 			"name": "sshd.service",
 			"enabled": true
 		}]
 	}
}
EOF
