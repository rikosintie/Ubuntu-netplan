
alias mw-nplan-apply='sudo netplan apply'
alias mw-networkd-restart='systemctl restart networkd-dispatcher.service'
alias mw-nplan-edit='nohup sudo gnome-text-editor /etc/netplan/01-netcfg.yaml &'
alias mw-nplan-br0='sudo netplan apply && until ip addr show dev wlp61s0 | grep -q "inet "; do sleep 0.5; done && ip a show dev br0 && ip route | grep default'
