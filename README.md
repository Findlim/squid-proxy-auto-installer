# Squid proxy server automatic installer
Automatically configure squid proxy server for anonymous usage.  
Tested only on Ubuntu. Should work on Debian \ Ubuntu.  

> ⚠️ **Run this script only on empty servers.**  
This script changes the work of the firewall, so other software may not work correctly. It is recommended to use it only on empty servers that will be used only as a proxies.

## Usage
Install Git:  
`sudo apt update`  
`sudo apt-get install git`  
Clone this repo:  
`git clone https://github.com/oqo0/squid-proxy-auto-installer.git`  
Go to project directory:  
`cd squid-proxy-auto-installer/`  
Make the script executable:  
`sudo chmod +x install.sh`  
Run the script:  
`sudo ./install.sh`  