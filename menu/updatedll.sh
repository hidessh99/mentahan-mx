#!/bin/bash
# ==========================================
cd
rm -r updatedll
wget -O updatedll "https://raw.githubusercontent.com/arismuslimin/xraymulti/main/menu/updatedll.sh"
rm -rf updatedll

# hapus
cd /usr/bin
rm -rf xmenu
rm -rf updatedll
rm -r updatedll

#link hosting
akcell="raw.githubusercontent.com/arismuslimin/xraymulti/main/menu"

# download
cd /usr/bin
wget -O xmenu "https://${akcell}/xmenu.sh"
wget -O add-akun "https://${akcell}/add-akun.sh"
wget -O delete-akun "https://${akcell}/delete-akun.sh"
wget -O updatedll "https://${akcell}/updatedll.sh"
wget -O certv2ray "https://${akcell}/certv2ray.sh"
wget -O restart-xray "https://${akcell}/restart-xray.sh"
wget -O auto-pointing "https://${akcell}/auto-pointing.sh"
wget -O cek-port "https://${akcell}/cek-port.sh"
wget -O autobackup "https://${akcell}/autobackup.sh"
wget -O backup "https://${akcell}/backup.sh"
wget -O restore "https://${akcell}/restore.sh"
wget -O strt "https://${akcell}/strt.sh"
wget -O limitspeed "https://${akcell}/limitspeed.sh"

# permision
chmod +x /usr/bin/updatedll
chmod +x /usr/bin/xmenu
chmod +x xmenu
chmod +x add-akun
chmod +x delete-akun
chmod +x updatedll
chmod +x certv2ray
chmod +x restart-xray
chmod +x auto-pointing
chmod +x cek-port
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x strt
chmod +x limitspeed

cd
