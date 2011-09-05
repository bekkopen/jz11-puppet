#!/bin/bash
#
# Initialize a new puppet agent
#
# bash < <(curl -s https://github.com/bekkopen/jz11-puppet/raw/master/init/agent.sh)
#

PUBLIC_IP_ADDRESS=`ifconfig eth0 | awk -F':' '/inet addr/{split($2,_," ");print _[1]}'`

echo "Hostname (FQDN):"
read HOSTNAME

echo $HOSTNAME > /etc/hostname && hostname -F /etc/hostname
echo $PUBLIC_IP_ADDRESS `hostname` `hostname -s` >> /etc/hosts

apt-get -qq update && apt-get -qq -y install puppet
