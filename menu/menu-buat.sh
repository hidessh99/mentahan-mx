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
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                       ┃ Script By Akcell ┃                      ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                           085730123218                          ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                     ┃ XRAY XMENU BUAT AKUN ┃                    ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Buat Akun Semua Akun (vmess,vless,trojan,shadowsock)         ║"
echo "║ 2. Buat Akun Vmess                                              ║"
echo "║ 3. Buat Akun Vless                                              ║"
echo "║ 4. Buat Akun Trojan-go                                          ║"
echo "║ 5. Buat akun Shadowsock                                         ║"
echo "║ 6. Menu Utama                                                   ║"
echo "║ 7. Exit                                                         ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "     Select From Options [1-7 or x] :  " xmenu
echo -e ""
case $xmenu in 
1)
add-akun
;;
2)
add-vmess
;;
3)
add-vless
;;
4)
add-trojan
;;
5)
add-ss
;;
6)
clear
xmenu
;;
7)
clear
exit
*)
clear
xmenu
;;
esac
