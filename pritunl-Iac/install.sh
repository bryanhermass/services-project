#!/bin/bash

sudo tee /etc/apt/sources.list.d/mongodb-org.list << EOF
deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse
EOF

sudo tee /etc/apt/sources.list.d/openvpn.list << EOF
deb [ signed-by=/usr/share/keyrings/openvpn-repo.gpg ] https://build.openvpn.net/debian/openvpn/stable noble main
EOF

sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb [ signed-by=/usr/share/keyrings/pritunl.gpg ] https://repo.pritunl.com/unstable/apt noble main
EOF

sudo apt --assume-yes install gnupg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor --yes
curl -fsSL https://swupdate.openvpn.net/repos/repo-public.gpg | sudo gpg -o /usr/share/keyrings/openvpn-repo.gpg --dearmor --yes
curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo gpg -o /usr/share/keyrings/pritunl.gpg --dearmor --yes

sudo ufw disable
sudo apt update
sudo apt --assume-yes install pritunl mongodb-org wireguard-tools
sudo systemctl start mongod pritunl
sudo systemctl enable mongod pritunl
sudo systemctl stop pritunl

## Manual Section ## 
# While installing, if a service is listening on port 80, it needs to be disabled because Let's Encrypt needs it.
# sudo apt update -y 
# sudo apt install certbot -y 
# sudo certbot certonly --standalone -d pritunl.bhernandez.org

#!/bin/bash
# Renew certificate
# certbot renew
# systemctl restart pritunl

