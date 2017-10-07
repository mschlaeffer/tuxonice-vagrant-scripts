#!/usr/bin/env bash

LOOPSIZE=$1
VMBYTES=$2

echo 1 > /sys/power/tuxonice/reboot

for i in `seq 1 $LOOPSIZE`; do
    echo
    echo '-----------------------------------------------------'
    echo "Perform TuxOnIce cycle #$i."
    date
    uname -a
    echo 'Memory info:'
    if free -V | grep -q ng; then
        free -ht
    else
        free -t
    fi
    pm-hibernate
    cat /sys/power/tuxonice/debug_info
    stress --vm 1 --vm-bytes $VMBYTES --vm-hang 0 &
    sleep 5
done
echo
