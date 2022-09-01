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
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d");
cd
clear
function bugws() {
rm -rf /etc/xray/bugws
echo "Please enter your bugws"
read -rp "Bugws : " -e bugws
cat <<EOF>>/etc/xray/bugws
$bugws
EOF
}
function bugsni() {
rm -rf /etc/xray/bugsni
echo "Please enter your bugsni"
read -rp "Bugsni : " -e bugsni
cat <<EOF>>/etc/xray/bugsni
$bugsni
EOF
}
cd
clear
echo -e "=============================="
echo -e     "    AUTO CONFIG    "
echo -e "=============================="
echo -e "1. Isi Bug ws"
echo -e "2. Isi Bug sni"
echo -e "3. Buat Config WS"
echo -e "4. Buat Config SNI"
echo -e "5. Info Bug"
echo -e "=============================="
read -rp "Please Enter The Correct Number : " -e num
case $num in
1)
bugws
;;
2)
bugsni
;;
3)
add-configws
;;
4)
add-configsni
;;
5)
infobug
;;
*)
clear
xmenu
;;
esac
