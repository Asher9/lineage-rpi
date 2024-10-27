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
  mount_rw /vendor
}

jack_properties()
{
  echo "Changing properties for 3.5 mm jack..."
  disable_property dtoverlay=hifiberry /boot/config.txt
  disable_property dtparam=i2s=on /boot/config.txt
  switch_property ro.hardware.audio.primary .*$ rpi /vendor/build.prop
}

hdmi_properties()
{
  echo "Changing properties for HDMI..."
  disable_property dtoverlay=hifiberry /boot/config.txt
  disable_property dtparam=i2s=on /boot/config.txt
  switch_property ro.hardware.audio.primary .*$ rpi_hdmi /vendor/build.prop
}

dac_properties()
{
  echo "Changing properties for DAC..."
  enable_property dtoverlay=hifiberry /boot/config.txt
  enable_property dtparam=i2s=on /boot/config.txt
  switch_property ro.hardware.audio.primary .*$ rpi /vendor/build.prop
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
  mount_ro /vendor
}

if [ ! -z $1 ] && [ $1 == "jack" ]; then
  check_root
  mount_partitions
  jack_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "hdmi" ]; then
  check_root
  mount_partitions
  hdmi_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "dac" ]; then
  check_root
  mount_partitions
  dac_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 jack|hdmi|dac"
fi
