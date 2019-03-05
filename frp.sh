#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "#==================================================="
echo "#支持系统: Freebsd/Darwin/Linux/Win"
echo "#博客：https://krito.me"
echo "#FRP交流群：635185606"
echo "#==================================================="

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"


# 检查账户是否为root
check_root(){
	[[$EUID != 0]] && echo -e "${Error} 当前账号非Root登陆。请使用${Green_background_prefix}sudo -i ${Font_color_suffix}输入密码后重新执行。"
}
check_frps_pid(){
	PID = $(ps -ef | grep -v grep | grep frps | awk '{print $2}')
	if [! -z $PID ]; then
		STAT = 0
	else
		STAT = 1
	fi
}
check_frpc_pid(){
	PID = $(ps -ef | grep -v grep | grep frpc | awk '{print $2}')
	if [ ! -z $PID ]; then
		STAT = 0
	else
		STAT = 1
	fi
}

check_frps_start(){
	check_frps_pid
	[[ ! -z ${PID} ]] && echo -e "${Error} FRPS服务正在运行。" && exit 1
}
check_frpc_start(){
	check_frpc_pid
	[[ ! -z ${PID} ]] && echo -e "${Error} FRPC服务正在运行。" && exit 1
}

DAEMON = /usr/local/frp/frps
STAT = 2
check_frps_DAEMON_status(){
	[[ ! -f $DAEMON ]] && echo -e "${Error} FRPS文件未找到,请安装" && exit 1
}
DAEMON = /usr/local/frp/frpc
STAT = 2
check_frpc_DAEMON_status(){
	[[ ! -f $DAEMON ]] && echo -e "${Error} FRPC文件未找到,请安装" && exit 1
}

check_frps_status(){
	check_frps_DAEMON_status
	check_frps_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} FRPS正在运行。"
	elif [ $STAT = 1 ]; then
		echo -e "&{Tip}没有发现FRPS运行，请尝试重启FRPS服务端。"
	if
}

check_frpc_status(){
	check_frpc_DAEMON_status
	check_frpc_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} FRPC正在运行。"
	elif [ $STAT = 1 ]; then
		echo -e "&{Tip}没有发现FRPS运行，请尝试重启FRPC客户端"
	if
}