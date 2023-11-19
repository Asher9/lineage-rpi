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

nodac_properties()
{
  echo "Changing properties for no DAC..."
  disable_property dtoverlay=hifiberry /boot/config.txt
  disable_property dtparam=i2s=on /boot/config.txt
}

dac_properties()
{
  echo "Changing properties for DAC..."
  enable_property dtoverlay=hifiberry /boot/config.txt
  enable_property dtparam=i2s=on /boot/config.txt
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ ! -z $1 ] && [ $1 == "nodac" ]; then
  check_root
  mount_partitions
  nodac_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "dac" ]; then
  check_root
  mount_partitions
  dac_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 nodac|dac"
fi
