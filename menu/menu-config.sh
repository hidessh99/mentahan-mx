#!/bin/bash
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 INFO SERVER                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
#clear
if [ "$cekup" = "day" ]; then
echo -e "System Uptime   :  $uphours $upminutes $uptimecek"
else
echo -e "System Uptime   :  $uphours $upminutes"
fi
echo -e "IP-VPS          :  $IPVPS"
echo -e "ISP-VPS         :  $ISPVPS"

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
read -p "Select From Options [ 1 - 7 ] : " xmenu
echo -e ""
case $xmenu in 
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
