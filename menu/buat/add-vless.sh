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
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VLESS WS HTTP" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
#notes	
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
t="trojan"
v="vmess"
l="vless"
s="shadowsock"
g="grpc"

#buatakun
sed -i '/#vless$/a\## '"$user $exp $hariini $uuid $l"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\## '"$user $exp $hariini $uuid $l $g"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
#buatlink
vlesslinkws="vless://${uuid}@${domain}:${nontls}?path=/xrayws&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslinkwstls="vless://${uuid}@${domain}:${tls}?path=/xrayws&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslinkgrpc="vless://${uuid}@${domain}:${tls}?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"
systemctl restart xray.service
clear
echo -e ""
echo -e "======-XRAYS/VLESS-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $tls"
echo -e "Port No TLS : $nontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws/grpc"
echo -e "Path        : /xrayws/vless-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "Link vless ws   	"
echo -e "${NC}${GREEN} ${vlesslinkws} ${NC}"
echo -e "Link vless ws tls   	"
echo -e "${NC}${ORANGE} ${vlesslinkwstls} ${NC}"
echo -e "========================="
echo -e "Link vless grpc 	"
echo -e "${NC}${BLUE} ${vlesslinkgrpc} ${NC}"
echo -e "========================="
echo -e "AKCELL XRAY MULTI VLESS"
