#!/usr/bin/env bash

LOOPSIZE=$1
VMBYTES=$2

echo 1 > /sys/power/tuxonice/reboot

for i in `seq 1 $LOOPSIZE`; do
    echo "Perform TuxOnIce cycle #$i."
    echo "Memory info:"
    free -t
    sleep 5
    pm-hibernate
    cat /sys/power/tuxonice/debug_info
    stress --vm 1 --vm-bytes $VMBYTES --vm-hang 0 &
    echo
done

