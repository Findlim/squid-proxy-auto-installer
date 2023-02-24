# Squid proxy server automatic installer
Automatically configure squid proxy server for anonymous usage.  
Tested only on Ubuntu. Should work on Debian \ Ubuntu.  

> ⚠️ **Run this script only on empty servers.**  
This script changes the work of the firewall, so other software may not work correctly. It is recommended to use it only on empty servers that will be used only as a proxies.

## Usage
Install Git:  
```
sudo apt update
sudo apt-get install git
```
Clone this repo:  
```
git clone https://github.com/Findlim/squid-proxy-auto-installer.git
```  
Go to project directory:  
```
cd squid-proxy-auto-installer/
```  
Make the script executable:  
```
sudo chmod +x install.sh
```  
Run the script:  
```
sudo ./install.sh
```  
After the script is executed, you will receive a message with information to connect to your server.  
Be sure to save this information.  
`New root password` is your new SSH password.  
`SSH port` is your new SSH port.  
If you want to connect to your server use: `ssh -p <SSH port> <Server IP>` and paste a new generated password.  
Also the script output shows 2 proxy ports: for HTTP and HTTPS traffic.  

```  
sudo apt update
sudo apt-get install git
git clone https://github.com/Findlim/squid-proxy-auto-installer.git
cd squid-proxy-auto-installer/
sudo chmod +x install.sh
sudo ./install.sh

```  
