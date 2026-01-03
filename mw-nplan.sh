# verify that netplan is working with 
#NetWorkManager for wifi
#networkd for ethternet
mw-nplan() {
	printf "\e[31m         Check that route metrics are correct\e[0m\n"
	printf "\n"
	ip route | grep default
	printf "--------------------\n"
	printf "\n"
	# Verify that both interfaces work
	wintf=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
	printf "\e[31m         ping 8.8.8.8 from Interface wlp61s0\e[0m\n"
	printf "\n"
	# ping -I wlp61s0 -c 3 8.8.8.8  # WiFi
	ping -I $wintf -c 3 8.8.8.8 # WiFi
	sleep 3
	printf "\n"
	printf "---------------------\n"
	printf "\n"
	printf "\e[31m         ping 8.8.8.8 from Interface br0\e[0m\n"
	printf "\n"

	ping -I br0 -c 3 8.8.8.8      # Ethernet (when plugged in)
	printf "/n"
	printf "---------------------\n"
	sleep 3
	printf "\n"
	printf "\e[31m         Check DNS resolution\e[0m\n"
	printf "\n"
	resolvectl status $wintf
    printf "----------\n"
    printf "\n"
    printf "--------------------\n"
    resolvectl status br0
}
