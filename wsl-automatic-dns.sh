#!/bin/bash


default_dns=8.8.8.8

change_dns () {
      sudo chattr -i /etc/resolv.conf
                              # This makes sure it is unix
      echo "nameserver $1" | sed -e "s/\r//g" | sudo dd status=none of=/etc/resolv.conf
      sudo chattr +i /etc/resolv.conf
      echo "Setting DNS server to $1"
}

# Makes sure that it is running in WSL
if grep -qi microsoft /proc/version; then
   if $(powershell.exe ipconfig /all | grep -q "Cisco AnyConnect") || $(powershell.exe ipconfig /all | grep -q "eduroam"); then
      DNS=$(powershell.exe Get-DnsClientServerAddress | grep "Wi-Fi" | head -1 | awk '{print substr($4,2,13)}')
      change_dns $DNS
   else
      change_dns $default_dns
   fi
fi
