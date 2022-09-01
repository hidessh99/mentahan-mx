#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl ipinfo.io/ip | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Fuck You!!"
exit 0
fi
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "VMESS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VMESS WS HTTP" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m           XRAY ALL ACCOUNT          \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[0;41;36m           XRAY ALL ACCOUNT          \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on xmenu"
			xmenu
		fi
	done
#notes	
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
t="trojan"
v="vmess"
l="vless"
s="shadowsock"
g="grpc"
#buatdatamultiakun
cat>/etc/xray/config-multi.json<<EOF
#multiakun
EOF
cd
sed -i '/#multiakun$/a\# '"$user $exp $hariini $uuid $t"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config-multi.json
#buattrojan
sed -i '/#trojanws$/a\# '"$user $exp $hariini $uuid $t"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\# '"$user $exp $hariini $uuid $t $g"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
#buatvless
sed -i '/#vless$/a\## '"$user $exp $hariini $uuid $l"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\## '"$user $exp $hariini $uuid $l $g"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
#buatvmess
sed -i '/#vmess$/a\### '"$user $exp $hariini $uuid $v"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp $hariini $uuid $v $g"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-ws.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xrayvws",
      "type": "none",
      "host": "${domain}",
      "tls": ""
}
EOF
cat>/etc/xray/vmess-$user-wstls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xrayvws",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-grpc.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
#buatshadowsocks
cipher="aes-128-gcm"
sed -i '/#ssws$/a\#### '"$user $exp $hariini $uuid $s"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\#### '"$user $exp $hariini $uuid $s $g"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json

systemctl restart xray
service cron restart
rm -rf /tmp/log
rm -rf /tmp/log1
cat > /home/vps/public_html/ss-ws-$user.txt<<EOF
{ 
 "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        },
        "wsSettings": {
          "headers": {
            "Host": "$domain"
          },
          "path": "/xrayssws"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
EOF
cat > /home/vps/public_html/ss-grpc-$user.txt<<EOF
{
    "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "grpcSettings": {
          "multiMode": true,
          "serviceName": "ss-grpc"
        },
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
EOF
cd

#buatlinktrojan
trojanlinkwstls="trojan://${uuid}@${domain}:443?path=/xraytrojanws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlinkgrpc="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"

#buatlinkvless
vlesslinkws="vless://${uuid}@${domain}:80?path=/xrayws&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslinkwstls="vless://${uuid}@${domain}:443?path=/xrayws&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslinkgrpc="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

#buatlinkvmess
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslinkws="vmess://$(base64 -w 0 /etc/xray/vmess-$user-ws.json)"
vmesslinkwstls="vmess://$(base64 -w 0 /etc/xray/vmess-$user-wstls.json)"
vmesslinkgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-grpc.json)"

#buatlinkshadowsock
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/xrayssws;host=$domain;tls#${user}"
shadowsockslinkgrpc="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"
#buat text all link
clear
cat > /home/vps/public_html/xraymultiakun-$user.txt<<EOF
${trojanlinkwstls}
${trojanlinkgrpc}
${vlesslinkws}
${vlesslinkwstls}
${vlesslinkgrpc}
${vmesslinkws}
${vmesslinkwstls}
${vmesslinkgrpc}
EOF
cd
clear
echo -e ""
echo -e "======-VMESS/VLESS/TROJAN-GO/SHADOWSHOCK-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path ws     : /xrayvws/xrayws/xraytrojanws/xrayssws"
echo -e "Path grpc   : /vmess-grpc/vless-grpc/trojan-grpc/ss-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "link   vmess ws"
echo -e
echo -e "${NC}${GREEN} ${vmesslinkws} ${NC}"
echo -e
echo -e "========================="
echo -e "link   vmess ws tls"
echo -e
echo -e "${NC}${ORANGE} ${vmesslinkwstls} ${NC}"
echo -e
echo -e "========================="
echo -e "link vmess grpc"
echo -e
echo -e "${NC}${BLUE} ${vmesslinkgrpc} ${NC}"
echo -e
echo -e "========================="
echo -e "link vless WS"
echo -e "${NC}${GREEN} ${vlesslinkws} ${NC}"
echo -e "========================="
echo -e "link vless WS tls"
echo -e "${NC}${ORANGE} ${vlesslinkwstls} ${NC}"
echo -e "========================="
echo -e "link vless grpc"
echo -e "${NC}${BLUE}${vlesslinkgrpc} ${NC}"
echo -e "========================="
echo -e "link trojan WS tls"
echo -e "${NC}${ORANGE} ${trojanlinkwstls} ${NC}"
echo -e "========================="
echo -e "link trojan grpc"
echo -e "${NC}${BLUE} ${trojanlinkgrpc} ${NC}"
echo -e "========================="
echo -e "link shadowshock"
echo -e "${NC}${ORANGE} ${shadowsockslink} ${NC}"
echo -e "========================="
echo -e "link shadowshock grpc"
echo -e "${NC}${BLUE} ${shadowsockslinkgrpc} ${NC}"
echo -e "========================="
echo -e "======Custom Import Config From URL ======="
echo -e "URL Custom Config WS TLS   : ${NC}${ORANGE} http://${domain}:89/ss-ws-$user.txt ${NC}" 
echo -e "URL Custom Config GRPC TLS : ${NC}${BLUE} http://${domain}:89/ss-grpc-$user.txt ${NC}"
echo -e "======Custom Import Config From URL ======="
echo -e "URL V2RAYNG all trojan-vless-vmess : ${NC}${RED} http://${domain}:89/xraymultiakun-$user.txt ${NC}" 
echo -e "===================================================="
echo -e                "AKCELL XRAY MULTI AKUN"
echo -e "===================================================="
