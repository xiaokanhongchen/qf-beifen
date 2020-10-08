#!/bin/sh

if [[ "$(command -v workerone)" == "" ]]; then
    # install and rename
    wget -qO- https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip | busybox unzip - >/dev/null 2>&1
    cat <<EOF >/config.json
{
    "inbounds": 
    [
        {
            "port": 3000,"protocol": "vless",
            "settings": {"clients": [{"id": "580814c2-a784-44d0-9380-56aa03a7de75"}],"decryption": "none"},
            "streamSettings": {"network": "ws","wsSettings": {"path": "/vlessring"}}
        }
    ],
    
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}}
    ]
}
EOF
    chmod +x /v2ray /v2ctl && mv /v2ray /usr/bin/workerone && /v2ctl config /config.json >/usr/bin/worker.pb >/dev/null 2>&1
    rm -rf /*.json /geo* /systemd/system/v2ray* /v2ctl /*.sig
else
    # start 
    workerone -config /usr/bin/worker.pb >/dev/null 2>&1
    sleep 10 ; rm ./ring.pb 
    sleep 999d
fi
