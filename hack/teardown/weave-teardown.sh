rm -rf /etc/cni/net.d
iptables -F
iptables -tnat -F
