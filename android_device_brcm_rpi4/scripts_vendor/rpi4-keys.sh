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

enable_power_properties()
{
  echo "Changing properties..."
  enable_property dtoverlay=gpio-key,gpio=21,keycode=116,label=\"POWER\" /boot/config.txt
}

disable_power_properties()
{
  echo "Restoring properties..."
  disable_property dtoverlay=gpio-key,gpio=21,keycode=116,label=\"POWER\" /boot/config.txt
}

enable_vol_properties()
{
  echo "Changing properties..."
  enable_property dtoverlay=gpio-key,gpio=26,keycode=115,label=\"VOLUME_UP\" /boot/config.txt
  enable_property dtoverlay=gpio-key,gpio=20,keycode=114,label=\"VOLUME_DOWN\" /boot/config.txt
}

disable_vol_properties()
{
  echo "Restoring properties..."
  disable_property dtoverlay=gpio-key,gpio=26,keycode=115,label=\"VOLUME_UP\" /boot/config.txt
  disable_property dtoverlay=gpio-key,gpio=20,keycode=114,label=\"VOLUME_DOWN\" /boot/config.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ -z $1 ] || [ $1 == "enable_power" ]; then
  check_root
  mount_partitions
  enable_power_properties
  unmount_partitions
  finish
elif [ $1 == "disable_power" ]; then
  check_root
  mount_partitions
  disable_power_properties
  unmount_partitions
  finish
elif [ $1 == "enable_vol" ]; then
  check_root
  mount_partitions
  enable_vol_properties
  unmount_partitions
  finish
elif [ $1 == "disable_vol" ]; then
  check_root
  mount_partitions
  disable_vol_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 [enable_power|disable_power|enable_vol|disable_vol]"
fi
