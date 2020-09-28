#! /bin/sh

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 2
fi

mount $1 -o noatime,subvol=@/root /mnt
mkdir -p /mnt/.ssh
bash -c 'curl https://github.com/'$2'.keys > /mnt/.ssh/authorized_keys'
chmod 0600 /mnt/.ssh/authorized_keys
sync
umount /mnt
