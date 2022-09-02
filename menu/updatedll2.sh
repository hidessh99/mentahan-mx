#!/bin/bash
# ==========================================
cd
rm -r updatedll2
wget -O updatedll2 "https://raw.githubusercontent.com/arismuslimin/xraymulti/main/menu/updatedll2.sh"
rm -rf updatedll2

# hapus
cd /usr/bin
rm -rf vmenu
rm -rf set-br
rm -rf menu-backup
rm -rf menu-buat
rm -rf menu-hapus
rm -rf menu-update
rm -rf menu-pengaturan
rm -rf menu-fix
rm -rf menu-cek
rm -rf menu-domain
rm -rf updatedll2
rm -r updatedll2

#link hosting
akcell="raw.githubusercontent.com/arismuslimin/xraymulti/main/menu"

# download
cd /usr/bin
wget -O updatedll2 "https://${akcell}/updatedll2.sh"
wget -O vmenu "https://${akcell}/vmenu.sh"
wget -O set-br "https://${akcell}/set-br.sh"
wget -O menu-buat "https://${akcell}/menu-buat.sh"
wget -O add-akun "https://${akcell}/buat/add-akun.sh"
wget -O add-trojan "https://${akcell}/buat/add-trojan.sh"
wget -O add-vmess2 "https://${akcell}/buat/add-vmess2.sh"
wget -O add-vless "https://${akcell}/buat/add-vless.sh"
wget -O add-ss "https://${akcell}/buat/add-ss.sh"
wget -O menu-hapus "https://${akcell}/menu-hapus.sh"
wget -O delete-akun "https://${akcell}/hapus/delete-akun.sh"
wget -O delete-vmess "https://${akcell}/hapus/delete-vmess.sh"
wget -O delete-ss "https://${akcell}/hapus/delete-ss.sh"
wget -O delete-vless "https://${akcell}/hapus/delete-vless.sh"
wget -O delete-trojan "https://${akcell}/hapus/delete-trojan.sh"
wget -O menu-cek "https://${akcell}/menu-cek.sh"
wget -O cek-akun "https://${akcell}/cek/cek-akun.sh"
wget -O cek-vless "https://${akcell}/cek/cek-vless.sh"
wget -O cek-vmess "https://${akcell}/cek/cek-vmess.sh"
wget -O cek-trojan "https://${akcell}/cek/cek-trojan.sh"
wget -O cek-ss "https://${akcell}/cek/cek-ss.sh"
wget -O cek-uservmess "https://${akcell}/cek/cek-uservmess.sh"
wget -O menu-config "https://${akcell}/menu-config.sh"
wget -O add-configws "https://${akcell}/cek/add-configws.sh"
wget -O add-configwstrojan "https://${akcell}/cek/add-configwstrojan.sh"
wget -O add-configwsvless "https://${akcell}/cek/add-configwsvless.sh"
wget -O add-configwsvmess "https://${akcell}/cek/add-configwsvmess.sh"
wget -O add-configwsss "https://${akcell}/cek/add-configwsss.sh"
wget -O add-configsni "https://${akcell}/cek/add-configsni.sh"
wget -O add-configsnitrojan "https://${akcell}/cek/add-configsnitrojan.sh"
wget -O add-configsnivless "https://${akcell}/cek/add-configsnivless.sh"
wget -O add-configsnivmess "https://${akcell}/cek/add-configsnivmess.sh"
wget -O add-configsniss "https://${akcell}/cek/add-configsniss.sh"
wget -O menu-pengaturan "https://${akcell}/menu-pengaturan.sh"
wget -O cek-port "https://${akcell}/pengaturan/cek-port.sh"
wget -O limitspeed "https://${akcell}/pengaturan/limitspeed.sh"
wget -O menu-backup "https://${akcell}/menu-backup.sh"
wget -O menu-update "https://${akcell}/menu-update.sh"
wget -O menu-fix2 "https://${akcell}/menu-fix2.sh"
wget -O certv2ray2 "https://${akcell}/fix/certv2ray2.sh"
wget -O restart-v2ray "https://${akcell}/fix/restart-v2ray.sh"
wget -O menu-domain "https://${akcell}/menu-domain.sh"
wget -O auto-pointing "https://${akcell}/domain/auto-pointing.sh"


# permision
chmod +x /usr/bin/updatedll2
chmod +x /usr/bin/vmenu
chmod +x updatedll2
chmod +x vmenu
chmod +x set-br
chmod +x menu-buat
chmod +x add-akun
chmod +x add-trojan
chmod +x add-vmess2
chmod +x add-vless
chmod +x add-ss
chmod +x menu-hapus
chmod +x delete-akun
chmod +x delete-vmess
chmod +x delete-vless
chmod +x delete-trojan
chmod +x delete-ss
chmod +x menu-cek
chmod +x cek-akun
chmod +x cek-ss
chmod +x cek-trojan
chmod +x cek-vmess
chmod +x cek-vless
chmod +x cek-uservmess
chmod +x menu-config
chmod +x add-configws
chmod +x add-configwstrojan
chmod +x add-configwsvless
chmod +x add-configwsvmess
chmod +x add-configwsss
chmod +x add-configsni
chmod +x add-configsnitrojan
chmod +x add-configsnivless
chmod +x add-configsnivmess
chmod +x add-configsniss
chmod +x menu-update
chmod +x menu-pengaturan
chmod +x cek-port
chmod +x limitspeed
chmod +x menu-backup
chmod +x menu-fix2
chmod +x certv2ray2
chmod +x restart-v2ray
chmod +x menu-domain
chmod +x auto-pointing

cd
