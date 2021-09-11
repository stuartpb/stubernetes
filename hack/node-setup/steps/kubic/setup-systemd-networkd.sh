zypper install -y systemd-network
systemctl disable wicked.service
systemctl enable systemd-networkd.service systemd-resolved.service
# disable DNSSEC globally
sed -i '/^#\?DNSSEC=/{s/^#//;s/=.*$/=no/}' /etc/systemd/resolved.conf
echo '[Match]
Type=ether

[Network]
DHCP=yes
DNSOverTLS=opportunistic

[DHCPv4]
UseDomains=yes
RouteMetric=10

[DHCPv6]
RouteMetric=10
' > /etc/systemd/network/80-dhcp.network
