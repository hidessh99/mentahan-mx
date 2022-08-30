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
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done
	
#readakun
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

sed -i '/#trojanws$/a\# '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\# '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

sed -i '/#vless$/a\## '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\## '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
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
systemctl restart xray

#buatlinkvless
vlesslinkws=""vless://${uuid}@${domain}:80?path=/xrayws&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslinkwstls="vless://${uuid}@${domain}:443?path=/xrayws&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslinkgrpc="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

#buatlinkvmess
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslinkws="vmess://$(base64 -w 0 /etc/xray/vmess-$user-ws.json)"
vmesslinkwstls="vmess://$(base64 -w 0 /etc/xray/vmess-$user-wstls.json)"
vmesslinkgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-grpc.json)"

#buatlinktrojan
trojanlinkws="trojan://${uuid}@${domain}:443?path=/xraytrojanws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlinkgrpc="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"


#buatshadowsocks
cipher="aes-128-gcm"
sed -i '/#ssws$/a\#### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\#### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/xrayssws;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"
systemctl restart xray
rm -rf /tmp/log
rm -rf /tmp/log1
cat > /home/vps/public_html/ss-ws-$user.txt <<-END
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
END
cat > /home/vps/public_html/ss-grpc-$user.txt <<-END
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
END

#buatallakun
clear
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "====== XRAY MANTAP Multi Port=======" | tee -a /etc/log-create-user.log
echo -e "INFORMASI AKUN VPN XRAY" | tee -a /etc/log-create-user.log
echo -e "IP: $MYIP" | tee -a /etc/log-create-user.log
echo -e "Host/Domain: $domain" | tee -a /etc/log-create-user.log
echo -e "Password/ID: $uuid" | tee -a /etc/log-create-user.log
echo -e "====== Service Port =======" | tee -a /etc/log-create-user.log
echo -e "Websocket TLS  : 443" | tee -a /etc/log-create-user.log
echo -e "Websocket HTTP : 80" | tee -a /etc/log-create-user.log
echo -e "GRPC TLS       : 443" | tee -a /etc/log-create-user.log
echo -e "*Note OPOK: opok only supports coremeta"
echo -e "*Note SHADOWSOCKS: gunakan custom config atau plugin xray"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log

#buattrojan
echo -e "Protokol VPN: TROJAN" | tee -a /etc/log-create-user.log
echo -e "Network: WS/GRPC" | tee -a /etc/log-create-user.log
echo -e "====== Path =======" | tee -a /etc/log-create-user.log
echo -e "=> WS TLS : /xraytrojanws" | tee -a /etc/log-create-user.log
echo -e "=> GRPC   : trojan-grpc" | tee -a /etc/log-create-user.log
echo -e "=> OPOK   : ws://bugcom/xraytrojanws" | tee -a /etc/log-create-user.log
echo -e "====== Import Config From Clipboard =======" | tee -a /etc/log-create-user.log
echo -e "Link Config WS TLS   : $trojanlinkws" | tee -a /etc/log-create-user.log
echo -e "Link Config GRPC TLS : $trojanlinkgrpc" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log

#buatssc
echo -e "Protokol VPN: SHADOWSOCKS" | tee -a /etc/log-create-user.log
echo -e "Network: WS/GRPC" | tee -a /etc/log-create-user.log
echo -e "Method Cipers : aes-128-gcm" | tee -a /etc/log-create-user.log
echo -e "====== Path =======" | tee -a /etc/log-create-user.log
echo -e "=> WS TLS : /xrayssws" | tee -a /etc/log-create-user.log
echo -e "=> GRPC   : ss-grpc" | tee -a /etc/log-create-user.log
echo -e "=> OPOK   : ws://bugcom/xrayssws" | tee -a /etc/log-create-user.log
echo -e "======Custom Import Config From URL =======" | tee -a /etc/log-create-user.log
echo -e "URL Custom Config WS TLS   : http://${domain}:89/ss-ws-$user.txt" | tee -a /etc/log-create-user.log
echo -e "URL Custom Config GRPC TLS : http://${domain}:89/ss-grpc-$user.txt" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log

#buatvless
echo -e "Protokol VPN: VLESS" | tee -a /etc/log-create-user.log
echo -e "Network: WS/GRPC" | tee -a /etc/log-create-user.log
echo -e "====== Path =======" | tee -a /etc/log-create-user.log
echo -e "=> WS TLS : /xrayws" | tee -a /etc/log-create-user.log
echo -e "=> GRPC   : vless-grpc" | tee -a /etc/log-create-user.log
echo -e "=> OPOK   : ws://bugcom/xrayws" | tee -a /etc/log-create-user.log
echo -e "====== Import Config From Clipboard =======" | tee -a /etc/log-create-user.log
echo -e "Link Config WS TLS    : $vlesslinkws" | tee -a /etc/log-create-user.log
echo -e "Link Config GRPC TLS  : $vlesslinkgrpc" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log

#buatvmess
echo -e "Protokol VPN: VMESS" | tee -a /etc/log-create-user.log
echo -e "Alter ID: 0" | tee -a /etc/log-create-user.log
echo -e "Network: WS/GRPC" | tee -a /etc/log-create-user.log
echo -e "====== Path =======" | tee -a /etc/log-create-user.log
echo -e "=> WS TLS : /xrayvws" | tee -a /etc/log-create-user.log
echo -e "=> GRPC   : vmess-grpc" | tee -a /etc/log-create-user.log
echo -e "=> OPOK   : ws://bugcom/xrayvws" | tee -a /etc/log-create-user.log
echo -e "====== Import Config From Clipboard =======" | tee -a /etc/log-create-user.log
echo -e "Link Config WS TLS    : $vmesslinkws" | tee -a /etc/log-create-user.log
echo -e "Link Config GRPC TLS  : $vmesslinkgrpc" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log

echo -e "SCRIPT XRAYMULTI" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
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
echo -e "Path ws     : /xrayvws/xrayws/xraytrojanws"
echo -e "Path grpc   : /vmess-grpc/vless-grpc/trojan-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "link   vmess ws"
echo -e
echo -e "${vmesslinkws}"
echo -e
echo -e "========================="
echo -e "link   vmess ws tls"
echo -e
echo -e "${vmesslinkwstls}"
echo -e
echo -e "========================="
echo -e "link vmess grpc"
echo -e
echo -e "${vmesslinkgrpc}"
echo -e
echo -e "========================="
echo -e "link vless WS"
echo -e "${vlesslinkws}"
echo -e "========================="
echo -e "link vless WS tls"
echo -e "${vlesslinkwstls}"
echo -e "========================="
echo -e "link vless grpc"
echo -e "${vlesslinkgrpc}"
echo -e "========================="
echo -e "AKCELL XRAYMULTI"
