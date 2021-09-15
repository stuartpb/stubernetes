ROOT_IMAGE_SOURCE=http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz
BUILD_TIMESTAMP=$(date -u +%Y%m%dT%H%M%S)

# set up partitions for boot and root
fdisk "$SDCARD_DEVICE" <<EOF
o
n
p
1

+200M
t
c
n
p
2


w
EOF

# make root and boot filesystems
mkfs.vfat "${SDCARD_DEVICE}1"
mkfs.btrfs "${SDCARD_DEVICE}2"

# make subvolumes
mount "${SDCARD_DEVICE}2" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@/.snapshots
btrfs subvolume create /mnt/@/var
btrfs subvolume create /mnt/@/srv
btrfs subvolume create /mnt/@/root
btrfs subvolume create /mnt/@/home

# create initial snapshot
btrfs subvolume create /mnt/@/.snapshots/$BUILD_TIMESTAMP
btrfs subvolume set-default /mnt/@/.snapshots/$BUILD_TIMESTAMP

# remount into initial snapshot environment
umount /mnt
mount "${SDCARD_DEVICE}2" /mnt

# make mountpoints for subvolumes and mount them
for subdir in .snapshots var srv root home; do
  mkdir /mnt/$subdir
  mount  "${SDCARD_DEVICE}2" -o subvol=/@/$subdir /mnt/$subdir
done
mkdir /mnt/boot
mount "${SDCARD_DEVICE}1" /mnt/boot

# install Arch image
curl -L "$ROOT_IMAGE_SOURCE" | bsdtar xz -f - -C /mnt

# add subvolume mounts to fstab
cat <<EOF > /mnt/etc/fstab
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
/dev/mmcblk1p2 / btrfs defaults 0 0
/dev/mmcblk1p2 /.snapshots btrfs subvol=/@/.snapshots 0 0
/dev/mmcblk1p2 /var btrfs subvol=/@/var,x-initrd.mount 0 0
/dev/mmcblk1p2 /srv btrfs subvol=/@/srv 0 0
/dev/mmcblk1p2 /root btrfs subvol=/@/root,x-initrd.mount 0 0
/dev/mmcblk1p2 /home btrfs subvol=/@/home 0 0
/dev/mmcblk1p1  /boot   vfat    defaults        0       0
EOF

# just in case the entire image install was somehow instant
sleep 1

CUSTOMIZE_TIMESTAMP=$(date -u +%Y%m%dT%H%M%S)
btrfs subvolume snapshot /mnt /mnt/.snapshots/$CUSTOMIZE_TIMESTAMP
echo $TARGET_HOSTNAME > /mnt/.snapshots/$CUSTOMIZE_TIMESTAMP/etc/hostname
btrfs subvolume set-default /mnt/.snapshots/$CUSTOMIZE_TIMESTAMP
sync
umount -R /mnt
