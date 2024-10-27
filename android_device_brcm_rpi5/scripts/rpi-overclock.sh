#!/vendor/bin/sh

#
# Copyright (C) 2019-2023 KonstaKANG <konstakang@gmail.com>
#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#

source /vendor/bin/rpi-utils.sh

mount_partitions()
{
  echo "Mounting partitions..."
  mount_rw /boot
}

set_overclock()
{
  echo "Changing properties for CPU overclock..."
  enable_property arm_freq /boot/config.txt
  switch_property arm_freq .*$ $1 /boot/config.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ ! -z $1 ]; then
  check_root
  mount_partitions
  set_overclock $1
  unmount_partitions
  finish
else
  echo "Usage: $0 frequency"
fi
