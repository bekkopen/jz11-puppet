#!/bin/bash
#
# Initialize a new puppet agent
#
# bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/agent.sh)
#

if [[ -z $HOSTNAME ]]; then
  echo "ERROR: You need to export HOSTNAME=desired.fqdn.host"
  exit 1
fi

SQUEEZE_REPO="deb http://ukdebian.mirror.anlx.net/debian/ squeeze main contrib"

echo $SQUEEZE_REPO > /etc/apt/sources.list
cat > /etc/apt/apt.conf << 'EOF'
APT {
  Install-Recommends "false";
};
EOF

PUBLIC_IP_ADDRESS=`ifconfig eth0 | awk -F':' '/inet addr/{split($2,_," ");print _[1]}'`

echo $HOSTNAME > /etc/hostname && hostname -F /etc/hostname
echo $PUBLIC_IP_ADDRESS `hostname` `hostname -s` >> /etc/hosts

apt-get -qq update && apt-get -qq -y install puppet
