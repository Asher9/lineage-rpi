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

none_properties()
{
  echo "Changing properties for no sensors..."
  disable_property dtoverlay=android-i2c-sensor /boot/config.txt
}

mpu6050_properties()
{
  echo "Changing properties for MPU6050..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,mpu6050 /boot/config.txt
}

lsm6ds3_properties()
{
  echo "Changing properties for LSM6DS3..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,lsm6ds3 /boot/config.txt
}

lsm303dlhc_properties()
{
  echo "Changing properties for LSM303DLHC..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,lsm303dlhca,lsm303dlhcm /boot/config.txt
}

bme280_properties()
{
  echo "Changing properties for BME280..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,bme280 /boot/config.txt
}

bmp280_properties()
{
  echo "Changing properties for BMP280..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,bmp280 /boot/config.txt
}

apds9930_properties()
{
  echo "Changing properties for APDS9930..."
  enable_property dtoverlay=android-i2c-sensor /boot/config.txt
  switch_property dtoverlay android-i2c-sensor.*$ android-i2c-sensor,apds9930 /boot/config.txt
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
elif [ ! -z $1 ] && [ $1 == "mpu6050" ]; then
  check_root
  mount_partitions
  mpu6050_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "lsm6ds3" ]; then
  check_root
  mount_partitions
  lsm6ds3_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "lsm303dlhc" ]; then
  check_root
  mount_partitions
  lsm303dlhc_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "bme280" ]; then
  check_root
  mount_partitions
  bme280_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "bmp280" ]; then
  check_root
  mount_partitions
  bmp280_properties
  unmount_partitions
  finish
elif [ ! -z $1 ] && [ $1 == "apds9930" ]; then
  check_root
  mount_partitions
  apds9930_properties
  unmount_partitions
  finish
else
  echo "Usage: $0 none|mpu6050|lsm6ds3|lsm303dlhc|bme280|bmp280|apds9930"
fi
