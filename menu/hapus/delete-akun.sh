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
NUMBER_OF_CLIENTS=$(grep -c -E "^# " "/etc/xray/config.json")
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
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
sed -i "/^# $user $exp $hariini $uuid $tlvs/,/^},{/d" /etc/xray/config.json
sed -i "/^## $user $exp $hariini $uuid $tlvs/,/^},{/d" /etc/xray/config.json
sed -i "/^### $user $exp $hariini $uuid $tlvs/,/^},{/d" /etc/xray/config.json
sed -i "/^#### $user $exp $hariini $uuid $tlvs/,/^},{/d" /etc/xray/config.json
sed -i "/^# $user $exp $hariini $uuid $tlvs $g/,/^},{/d" /etc/xray/config.json
sed -i "/^## $user $exp $hariini $uuid $tlvs $g/,/^},{/d" /etc/xray/config.json
sed -i "/^### $user $exp $hariini $uuid $tlvs $g/,/^},{/d" /etc/xray/config.json
sed -i "/^#### $user $exp $hariini $uuid $tlvs $g/,/^},{/d" /etc/xray/config.json
rm -f /etc/xray/vmess-$user-ws.json
rm -f /etc/xray/vmess-$user-wstls.json
rm -f /etc/xray/vmess-$user-grpc.json
rm -f /home/vps/public_html/ss-ws-$user.txt
rm -f /home/vps/public_html/ss-grpc-$user.txt
rm -f /home/vps/public_html/xraymultiakun$user.txt
rm -f /home/vps/public_html/config-multiakun$user.txt
systemctl restart xray.service
service cron restart
clear
echo ""
echo "==============================="
echo -e "${NC}${GREEN}XRAY MULTI AKUN BERHASIL DI HAPUS${NC}"
echo "==============================="
echo "Username  : $user"
echo "Expired   : $exp"
echo "==============================="
echo "AKCELL MULTI AKUN"
sleep 3
clear
menu-hapus
