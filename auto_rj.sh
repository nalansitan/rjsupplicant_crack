#!/bin/bash

# ubuntu系统下sudo wall会出问题！请使用echo "something"|sudo wall的格式！

# xxx=0
while [[ 1 == 1 ]]
do
	sleep 2
	# tail /tmp/nohup.out | grep "安装和使用代理软件"
	# cat /tmp/nohup.out | grep "安装和使用代理软件"
	# cat /tmp/nohup.out | grep "用户处于黑名单中"
	# text=`cat /tmp/nohup.out`
	text=`tail /tmp/nohup.out`
	echo ${text}|grep -o "安装和使用代理软件">/dev/null
	if [[ $? == 0 ]];then
		sudo wall "${xxx}:检测到代理掉线，自动重新认证"
		# xxx+=1
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		./rj_auth.sh
		# if [[ $xxx == 10 ]];then
			# xxx=0
			# sudo wall "kill ipv6proxy"
			# sudo killall ipv6proxy
			# sleep 3
			# nohup sudo /home/nalansitan/program/ipv6proxy-master/ipv6proxy eth0 eth1>/tmp/ipv6proxy.out&
			# sudo wall "start ipv6proxy"
		# fi
		sleep 5
	fi
	echo ${text}|grep -o "用户处于黑名单中">/dev/null
	if [[ $? == 0 ]];then
		# sudo wall "被拉入黑名单，一小时后自动重新认证，师姐可以洗澡去了，节哀"
		# sleep 3800
		for (( n=3800;n-=2;n>=0)){
			sudo wall "被拉入黑名单，${n}s后自动从黑名单中放出并自动重新认证，师姐可以洗澡去了，节哀"
			sleep 2
		}
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		./rj_auth.sh
		sleep 5
	fi
	echo ${text}|grep -o "被强制下线">/dev/null
	if [[ $? == 0 ]];then
		sudo wall "被强制下线，自动重新认证"
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		./rj_auth.sh
		sleep 10
	fi
	echo ${text}|grep -o "Thread">/dev/null
	if [[ $? == 0 ]];then
		for ((n=14;n-=2;n>=0)){
			sudo wall "莫名掉线，${n}s后自动重启,如需终止重启请在终端输入killall auto_rj.sh"
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		# ./rj_auth.sh
			sleep 2
		}
		sudo reboot
	fi
	echo ${text}|grep -o "无法找到网卡或系统未完成网卡初始化">/dev/null
	if [[ $? == 0 ]];then
		for ((n=14;n-=2;n>=0)){
			sudo wall "无法找到网卡，${n}s后自动重启,如需终止重启请在终端输入killall auto_rj.sh"
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		# ./rj_auth.sh
			sleep 2
		}
		sudo reboot
	fi
	echo ${text}|grep -o "客户端已经在运行">/dev/null
	if [[ $? == 0 ]];then
		sudo wall "客户端已经在运行，自动终止客户端并重新认证"
		sudo killall rjsupplicant
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		./rj_auth.sh
		sleep 5
	fi
	echo ${text}|grep -o "无法.*服务器.*">/dev/null
	if [[ $? == 0 ]];then
		sudo wall "无法连接认证服务器，5min后自动重试"
		for (( n=300;n-=2;n>=0)){
			sudo wall "无法连接认证服务器,${n}s后自动重试,请勿重启"
			sleep 2
		}
		sudo killall rjsupplicant
		# /home/nalansitan/program/rjsupplicant_crack/rj_auth.sh
		./rj_auth.sh
		sleep 5
	fi
done
