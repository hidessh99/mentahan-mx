#!/bin/bash
# SL
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
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# BEGIN_Backup" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
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
clear
echo -e "=============================="
echo -e "     Auto Config V2ray     "
echo -e "=============================="
echo -e "1. Ganti Bug WS"
echo -e "2. Ganti Bug SNI"
echo -e "3. Buat Config WS "
echo -e "4. Buat Config SNI"
echo -e "5. Infobug"
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
;;
esac
