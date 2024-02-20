#!/bin/bash
ifconf=$(ifconfig | grep flags)
#echo $ifconf
IFS=$'\n'
mass+=(  $ifconf)
unset IFS
#echo ${mass[1]}
names=()
for t in "${mass[@]}"; do
IFS=':' read -ra my_array <<<"$t"
#echo ${my_array[0]}
names+=(${my_array[0]})
done
i=1
echo "select interface to control:"
for t in "${names[@]}"; do 
    echo $i')' $t
    i=$((i+1))
done
read interName

interface=${names[$((interName-1))]}
echo "interface" $interface
#echo "enter IP address to control in interface"
#read ipadd
#ipadd="192.168.0.4"
while true
 do
output=$(ifconfig $interface| grep inet)
if [[ ! $output == *"inet "* ]]; then
echo "IPv4 address not detected"
dhclient -r $interface
dhclient $interface
echo "IPv4 address add"
else
echo "everything OK"
fi
done