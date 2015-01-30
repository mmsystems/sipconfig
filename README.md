# sipconfig
<H2><b>SIPCONFIG:</b> bash script to get simple IP/Network information</H2>

<b>You can execute this script as follows:</b><br>
$bash sipconfig.sh<br>
or<br>
$chmod u+x sipconfig.sh<br>
$./sipconfig.sh

<b>To install it, and only put sipconfig as a common command:</b><br>
$cp sipconfig.sh /usr/bin/sipconfig<br>
$chmod +x /usr/bin/sipconfig


<b>Output example:</b><br>
![sipconfig screenshoot](/sipconfig/raw/master/img/sipconfig.png)

- All active interfaces IP's.
- If a wifi interface is present and connected, show AP name.
- Default Gateway and interface used.
- Nameservers stored in /etc/resolv.conf.
