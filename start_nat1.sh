#!/bin/bash

lan_ip="192.168.111."
WAN="eth0"
LAN="eth1"
sudo iptables -F
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o ${WAN} -j MASQUERADE
sudo iptables -A FORWARD -i ${LAN} -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${lan_ip}0/24 -j SNAT --to-source ${wan_ip}
sudo ifconfig ${LAN} "${lan_ip}0" broadcast "${lan_ip}255" netmask 255.255.255.0
my_ip=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' |grep -v "${lan_ip}1" |cut -d: -f2 | awk '{ print $1}'`
sudo nohup /usr/sbin/dhcpd  -d -cf /etc/dhcp/dhcpd.conf ${LAN} >/tmp/dhcpd.list &
#start nat
sudo iptables -t nat -A PREROUTING --dst ${my_ip} -p tcp --dport 5904 -j DNAT --to-destination "${lan_ip}111:5900"
# start proftpd
sudo /usr/sbin/proftpd
# start ipv6
sleep 3
# nohup sudo /home/nalansitan/program/ipv6proxy-master/ipv6proxy ${WAN} ${LAN}&
nohup sudo ssserver -c /etc/shadowsocks.json &
echo "Network sharing success!ip:${my_ip}"|sudo wall

