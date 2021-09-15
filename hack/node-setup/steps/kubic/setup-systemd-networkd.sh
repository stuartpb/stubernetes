zypper install -y systemd-network
systemctl disable wicked.service
systemctl enable systemd-networkd.service systemd-resolved.service
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
# disable DNSSEC globally
sed -i '/^#\?DNSSEC=/{s/^#//;s/=.*$/=no/}' /etc/systemd/resolved.conf
echo '[Match]
Name=eth*

[Network]
DHCP=yes
DNSOverTLS=opportunistic

[DHCPv4]
UseDomains=yes
RouteMetric=10

[DHCPv6]
RouteMetric=10
' > /etc/systemd/network/80-dhcp.network
