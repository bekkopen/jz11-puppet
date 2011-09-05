#!/bin/bash
#
# Initialize a new puppet master
#
# bash < <(curl -s https://github.com/bekkopen/jz11-puppet/raw/master/init/master.sh)
#

PUBLIC_IP_ADDRESS=`ifconfig eth0 | awk -F':' '/inet addr/{split($2,_," ");print _[1]}'`

echo "Hostname (FQDN):"
read HOSTNAME

echo $HOSTNAME > /etc/hostname && hostname -F /etc/hostname
echo $PUBLIC_IP_ADDRESS `hostname` `hostname -s` >> /etc/hosts

apt-get -qq update && apt-get -qq -y install puppetmaster puppet git-core

if [[ -z "$(grep bring/puppet.git /etc/puppet/.git/config)" ]]; then
  test -d /etc/puppet && mv /etc/puppet /etc/puppet.orig
  git clone https://github.com/bekkopen/jz11-puppet /etc/puppet
  cd /etc/puppet
  git submodule init
  git submodule update
  cd -
fi

# Do more stuff...

exit 0