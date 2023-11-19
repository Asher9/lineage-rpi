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
  mount_rw /vendor
}

enable_properties()
{
  echo "Enabling hardware video decoding..."
  sed -i "s/<!-- <Include href=\"media_codecs_v4l2_c2_video.xml\" \/> -->/<Include href=\"media_codecs_v4l2_c2_video.xml\" \/>/" /vendor/etc/media_codecs.xml
}

disable_properties()
{
  echo "Disabling hardware video decoding..."
  sed -i "s/<Include href=\"media_codecs_v4l2_c2_video.xml\" \/>/<!-- <Include href=\"media_codecs_v4l2_c2_video.xml\" \/> -->/" /vendor/etc/media_codecs.xml
}

unmount_partitions()
{
  echo "Unmounting partitions..."
  mount_ro /vendor
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
