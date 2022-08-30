#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl ipinfo.io/ip | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Fuck You!!"
exit 0
fi
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "VMESS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VMESS WS HTTP" | cut -d: -f2|sed 's/ //g')"

clear
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmessws="vmess://$(base64 -w 0 /etc/xray/vmess-$user-ws.json)"
vmesswstls="vmess://$(base64 -w 0 /etc/xray/vmess-$user-wstls.json)"
vmessgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-grpc.json)"
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "======-XRAYS/VMESS-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path        : /xrayvws/vmess-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "link   vmess ws"
echo -e
echo -e "${vmessws}"
echo -e
echo -e "========================="
echo -e "link   vmess ws"
echo -e
echo -e "${vmesswstls}"
echo -e
echo -e "========================="
echo -e "link vmess grpc"
echo -e
echo -e "${vmessgrpc}"
echo -e
echo -e "========================="
echo -e "AKCELL XRAYMULTI"
