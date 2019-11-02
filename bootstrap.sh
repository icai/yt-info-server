function init {
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

    cp ./ytinfo.conf /etc/nginx/conf.d/ytinfo.conf

    # config hosts
    if ! grep -q "127.0.0.1	api-yt.w3cub.com" /etc/hosts; then 
        echo "127.0.0.1	api-yt.w3cub.com" >> /etc/hosts; 
    fi


    # setup firewall

    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT

    service nginx restart
}

if [[ $(id -u) -ne 0 ]]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi

init

# copy nginx config




