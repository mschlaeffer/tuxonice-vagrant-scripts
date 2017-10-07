#!/usr/bin/env bash

echo
echo '-----------------------------------------------------'
echo 'Add TuxOnIce swap file header location to grub.'
SWAPFILE=$(sed 's|.*\(resume=.*\)\.|\1|' /sys/power/tuxonice/swap/headerlocations)
sed -i "/GRUB_CMDLINE_LINUX=/s|\".*\"|\"$SWAPFILE\"|" /etc/default/grub
update-grub
