# stop laptops from sleeping when closed while plugged in
sed -i '/^#\?HandleLidSwitchExternalPower=/{s/^#//;s/=.*$/=ignore/}' /etc/systemd/logind.conf
