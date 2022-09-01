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
tls="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "TROJAN WS HTTP" | cut -d: -f2|sed 's/ //g')"
bugws="$(cat /etc/xray/bugws)"
bugsni="$(cat /etc/xray/bugsni)"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
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
        grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

clear
#buatlinkvmess
cat>/etc/xray/configsni-vmess-$user-ws.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xrayvws",
      "type": "none",
      "host": "${bugsni}",
      "tls": ""
}
EOF
cat>/etc/xray/configsni-vmess-$user-wstls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xrayvws",
      "type": "none",
      "host": "${bugsni}",
      "tls": "tls"
}
EOF
cat>/etc/xray/configsni-vmess-$user-grpc.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${bugsni}",
      "tls": "tls"
}
EOF
cd
clear
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslinkws="vmess://$(base64 -w 0 /etc/xray/configsni-vmess-$user-ws.json)"
vmesslinkwstls="vmess://$(base64 -w 0 /etc/xray/configsni-vmess-$user-wstls.json)"
vmesslinkgrpc="vmess://$(base64 -w 0 /etc/xray/configsni-vmess-$user-grpc.json)"

clear
#buat text all link
cat > /home/vps/public_html/configsni-vmess-$user.txt<<EOF
${vmesslinkws}
${vmesslinkwstls}
${vmesslinkgrpc}
EOF
cd
clear
echo -e ""
echo -e "==========-VMESS-========="
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path ws     : /xrayvws"
echo -e "Path grpc   : /vmess-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "link   vmess ws"
echo -e
echo -e "${NC}${GREEN} ${vmesslinkws} ${NC}"
echo -e
echo -e "========================="
echo -e "link   vmess ws tls"
echo -e
echo -e "${NC}${ORANGE} ${vmesslinkwstls} ${NC}"
echo -e
echo -e "========================="
echo -e "link vmess grpc"
echo -e
echo -e "${NC}${BLUE} ${vmesslinkgrpc} ${NC}"
echo -e
echo -e "========================="
echo -e "======Custom Import Config From URL ======="
echo -e "URL CONFIG V2RAYNG vmess : ${NC}${RED} http://${domain}:89/configsni-vmess-$user.txt ${NC}" 
echo -e "===================================================="
echo -e                "AKCELL XRAY MULTI VMESS"
echo -e "===================================================="
