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

recovery_ramdisk()
{
  if [ -f /boot/ramdisk-recovery.img ] && [ ! -f /boot/ramdisk-boot.img ]; then
    echo "Changing ramdisk..."
    mv /boot/ramdisk.img /boot/ramdisk-boot.img
    mv /boot/ramdisk-recovery.img /boot/ramdisk.img
    disable_property dtoverlay=vc4-kms-v3d /boot/config.txt
    if [ ! -z $(grep -Fx "dtoverlay=vc4-kms-dsi-7inch" /boot/config.txt) ]; then
      disable_property dtoverlay=vc4-kms-dsi-7inch /boot/config.txt
      enable_property dtoverlay=edt-ft5406 /boot/config.txt
    fi
  else
    echo "Something went wrong!"
    exit 2
  fi
}

boot_ramdisk()
{
  if [ -f /boot/ramdisk-boot.img ] && [ ! -f /boot/ramdisk-recovery.img ]; then
    echo "Restoring ramdisk..."
    mv /boot/ramdisk.img /boot/ramdisk-recovery.img
    mv /boot/ramdisk-boot.img /boot/ramdisk.img
    enable_property dtoverlay=vc4-kms-v3d /boot/config.txt
    if [ ! -z $(grep -Fx "dtoverlay=edt-ft5406" /boot/config.txt) ]; then
      enable_property dtoverlay=vc4-kms-dsi-7inch /boot/config.txt
      disable_property dtoverlay=edt-ft5406 /boot/config.txt
    fi
  else
    echo "Something went wrong!"
    exit 2
  fi
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /boot
}

if [ -z $1 ] || [ $1 == "recovery" ]; then
  check_root
  mount_partitions
  recovery_ramdisk
  unmount_partitions
  finish
elif [ $1 == "boot" ]; then
  check_root
  mount_partitions
  boot_ramdisk
  unmount_partitions
  finish
else
  echo "Usage: $0 [recovery|boot]"
fi
