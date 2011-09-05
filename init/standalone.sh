#!/bin/bash
#
# Initialize a new puppet standalone machine
#
# bash < <(curl -s https://github.com/bekkopen/jz11-puppet/raw/master/init/standalone.sh)
#

SQUEEZE_REPO="deb http://ukdebian.mirror.anlx.net/debian/ squeeze main contrib"

echo $SQUEEZE_REPO > /etc/apt/sources.list
cat > /etc/apt/apt.conf << 'EOF'
APT {
  Install-Recommends "false";
};
EOF

PUBLIC_IP_ADDRESS=`ifconfig eth0 | awk -F':' '/inet addr/{split($2,_," ");print _[1]}'`

echo "Hostname (FQDN):"
read HOSTNAME

echo $HOSTNAME > /etc/hostname && hostname -F /etc/hostname
echo $PUBLIC_IP_ADDRESS `hostname` `hostname -s` >> /etc/hosts

apt-get -qq update && apt-get -qq -y install puppet

git clone https://github.com/bekkopen/jz11-puppet /root/jz-puppet
cd /root/jz-puppet
git submodule update --init
