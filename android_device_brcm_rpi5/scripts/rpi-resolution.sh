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

write_resolution()
{
  echo "Writing resolution..."
  echo $1 > /boot/resolution.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ ! -z $1 ]; then
  check_root
  mount_partitions
  write_resolution $1
  unmount_partitions
  finish
else
  echo "Usage: $0 resolution"
fi
