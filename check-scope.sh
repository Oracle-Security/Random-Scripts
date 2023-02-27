#!/bin/bash

#By Oracle :)

ips=()
while IFS= read -r line; do
    ips+=("$line")
done < ip_scope.txt

while IFS= read -r subdomain; do
    while IFS= read -r ip; do
        if [[ " ${ips[@]} " =~ " ${ip} " ]]; then
            echo "[+] $subdomain($ip) Is in scope!"
        else
            echo "[-] $subdomain($ip) Is not in scope!"
        fi
    done < <(nslookup $subdomain | grep 'Address: ' | awk '{print $2}')
done < sorted_domains.txt > check-scope.txt
