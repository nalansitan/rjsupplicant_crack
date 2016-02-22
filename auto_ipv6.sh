#!/bin/bash

#需添加判断时间脚本，白天二十分钟自动重启v6,晚上两小时自动重启
while [[ 1 == 1 ]]
do
	for (( n=1200;n-=2;n>=0)){
		sleep 2
	}
	cd /tmp
	sudo killall ipv6proxy
	nohup sudo /home/nalansitan/program/ipv6proxy-master/ipv6proxy eth0 eth1&
	sudo wall "every 20 minutes restart ipv6,done."
done
