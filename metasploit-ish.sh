#!/bin/sh
#
# (c) 2021 Toshiyuki Fujioka
#
# Configure metasploit to run as $USER
#

echo "*** METASPLOIT INSTALL FOR ALPINE LINUX ***"
echo
echo "==> Account configuration."
echo "Username : "
read USER
adduser $USER
echo
echo "The user $USER will be automatically added among sudoers with all permissions"
echo
echo "$USER     ALL=(ALL:ALL) ALL" >> /etc/sudoers

apk update && apk upgrade
apk add --progress alpine-sdk ruby-dev libffi-dev\
        openssl-dev readline-dev sqlite-dev \
        autoconf bison libxml2-dev postgresql-dev \
        libpcap-dev yaml-dev subversion git sqlite \
        ruby-bundler zlib-dev ruby-io-console \
        ruby-bigdecimal \
        ncurses ncurses-dev nmap

gem install -N wirble sqlite3 bundler rake
gem install -N activesupport activerecord webrobots nokogiri Ascii85

#mkdir -p /opt && cd /opt
#
# git clone https://github.com/rapid7/metasploit-framework.git
#
#cd metasploit-framework
#
cat - <<-EOF | su $USER
cd /home/$USER
wget https://github.com/rapid7/metasploit-framework/archive/refs/heads/master.zip
unzip -q master.zip

mv metasploit-framework-master/ metasploit-framework
mv metasploit-framework/ /home/$USER/.

cd /home/$USER/metasploit-framework

mkdir /home/$USER/.msf4
mkdir /home/$USER/.bundle

bundle install

echo "export PATH=/home/$USER/metasploit-framework:$PATH" > /home/$USER/.bash_profile

EOF
