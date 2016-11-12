#!/usr/bin/env bash

LOOPSIZE=$1
VMBYTES=$2

echo 1 > /sys/power/tuxonice/reboot

echo
for i in `seq 1 $LOOPSIZE`; do
    echo "Perform TuxOnIce cycle #$i."
    date
    echo "Memory info:"
    if free -V | grep -q ng; then
        free -ht
    else
        free -t
    fi
    pm-hibernate
    cat /sys/power/tuxonice/debug_info
    stress --vm 1 --vm-bytes $VMBYTES --vm-hang 0 &
    sleep 5
    echo
done

