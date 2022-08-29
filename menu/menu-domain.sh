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
echo "║                     ┃ XRAY XMENU DOMAIN ┃                       ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Ganti Nama Domain                                            ║"
echo "║ 2. Auto Pointing Domain                                         ║"
echo "║ 3. Bagaimana Cara Pointing Domain                               ║"
echo "║ 4. Cek Nama Domain                                              ║"
echo "║ 5. Tes Domain                                                   ║"
echo "║ 6. Menu Utama                                                   ║"
echo "║ 7. Exit                                                         ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "     Select From Options [1-7 or x] :  " xmenu
case $xmenu in 
1)
new-domain
;;
2)
add-domain
;;
3)
how-domain
;;
4)
cek-domain
;;
5)
tes-domain
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
