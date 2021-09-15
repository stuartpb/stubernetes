echo 'ACTION=="add|change", ENV{ID_MODEL}=="*_SSD", ATTR{queue/rotational}="0", SYMLINK+="storberry-ssd"'  > /etc/udev/rules.d/65-storberry-ssd.rules
udevadm trigger
