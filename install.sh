#!/bin/bash

# generating a new strong random password
NEW_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')
# setting a new password
sudo echo -e "${NEW_PASSWORD}\n${NEW_PASSWORD}" | passwd root

# install fail2ban 
# it will start working automatically
sudo apt update
sudo apt install -y fail2ban

# configuring ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
# generating a new random ports
NEW_SSH_PORT=$(shuf -i 2000-9999 -n 1)
NEW_HTTP_PORT=$(shuf -i 10000-29999 -n 1)
NEW_HTTPS_PORT=$(shuf -i 30000-65000 -n 1)
# allow ports and limit ssh
sudo ufw allow "${NEW_SSH_PORT}"
sudo ufw limit "${NEW_SSH_PORT}"
sudo ufw allow "${NEW_HTTP_PORT}"
sudo ufw allow "${NEW_HTTPS_PORT}"
# change ssh port to a new one
sudo sed -i "s/#Port 22/Port ${NEW_SSH_PORT}/" /etc/ssh/sshd_config
sudo systemctl restart ssh
# enable new ufw rules
echo "y" | sudo ufw enable

# install squid proxy
sudo apt install -y squid
# change default proxy http ports in config
sudo sed -i "s/http_port 43535/http_port ${NEW_HTTP_PORT}/" squid.conf
sudo sed -i "s/http_port 43536/http_port ${NEW_HTTPS_PORT}/" squid.conf
# replace default squid config file
sudo cp -fr squid.conf /etc/squid/squid.conf
sudo systemctl restart squid

# block port scan
sudo iptables -A port-scan -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN
sudo iptables -A port-scan -j DROP
sudo iptables -A specific-rule-set -p tcp --syn -j syn-flood
sudo iptables -A specific-rule-set -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j port-scan

# fix disable 2 way ping
sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1
echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.conf
sudo sysctl -p
sudo iptables -I INPUT -p icmp --icmp-type echo-request -j DROP

echo "Save this data:"
echo "New root password: ${NEW_PASSWORD}"
echo "SSH port: ${NEW_SSH_PORT}"
echo "proxy port 1: ${NEW_HTTP_PORT}"
echo "proxy port 2: ${NEW_HTTPS_PORT}"