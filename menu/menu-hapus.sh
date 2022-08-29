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
echo "║                     ┃ XRAY XMENU HAPUS AKUN ┃                   ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Hapus Akun Semua Akun (vmess,vless,trojan,shadowsock)         ║"
echo "║ 2. Hapus Akun Vmess                                              ║"
echo "║ 3. Hapus Akun Vless                                              ║"
echo "║ 4. Hapus Akun Trojan-go                                          ║"
echo "║ 5. Hapus akun Shadowsock                                         ║"
echo "║ 6. Menu Utama                                                   ║"
echo "║ 7. Exit                                                         ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "     Select From Options [1-7 or x] :  " menu-hapus
case $menu-hapus in 
1)
delete-akun
;;
2)
delete-vmess
;;
3)
delete-vless
;;
4)
delete-trojan
;;
5)
delete-ss
;;
6)
clear
xmenu
;;
7)
clear
exit
;;
*)
clear
xmenu
;;
esac
