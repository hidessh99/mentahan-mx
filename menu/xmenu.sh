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
echo "║                          ┃ XRAY XMENU ┃                         ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Buat Semua Akun XRAY   ┃ 11.CARA POINTING DOMAIN             ║"
echo "║ 2. Hapus Akun XRAY        ┃ 12.Auto Pointing Subdomain          ║"
echo "║ 3. Cek Nama Domain        ┃ 13.Test Kecepatan Server            ║"
echo "║ 4. Cek IP Publik          ┃ 14.Backup                           ║"
echo "║ 5. Update DLL             ┃ 15.Auto Backup                      ║"
echo "║ 6. XRAY UPDATE Core       ┃ 16.Restore                          ║"
echo "║ 7. XRAY UPDATE SCRIPT     ┃ 17.Cek Semua Layanan Port           ║"
echo "║ 8. Hidupkan Ulang Xray    ┃ 18.Info Script                      ║"
echo "║ 9. Perbarui Sertifikat    ┃ 19.Hidupkan Ulang VPS               ║"
echo "║ 10.Tambahkan Domain       ┃ 20.Keluar Dari Menu                 ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "     Select From Options [1-69 or x] :  " xmenu
case $xmenu in 
1)
add-akun
;;
2)
delete-akun
;;
3)
cat /etc/xray/domain
;;
4)
curl -s ipinfo.io/ip
;;
5)
updatedll
;;
6)
updatecore
;;
7)
updatesc
;;
8)
restart-xray
;;
9)
certv2ray
;;
10)
add-domain
;;
11)
how-pointing
;;
12)
speedtest
;;
13)
reboot
;;
14)
exit
;;
15)
cat /root/log-install.txt
;;
16)
auto-pointing
;;
17)
cek-port
;;
*)
echo "Input The Correct Number !"
;;
esac
