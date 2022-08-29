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
echo "║                       ┃ XRAY XMENU UTAMA ┃                      ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Buat Akun                                                    ║"
echo "║ 2. Hapus Akun                                                   ║"
echo "║ 3. Menu Pengaturan                                              ║"
echo "║ 4. Menu Backup                                                  ║"
echo "║ 5. Menu Domain                                                  ║"
echo "║ 6. Menu fix                                                     ║"
echo "║ 7. Menu Update                                                  ║"
echo "║ 8. Speedtest vps                                                ║"
echo "║ 9. Reboot vps                                                   ║"
echo "║ 10.Exit                                                         ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "     Select From Options [1-99 or x] :  " xmenu
case $xmenu in 
1)
clear
menu-buat
;;
2)
clear
menu-hapus
;;
3)
clear
menu-pengaturan
;;
4)
clear
menu-backup
;;
5)
clear
menu-domain
;;
6)
clear
menu-fix
;;
7)
clear
menu-update
;;
8)
clear
speedtest
;;
9)
clear
reboot
;;
10)
clear
exit
;;
*)
clear
xmenu
;;
esac
