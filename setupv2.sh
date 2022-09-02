#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
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
# =========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(wget -qO- ipinfo.io/ip);
clear
mkdir /var/lib/crot;
echo "IP=" >> /var/lib/crot/ipvps.conf
cd
#install tools/alat
wget https://raw.githubusercontent.com/arismuslimin/xraymulti/main/install-tools2.sh && chmod +x install-tools2.sh && ./install-tools2.sh
#Instal V2RAY
wget https://raw.githubusercontent.com/arismuslimin/xraymulti/main/install-v2ray.sh && chmod +x install-v2ray.sh && ./install-v2ray.sh
#install xmenu
wget https://raw.githubusercontent.com/arismuslimin/xraymulti/main/menu/updatedll2.sh && chmod +x updatedll2.sh && ./updatedll2.sh
#istall set br
wget https://raw.githubusercontent.com/arismuslimin/xraymulti/main/menu/set-br.sh && chmod +x set-br.sh && ./set-br.sh
#SELESAI
echo " "
echo "Installation has been completed!!"echo " "
echo "============================================================================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"  | tee -a log-install.txt
echo -e "    SCRIPT V2RAY Multi Port"           | tee -a log-install.txt
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - Nginx                      : 89"  | tee -a log-install.txt
echo "   - V2RAYS TROJAN WS TLS        : 443"  | tee -a log-install.txt
echo "   - V2RAYS SHADOWSOCKS WS TLS   : 443"  | tee -a log-install.txt
echo "   - V2RAYS VLESS WS TLS         : 443"  | tee -a log-install.txt
echo "   - V2RAYS VMESS WS TLS         : 443"  | tee -a log-install.txt
echo "   - V2RAYS TROJAN WS HTTP       : 80"  | tee -a log-install.txt
echo "   - V2RAYS SHADOWSOCKS WS HTTP  : 80"  | tee -a log-install.txt
echo "   - V2RAYS VLESS WS HTTP        : 80"  | tee -a log-install.txt
echo "   - V2RAYS VMESS WS HTTP        : 80"  | tee -a log-install.txt
echo "   - V2RAYS TROJAN GRPC          : 443"  | tee -a log-install.txt
echo "   - V2RAYS SHADOWSOCKS GRPC     : 443"  | tee -a log-install.txt
echo "   - V2RAYS VMESS GRPC           : 443"  | tee -a log-install.txt
echo "   - V2RAYS VLESS GRPC           : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo " Reboot 15 Sec"
sleep 15
cd
rm -rf updatedll2
rm -rf updatedll2.sh
rm -rf setupv2.sh
rm -rf install-v2ray.sh
rm -rf install-tools.sh
rm -rf set-br.sh
