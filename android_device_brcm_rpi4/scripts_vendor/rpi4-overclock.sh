#!/vendor/bin/sh

#
# Copyright (C) 2019-2022 KonstaKANG <konstakang@gmail.com>
#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#

source /vendor/bin/rpi4-utils.sh

mount_partitions()
{
  echo "Mounting partitions..."
  mount_rw /boot
}

set_overclock()
{
  echo "Changing properties for CPU overclock..."
  switch_property over_voltage .*$ $1 /boot/config.txt
  switch_property arm_freq .*$ $2 /boot/config.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ ! -z $1 ] && [ $1 == "1500" ]; then
  check_root
  mount_partitions
  set_overclock 0 1500
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "1600" ]; then
  check_root
  mount_partitions
  set_overclock 1 1600
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "1700" ]; then
  check_root
  mount_partitions
  set_overclock 2 1700
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "1800" ]; then
  check_root
  mount_partitions
  set_overclock 3 1800
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "1900" ]; then
  check_root
  mount_partitions
  set_overclock 4 1900
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "2000" ]; then
  check_root
  mount_partitions
  set_overclock 6 2000
  unmount_partitions
  finish
else
  echo "Usage: $0 1500|1600|1700|1800|1900|2000"
fi
