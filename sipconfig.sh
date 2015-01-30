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
    local IP_IFACE=$(ifconfig $i | grep 'Direc. inet\|inet addr' | awk '{ print $2 }' | awk -F: '{ print $2 }')
    if [ "$IP_IFACE" == "" ]
      then
        local IP_IFACE=""$rojo"<UNASSIGNED>"
    fi
    local WIFI_CONNECTION=$(iwgetid -s $i)
    if [ "$WIFI_CONNECTION" != "" ]
      then
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

internet_communication(){
#Check ping to IP
ping -s 0 -c 1 -W 1 8.8.8.8 > /dev/null 2>&1
if [ "$?" == "0" ]
  then
    PING_STATUS="YES"
  else
    PING_STATUS="NO"
fi
#Check ping to DNS name
ping -s 0 -c 1 -W 1 google.com > /dev/null 2>&1
if [ "$?" == "0" ]
  then
    DNS_STATUS="YES"
  else
    DNS_STATUS="NO"
fi

if [ "$PING_STATUS" == "YES" ]
  then
    COLOR_P=""$verdeC""
  else
    COLOR_P=""$rojoC""
fi
if [ "$DNS_STATUS" == "YES" ]
  then
    COLOR_D=""$verdeC""
  else
    COLOR_D=""$rojoC""
fi
if [ "$PING_STATUS" == "YES" ] && [ "$DNS_STATUS" == "YES" ]
  then
    EXT_IP=""$azulC"External IP: "$blanco"$(wget -q -O- ident.me)"$colorbase""
fi
echo -e ""$azulC"Internet connection: "$COLOR_P"$PING_STATUS"$colorbase""
echo -e ""$azulC"DNS name resolution: "$COLOR_D"$DNS_STATUS"$colorbase""
echo -e "$EXT_IP"
}

##################
## MAIN PROGRAM ##
##################

#Run in loop mode
if [ "$1" == "-l" ]
  then
    if [ "$2" != "" ]
      then
        TIME_TO_SLEEP=$2
      else
        #Default time to sleep
        TIME_TO_SLEEP=10
    fi
    while [ true ]
      do
        clear
        echo -e ""$rojoC"\tPress CTRL+C to EXIT"$colorbase""
        $0 -c
        sleep $TIME_TO_SLEEP
    done
fi

echo -e "\n"$resaltar""$amarillo"  Active Interfaces                 "$colorbase""
interfaces_ip
echo -e "\n"$resaltar""$amarillo"  Default Gateway                   "$colorbase""
default_gw
echo -e "\n"$resaltar""$amarillo"  DNS Servers                       "$colorbase""
nameservers

#Only check internet connection if -c flag is set
if [ "$1" == "-c" ]
  then
    echo -e "\n"$resaltar""$amarillo"  Internet Communication            "$colorbase""
    internet_communication
fi
echo -e "\n"

