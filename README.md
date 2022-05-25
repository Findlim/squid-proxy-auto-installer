# Squid proxy server automatic installer

> ⚠️ **Run this script only on empty servers.**  
This script changes the work of the firewall, so other software may not work correctly. It is recommended to use it only on empty servers that will be used only as a proxies.

`sudo apt update`  
`sudo apt-get install git`  
`git clone https://github.com/oqo0/squid-proxy-auto-installer.git .`  
`sudo chmod +x install.sh`  
`sudo ./install.sh`  

squid fix
downloads yes
ufw yes