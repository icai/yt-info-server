#!/bin/bash

export DOMAIN='api-yt.w3cub.com'
export EMAIL='gidcai@gmail.com'

init() {
    apt-get update


    # # install nginx
    if ! nginx -t 2>/dev/null; then 
        apt-get install -y nginx
        update-rc.d nginx defaults
    fi

    # # install nodejs
    # # https://github.com/nodesource/distributions/blob/master/README.md#deb

    if ! test -z "$node"; then 
        # nodejs
        echo "install nodejs ..."
        curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
        apt-get install -y nodejs
    fi

    if ! test -z "$pm2"; then 
        echo "install pm2 ... "
        # pm2
        npm install pm2 -g
    fi
    # npm install
    npm i

    if test -z "$pm2" && [[ -e "ecosystem.config.js" ]]; then
        echo "pm2 start ..."
        pm2 startup
        pm2 start ecosystem.config.js
        pm2 save
    else 
        echo "no found  ecosystem.config.js"
    fi

    # cp ./ytinfo.conf /etc/nginx/conf.d/ytinfo.conf

    # config hosts
    if ! grep -q "127.0.0.1	api-yt.w3cub.com" /etc/hosts; then 
        echo "127.0.0.1	api-yt.w3cub.com" >> /etc/hosts; 
    fi

}



config_nginx() {
    # install certbot
    # apt-get install dirmngr
    # apt-get install software-properties-common -y
    # add-apt-repository ppa:certbot/certbot -y
    # apt-get update
    # apt-get install python-certbot-nginx -y

    # certbot certonly --nginx --agree-tos -n -d $DOMAIN --email $EMAIL
# Update nginx config to enable https
cat >/etc/nginx/conf.d/$DOMAIN.conf << EOF
server {
    server_name ${DOMAIN};
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header X-Real-IP \$remote_addr;
    }
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
    listen          80;
    server_name     ${DOMAIN};
    return          301 https://\$server_name\$request_uri;
}
EOF

service nginx restart

# setup firewall
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT

}

if [ $(id -u) -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi

init
config_nginx

# copy nginx config
