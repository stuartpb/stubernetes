rm -rf /var/lib/rook
ls /dev/mapper/ceph-* | xargs -I% -- dmsetup remove %
sgdisk --zap-all /dev/sda
sgdisk --zap-all /dev/sdb
dd if=/dev/zero of=/dev/sda bs=1M count=100 oflag=direct,dsync
dd if=/dev/zero of=/dev/sdb bs=1M count=100 oflag=direct,dsync
