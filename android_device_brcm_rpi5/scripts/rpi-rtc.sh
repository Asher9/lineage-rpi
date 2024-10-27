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
  echo "Changing properties for no RTC..."
  disable_property dtoverlay=i2c-rtc /boot/config.txt
}

ds3231_properties()
{
  echo "Changing properties for DS3231..."
  enable_property dtoverlay=i2c-rtc /boot/config.txt
  switch_property dtoverlay i2c-rtc.*$ i2c-rtc,ds3231 /boot/config.txt
}

pcf85063a_properties()
{
  echo "Changing properties for PCF85063A..."
  enable_property dtoverlay=i2c-rtc /boot/config.txt
  switch_property dtoverlay i2c-rtc.*$ i2c-rtc,pcf85063a,i2c_csi_dsi /boot/config.txt
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
elif [ ! -z $1 ] && [ $1 == "ds3231" ]; then
  check_root
  mount_partitions
  ds3231_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "pcf85063a" ]; then
  check_root
  mount_partitions
  pcf85063a_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 none|ds3231|pcf85063a"
fi
