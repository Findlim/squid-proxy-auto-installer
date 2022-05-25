#!/bin/bash

# generating a new strong random password
NEW_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')
# setting a new password
sudo chpasswd <<<"root: ${NEW_PASSWORD}"

# install fail2ban 
# it will start working automatically
sudo apt update
sudo apt install fail2ban

# configuring ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
# generating a new random ports
NEW_SSH_PORT=$(shuf -i 2000-9999 -n 1)
NEW_HTTP_PORT=$(shuf -i 10000-29999 -n 1)
NEW_HTTPS_PORT=$(shuf -i 30000-65000 -n 1)
# allow this ports and limit ssh
sudo ufw allow NEW_SSH_PORT
sudo ufw limit NEW_SSH_PORT
sudo ufw allow NEW_HTTP_PORT
sudo ufw allow NEW_HTTPS_PORT
# change ssh port to a new one
sudo sed -i 's/#Port 22/#Port ${NEW_SSH_PORT}/' /etc/ssh/sshd_config
sudo systemctl restart ssh
# apply new ufw rules
sudo ufw enable

echo "Root password: ${NEW_PASSWORD}"
echo "SSH port: ${NEW_SSH_PORT}"