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
bugws=$(cat /home/bugws)
bugsni=$(cat /home/bugsni)
clear
NUMBER_OF_CLIENTS=$(grep -c -E "#,##,###,#### " "/etc/xray/config.json")
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
	echo -e	"   NO ${GREEN}USER   ${RED}EXPIRED ${BLUE}Net${NC}"
        grep -E "^# " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^# " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^# " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^# " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^# " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#### " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

clear
#buatlinkvless
vlesslinkws="vless://${uuid}@${domain}:80?path=/xrayws&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslinkwstls="vless://${uuid}@${domain}:443?path=/xrayws&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslinkgrpc="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

#buatlinkvmess
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslinkws="vmess://$(base64 -w 0 /etc/xray/vmess-$user-ws.json)"
vmesslinkwstls="vmess://$(base64 -w 0 /etc/xray/vmess-$user-wstls.json)"
vmesslinkgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-grpc.json)"

#buatlinktrojan
trojanlinkwstls="trojan://${uuid}@${domain}:443?path=/xraytrojanws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlinkgrpc="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"

#buatlinkshadowsocks
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/xrayssws;host=$domain;tls#${user}"
shadowsockslinkgrpc="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"

clear
echo -e ""
echo -e "======-VMESS/VLESS/TROJAN-GO/SHADOWSHOCK-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path ws     : /xrayvws/xrayws/xraytrojanws"
echo -e "Path grpc   : /vmess-grpc/vless-grpc/trojan-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
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
echo -e "link vless WS"
echo -e "${NC}${GREEN} ${vlesslinkws} ${NC}"
echo -e "========================="
echo -e "link vless WS tls"
echo -e "${NC}${ORANGE} ${vlesslinkwstls} ${NC}"
echo -e "========================="
echo -e "link vless grpc"
echo -e "${NC}${BLUE}${vlesslinkgrpc} ${NC}"
echo -e "========================="
echo -e "link trojan WS tls"
echo -e "${NC}${ORANGE} ${trojanlinkwstls} ${NC}"
echo -e "========================="
echo -e "link trojan grpc"
echo -e "${NC}${BLUE} ${trojanlinkgrpc} ${NC}"
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
echo -e "======Custom Import Config From URL ======="
echo -e "URL V2RAYNG all trojan-vless-vmess : ${NC}${RED} http://${domain}:89/config-multiakun-$user.txt ${NC}" 
echo -e "===================================================="
echo -e                "AKCELL XRAY MULTI AKUN"
echo -e "===================================================="
