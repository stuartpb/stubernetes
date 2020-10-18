rm -rf /etc/cni/net.d
iptables -tnat -F
iptables -tmangle -F
iptables -F
