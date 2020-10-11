rm -rf /var/lib/rook
ls /dev/mapper/ceph-* 2>/dev/null | xargs -I% -- dmsetup remove %
for dev in $(blkid | grep 'TYPE="LVM2_member"' | cut -d: -f1); do
  sgdisk --zap-all $dev
  dd if=/dev/zero of=$dev bs=1M count=100 oflag=direct,dsync
done
