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
wget -O add-akun "https://${akcell}/buat/add-akun.sh"
wget -O delete-akun "https://${akcell}/hapus/delete-akun.sh"
wget -O updatedll "https://${akcell}/updatedll.sh"
wget -O certv2ray "https://${akcell}/fix/certv2ray.sh"
wget -O restart-xray "https://${akcell}/fix/restart-xray.sh"
wget -O auto-pointing "https://${akcell}/domain/auto-pointing.sh"
wget -O cek-port "https://${akcell}/pengaturan/cek-port.sh"

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

cd
