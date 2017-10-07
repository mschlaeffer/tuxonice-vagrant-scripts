#!/usr/bin/env bash

SWAPFILE=1000

echo
echo '-----------------------------------------------------'
grep -q 'swapfile' /etc/fstab
if [ $? -ne 0 ]; then
    echo 'Create and add a new swap file.'
    fallocate -l ${SWAPFILE}M /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
    echo 'Swap file found, no changes made.'
fi

echo
echo '-----------------------------------------------------'
echo 'Swap file info:'
cat /proc/swaps
cat /proc/meminfo | grep Swap

echo
echo '-----------------------------------------------------'
echo 'Install packages to test TuxOnIce.'
apt install -y -V pm-utils stress

echo
echo '-----------------------------------------------------'
echo 'Install TuxOnIce UserUI from ppa.'
add-apt-repository -y ppa:tuxonice/ppa
add-apt-repository -y ppa:tuxonice/staging
apt update
apt install -y -V tuxonice-userui

echo
echo '-----------------------------------------------------'
echo 'Install TuxOnIce kernel from ppa.'
sed -i 's/trusty/artful/' /etc/apt/sources.list.d/*.list
apt update
apt install -y -V linux-generic-tuxonice
