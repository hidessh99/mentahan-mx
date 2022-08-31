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
tls="$(cat ~/log-install.txt | grep -w "HADOWSOCKS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "SHADOWSOCKS WS HTTP" | cut -d: -f2|sed 's/ //g')"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo -e	"  NO ${GREEN}USER   ${RED}EXPIRED ${BLUE}Net${NC}"
        grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

clear
#buatlinkshadowsocks
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/xrayssws;host=$domain;tls#${user}"
shadowsockslinkgrpc="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"

clear
echo -e ""
echo -e "======-SHADOWSHOCK-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path        : xrayssws/ss-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "link shadowshock"
echo -e "${NC}${ORANGE} ${shadowsockslink} ${NC}"
echo -e "========================="
echo -e "link shadowshock grpc"
echo -e "${NC}${BLUE} ${shadowsockslinkgrpc} ${NC}"
echo -e "========================="
echo -e "======Custom Import Config From URL ======="
echo -e "URL Custom Config WS TLS   : ${NC}${ORANGE} http://${domain}:89/ss-ws-$user.txt ${NC}" 
echo -e "URL Custom Config GRPC TLS : ${NC}${BLUE} http://${domain}:89/ss-grpc-$user.txt ${NC}" 
echo -e "===================================================="
echo -e         "AKCELL XRAY MULTI SHADOWSHOCK"
echo -e "===================================================="
