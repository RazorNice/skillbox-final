#!/bin/bash

set -e

apt update && apt upgrade -y
apt install -y ufw easy-rsa

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh

make-cadir /opt/easy-rsa
cd /opt/easy-rsa
./easyrsa init-pki
