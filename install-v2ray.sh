#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
########################}


clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
NC='\e[0m'
echo "v2ray Core Vmess / Vless / Trojan / Shadowsocks"
echo "Trojan"
echo "Progress..."
sleep 3

domain=$(cat /root/domain)
sleep 1
mkdir -p /etc/v2ray 
echo -e "[ ${green}INFO${NC} ] Checking... "
apt install iptables iptables-persistent -y
sleep 1
echo -e "[ ${green}INFO$NC ] Setting ntpdate"
ntpdate pool.ntp.org 
timedatectl set-ntp true
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chronyd"
systemctl enable chronyd
systemctl restart chronyd
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chrony"
systemctl enable chrony
systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
sleep 1
echo -e "[ ${green}INFO$NC ] Setting chrony tracking"
chronyc sourcestats -v
chronyc tracking -v
echo -e "[ ${green}INFO$NC ] Setting dll"
apt clean all && apt update
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
apt install zip -y
apt install curl pwgen openssl netcat cron -y


# install v2ray
sleep 1
echo -e "[ ${green}INFO$NC ] Downloading & Installing v2ray core"
domainSock_dir="/run/v2ray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
# Make Folder v2ray
mkdir -p /var/log/v2ray
mkdir -p /etc/v2ray
chown www-data.www-data /var/log/v2ray
chmod +x /var/log/v2ray
touch /var/log/v2ray/access.log
touch /var/log/v2ray/error.log
touch /var/log/v2ray/access2.log
touch /var/log/v2ray/error2.log
# / / Ambil v2ray Core Version Terbaru
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
ash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)


## crt v2ray
systemctl stop nginx
rm -rf /etc/nginx/conf.d/alone.conf

# nginx 
/etc/init.d/nginx stop

mkdir -p /home/vps/public_html

# set uuid
uuid9=$(cat /proc/sys/kernel/random/uuid)

uuid=b8458948-a630-4e6d-809a-230b2223ff3d

# v2ray config
cat > /etc/v2ray/config.json << END
{
  "log" : {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
    },
   {
     "listen": "/run/v2ray/vless_ws.sock",
     "protocol": "vless",
      "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"                 
#vless
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/v2rayws"
          }
        }
     },
     {
     "listen": "/run/v2ray/vmess_ws.sock",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/v2rayvws"
          }
        }
     },
    {
      "listen": "/run/v2ray/trojan_ws.sock",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",		
           "clients": [
              {
                 "password": "${uuid}"
#trojanws
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/v2raytrojanws"
            }
         }
     },
    {
         "listen": "127.0.0.1",
        "port": "30300",
        "protocol": "shadowsocks",
        "settings": {
           "clients": [
           {
           "method": "aes-128-gcm",
          "password": "${uuid}"
#ssws
           }
          ],
          "network": "tcp,udp"
       },
       "streamSettings":{
          "network": "ws",
             "wsSettings": {
               "path": "/v2rayssws"
           }
        }
     },	
      {
        "listen": "/run/v2ray/vless_grpc.sock",
        "protocol": "vless",
        "settings": {
         "decryption":"none",
           "clients": [
             {
               "id": "${uuid}"
#vlessgrpc
             }
          ]
       },
          "streamSettings":{
             "network": "grpc",
             "grpcSettings": {
                "serviceName": "vless-grpc"
           }
        }
     },
     {
      "listen": "/run/v2ray/vmess_grpc.sock",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessgrpc
             }
          ]
       },
       "streamSettings":{
         "network": "grpc",
            "grpcSettings": {
                "serviceName": "vmess-grpc"
          }
        }
     },
     {
        "listen": "/run/v2ray/trojan_grpc.sock",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
             "clients": [
               {
                 "password": "${uuid}"
#trojangrpc
               }
           ]
        },
         "streamSettings":{
         "network": "grpc",
           "grpcSettings": {
               "serviceName": "trojan-grpc"
         }
      }
   },
   {
    "listen": "127.0.0.1",
    "port": "30310",
    "protocol": "shadowsocks",
    "settings": {
        "clients": [
          {
             "method": "aes-128-gcm",
             "password": "${uuid}"
#ssgrpc
           }
         ],
           "network": "tcp,udp"
      },
    "streamSettings":{
     "network": "grpc",
        "grpcSettings": {
           "serviceName": "ss-grpc"
          }
       }
    }	
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END
rm -rf /etc/systemd/system/v2ray.service.d
cat <<EOF> /etc/systemd/system/v2ray.service
Description=v2ray Service
Documentation=https://github.com/v2fly
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/v2ray run -config /etc/v2ray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=1000000
LimitNOFILE=10000000

[Install]
WantedBy=multi-user.target

EOF
cat > /etc/systemd/system/runn.service <<EOF
[Unit]
Description=Trimakasih
After=network.target

[Service]
Type=simple
ExecStartPre=-/bin/mkdir -p /var/run/v2ray
ExecStart=/bin/chown www-data:www-data /var/run/v2ray
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

#nginx config
cat >/etc/nginx/conf.d/v2ray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name $domain;
             ssl_certificate /etc/v2ray/v2ray.crt;
             ssl_certificate_key /etc/v2ray/v2ray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF
sed -i '$ ilocation = /v2rayws' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_pass http://unix:/run/v2ray/vless_ws.sock;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation = /v2rayvws' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_pass http://unix:/run/xray/vmess_ws.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation = /xraytrojanws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_pass http://unix:/run/v2ray/trojan_ws.sock;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation = /xrayssws' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_pass http://127.0.0.1:30300;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation /' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_pass http://127.0.0.1:700;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/vless_grpc.sock;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/vmess_grpc.sock;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/trojan_grpc.sock;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sed -i '$ ilocation ^~ /ss-grpc' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i{' /etc/nginx/conf.d/v2ray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:30310;' /etc/nginx/conf.d/v2ray.conf
sed -i '$ i}' /etc/nginx/conf.d/v2ray.conf

sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart v2ray "
systemctl daemon-reload
systemctl enable v2ray
systemctl restart v2ray
systemctl restart nginx
systemctl enable runn
systemctl restart runn

sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "v2ray/Vmess"
yellow "v2ray/Vless"
yellow "v2ray/Trojan"
yellow "v2ray/Shadowsocks"


#done
clear
#rm -f ins-v2ray.sh
rm -f install-v2ray.sh
