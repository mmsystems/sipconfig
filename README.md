# sipconfig
SIPCONFIG: bash script to get simple IP/Network information

<b>You can execute this script as follows:</b>

$bash sipconfig.sh
or
$chmod u+x sipconfig.sh
$./sipconfig.sh

<b>To install it, and only put sipconfig as a common command:</b>

$cp sipconfig.sh /usr/bin/sipconfig
$chmod +x /usr/bin/sipconfig


<b>Output example:</b>

  Active Interfaces                 
eth0	192.168.2.2	
lo	127.0.0.1	
wlan2	192.168.0.148	[ HOME_WIFI ]

  Default Gateway                   
192.168.0.1 >>> wlan2

  DNS Servers                       
DNS1: 8.8.8.8
DNS2: 8.8.4.4

![sipconfig screenshoot](https://github.com/mmsystems/sipconfig/raw/master/sipconfig.png)
