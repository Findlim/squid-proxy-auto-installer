#!/bin/bash

# generating a new strong random password
NEW_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')
# setting a new password
sudo chpasswd <<<"root: ${NEW_PASSWORD}"

# install fail2ban 
# it will start working automatically
sudo apt update
sudo apt install fail2ban




echo "Root password: ${NEW_PASSWORD}"