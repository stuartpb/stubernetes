#! /bin/sh
set -e

# usage: sudo bash mount-tweakers/load-root-keys.sh /dev/sd${TARGET_DRIVE_LETTER}2 https://github.com/$GITHUB_USER.keys

if [ $EUID -ne 0 ]; then
  echo "This script must be run as root"
  exit 2
fi

mount $1 -o noatime,subvol=@/root /mnt
mkdir -p /mnt/.ssh
chmod 0700 /mnt/.ssh
curl "$2" > /mnt/.ssh/authorized_keys
chmod 0600 /mnt/.ssh/authorized_keys
sync
umount /mnt
