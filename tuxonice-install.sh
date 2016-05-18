#!/usr/bin/env bash

SWAPFILE=1000

grep -q "swapfile" /etc/fstab
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

echo 'Swap file info:'
cat /proc/swaps
cat /proc/meminfo | grep Swap

echo 'Install TuxOnIce kernel package using ppa.'
add-apt-repository -y ppa:tuxonice/ppa
add-apt-repository -y ppa:tuxonice/staging
apt-get update
apt-get install -y -V linux-generic-tuxonice tuxonice-userui

echo 'Install additional packages to test TuxOnIce.'
apt-get install -y -V pm-utils stress

echo 'Remove old TuxOnIce kernel packages.'
apt-get autoremove -y --purge

echo 'Update existing TuxOnIce kernel packages.'
apt-get dist-upgrade -y -V

