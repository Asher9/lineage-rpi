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

enable_properties()
{
  echo "Changing properties..."
  enable_property enable_uart=1 /boot/config.txt
}

disable_properties()
{
  echo "Restoring properties..."
  disable_property enable_uart=1 /boot/config.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ -z $1 ] || [ $1 == "enable" ]; then
  check_root
  mount_partitions
  enable_properties
  unmount_partitions
  finish
elif [ $1 == "disable" ]; then
  check_root
  mount_partitions
  disable_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 [enable|disable]"
fi
