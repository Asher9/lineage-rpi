#!/vendor/bin/sh

enable_property()
{
  sed -i "s/^#$1/$1/" $2
}

disable_property()
{
  sed -i "s/^$1/#$1/" $2
}

switch_property()
{
  sed -i "s/^$1=$2/$1=$3/" $4
}

mount_rw()
{
  mount -o rw,remount $1
}

mount_ro()
{
  mount -o ro,remount $1
}

check_root()
{
  if [ $(id -u) != 0 ]; then
    echo "Must be root to run script!"
    exit 1
  fi
}

finish()
{
  echo "Done, reboot device!"
  exit 0
}


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


  check_root
  mount_partitions
  boot_ramdisk
  unmount_partitions
  finish

