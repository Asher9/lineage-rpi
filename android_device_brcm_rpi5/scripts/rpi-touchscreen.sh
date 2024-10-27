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

none_properties()
{
  echo "Changing properties for no touchscreen..."
  disable_property dtoverlay=rpi-backlight /boot/config.txt
  disable_property dtoverlay=vc4-kms-dsi-7inch /boot/config.txt
  echo "1920x1080" > /boot/resolution.txt
}

raspberry_properties()
{
  echo "Changing properties for Raspberry touchscreen..."
  enable_property dtoverlay=rpi-backlight /boot/config.txt
  enable_property dtoverlay=vc4-kms-dsi-7inch /boot/config.txt
  echo "800x480" > /boot/resolution.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ ! -z $1 ] && [ $1 == "none" ]; then
  check_root
  mount_partitions
  none_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "raspberry" ]; then
  check_root
  mount_partitions
  raspberry_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 none|raspberry"
fi
