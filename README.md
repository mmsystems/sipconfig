# sipconfig
SIPCONFIG: bash script to get simple IP/Network information

You can execute this script as follows:
$bash sipconfig.sh
or
$chmod u+x sipconfig.sh
$./sipconfig.sh

To install it, and only put sipconfig as a common command:
$cp sipconfig.sh /usr/bin/sipconfig
$chmod +x /usr/bin/sipconfig

Output example:

  Active Interfaces                 
eth0	192.168.2.2	
lo	127.0.0.1	
wlan2	192.168.0.148	[ HOME_WIFI ]

  Default Gateway                   
192.168.0.1 >>> wlan2

  DNS Servers                       
DNS1: 8.8.8.8
DNS2: 8.8.4.4
