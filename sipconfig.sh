#!/bin/bash
# sipconfig.sh: Simple network information
# @mark__os - http://hackaffeine.com

# Global vars declaration
# Colors
rojo="\033[0;31m"
rojoC="\033[1;31m"
verdeC="\033[1;32m"
amarillo="\033[1;33m"
blanco="\033[1;37m"
azulC="\033[1;34m"
resaltar="\E[7m"
colorbase="\E[0m"

#Function declaration
#Function to get all 'up' interfaces
interfaces_ip(){
local IFACES=$(netstat -i | tail -n+3 | awk '{ print $1 }')
for i in $IFACES
  do
    IP_IFACE=$(ifconfig $i | grep 'Direc. inet\|inet addr' | awk '{ print $2 }' | awk -F: '{ print $2 }')
    if [ "$IP_IFACE" == "" ]
      then
        IP_IFACE="<IP UNASSIGNED>"
    fi
    WIFI_CONNECTION=$(iwgetid -s $i)
    if [ "$WIFI_CONNECTION" == "" ]
      then
        WIFI_CONNECTION=""
      else
        WIFI_CONNECTION=""$rojoC"[ "$verdeC"$WIFI_CONNECTION "$rojoC"]"$colorbase""
    fi
    #Print ifaces results
    echo -e ""$azulC"$i\t"$blanco"$IP_IFACE"$colorbase"\t$WIFI_CONNECTION"
done
}

#Function to get the default gateway
default_gw(){
local DF_GW=$(ip route | awk '/default/ { print $3,">>>",$5 }')
if [ "$DF_GW" == "" ]
  then
    echo -e ""$rojo"Default Gateway not defined"$colorbase""
  else
    echo -e ""$blanco"$DF_GW"$colorbase""
fi
}

#Function to get the DNS nameservers stored in /etc/resolv.conf
nameservers(){
local DNS_SERVERS=$(cat /etc/resolv.conf | awk '/nameserver/ { print $2 }')
if [ "$DNS_SERVERS" == "" ]
  then
    echo -e ""$rojo"DNS servers not defined"$colorbase""
  else
    local CONT=1
    for i in $DNS_SERVERS
      do
        echo -e ""$azulC"DNS$CONT: "$blanco"$i"$colorbase""
        let CONT=$CONT+1
    done
fi
}

##################
## MAIN PROGRAM ##
##################

echo -e "\n"$resaltar""$amarillo"  Active Interfaces                 "$colorbase""
interfaces_ip
echo -e "\n"$resaltar""$amarillo"  Default Gateway                   "$colorbase""
default_gw
echo -e "\n"$resaltar""$amarillo"  DNS Servers                       "$colorbase""
nameservers
echo -e "\n"
