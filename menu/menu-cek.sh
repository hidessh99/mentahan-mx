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
echo "║ 1. cek Akun Semua Akun (vmess,vless,trojan,shadowsock)          ║"
echo "║ 2. cek Akun Vmess                                               ║"
echo "║ 3. cek Akun Vless                                               ║"
echo "║ 4. cek Akun Trojan-go                                           ║"
echo "║ 5. cek akun Shadowsock                                          ║"
echo "║ 6. cek User Vmess                                               ║"
echo "║ 7. cek User Vless                                               ║"
echo "║ 8. cek User Trojan-go                                           ║"
echo "║ 9. cek User Shadowsock                                          ║"
echo "║ 10. Menu Utama                                                  ║"
echo "║ 11. Exit                                                        ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "Select From Options [ 1 - 7 ] : " xmenu
echo -e ""
case $xmenu in 
1)
cek-akun
;;
2)
cek-vmess
;;
3)
cek-vless
;;
4)
cek-trojan
;;
5)
cek-ss
;;
6)
cek-uservmess
;;
7)
cek-uservless
;;
8)
cek-usertrojan
;;
9)
cek-userss
;;
10)
clear
xmenu
;;
11)
clear
exit
;;
*)
clear
xmenu
;;
esac
