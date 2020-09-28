#! /usr/bin/env bash

# Generates a config.ign for use initializing a Stubernetes node.
# usage: bash mksetup.sh >/run/media/$USER/ignition/ignition/config.ign
# test: bash mksetup.sh | jq >/dev/null

# this script assumes you have base64

read -p "Hostname: " hostname

export keysource="https://github.com/stuartpb.keys"

if [[ -n $EMBED_KEYS ]]; then
  if [[ -z $DISABLE_JQ ]] && command -v jq >/dev/null 2>&1; then
    keysource="data:,$(curl -s "$keysource" | jq -sRr @uri)"
  else
    keysource="data:;base64,$(curl -s "$keysource" | base64 -w0)"
  fi
fi

if [[ -n $INCLUDE_ROOT_KEYS ]]; then
  rootkeys=',
      {
        "filesystem": "root",
        "path": "/root/.ssh/authorized_keys",
        "mode": 600,
        "overwrite": true,
        "contents": { "source": "'"$keysource"'" }
      }'
fi

## inspired by https://stackoverflow.com/a/34576956/34799
arraylines () {
  sed 's/["\]/\\&/g;s/.*/'"$1"'"&"/;$!s/$/,/'
}

if [[ -n $CONFIGURE_ROOT_USER ]]; then
  rootuser='
  "passwd": {
    "users": [
      {
        "name": "root",
        "sshAuthorizedKeys": [
'"$(curl -s "$keysource" | arraylines '          ')"'
        ]
      }
    ]
  },'
fi

cat <<EOF
{
  "ignition": { "version": "3.0.0" },$rootuser
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
        "path": "/etc/systemd/logind.conf",
        "mode": 644,
        "overwrite": true,
        "contents": { "source": "data:;base64,$(base64 -w0 logind.conf)" }
      }$rootkeys
    ]
  }
}
EOF

# ,
#  	"systemd": {
#  		"units": [{
#  			"name": "sshd.service",
#  			"enabled": true
#  		}]
#  	}
