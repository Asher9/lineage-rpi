#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/brcm/rpi5
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, frameworks/native/build/tablet-7in-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product-if-exists, vendor/brcm/rpi5/rpi5-vendor.mk)

# APEX
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# API level
PRODUCT_SHIPPING_API_LEVEL := 34

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl \
    audio.r_submix.default \
    audio.usb.default \
    audio.primary.rpi \
    audio.primary.rpi_hdmi

PRODUCT_PACKAGES += \
    tinycap \
    tinyhostless \
    tinymix \
    tinypcminfo \
    tinyplay

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

PRODUCT_PACKAGES += \
    alsa_amixer \
    alsa_aplay \
    alsa_arecord \
    alsa_loop

PRODUCT_COPY_FILES += \
    external/alsa-lib/src/conf/alsa.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/alsa.conf \
    external/alsa-lib/src/conf/cards/aliases.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/cards/aliases.conf \
    external/alsa-lib/src/conf/cards/vc4-hdmi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/cards/vc4-hdmi.conf \
    external/alsa-lib/src/conf/ctl/default.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/ctl/default.conf \
    external/alsa-lib/src/conf/pcm/center_lfe.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/center_lfe.conf \
    external/alsa-lib/src/conf/pcm/default.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/default.conf \
    external/alsa-lib/src/conf/pcm/dmix.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/dmix.conf \
    external/alsa-lib/src/conf/pcm/dpl.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/dpl.conf \
    external/alsa-lib/src/conf/pcm/dsnoop.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/dsnoop.conf \
    external/alsa-lib/src/conf/pcm/front.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/front.conf \
    external/alsa-lib/src/conf/pcm/hdmi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/hdmi.conf \
    external/alsa-lib/src/conf/pcm/iec958.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/iec958.conf \
    external/alsa-lib/src/conf/pcm/modem.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/modem.conf \
    external/alsa-lib/src/conf/pcm/rear.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/rear.conf \
    external/alsa-lib/src/conf/pcm/side.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/side.conf \
    external/alsa-lib/src/conf/pcm/surround21.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround21.conf \
    external/alsa-lib/src/conf/pcm/surround40.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround40.conf \
    external/alsa-lib/src/conf/pcm/surround41.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround41.conf \
    external/alsa-lib/src/conf/pcm/surround50.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround50.conf \
    external/alsa-lib/src/conf/pcm/surround51.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround51.conf \
    external/alsa-lib/src/conf/pcm/surround71.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/pcm/surround71.conf \
    external/alsa-lib/src/conf/smixer.conf:$(TARGET_COPY_OUT_VENDOR)/etc/alsa/smixer.conf	

# Scripts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/scripts/rpi-audio.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-audio.sh \
    $(DEVICE_PATH)/scripts/rpi-cec.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-cec.sh \
    $(DEVICE_PATH)/scripts/rpi-console.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-console.sh \
    $(DEVICE_PATH)/scripts/rpi-dac.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-dac.sh \
    $(DEVICE_PATH)/scripts/rpi-ir.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-ir.sh \
    $(DEVICE_PATH)/scripts/rpi-keys.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-keys.sh \
    $(DEVICE_PATH)/scripts/rpi-overclock.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-overclock.sh \
    $(DEVICE_PATH)/scripts/rpi-recovery.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-recovery.sh \
    $(DEVICE_PATH)/scripts/rpi-resolution.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-resolution.sh \
    $(DEVICE_PATH)/scripts/rpi-rtc.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-rtc.sh \
    $(DEVICE_PATH)/scripts/rpi-sensors.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-sensors.sh \
    $(DEVICE_PATH)/scripts/rpi-touchscreen.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-touchscreen.sh \
    $(DEVICE_PATH)/scripts/rpi-utils.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi-utils.sh \
    $(DEVICE_PATH)/scripts/sysinit:$(TARGET_COPY_OUT_VENDOR)/bin/sysinit

# Autostart scripts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/init.d/00banner:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/00banner \
    $(DEVICE_PATH)/init.d/02remote:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/02remote \
    $(DEVICE_PATH)/init.d/03ssh:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/03ssh

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-service.btlinux

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl \
    audio.bluetooth.default

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

# Camera
#PRODUCT_PACKAGES += \
#    android.hardware.camera.provider-V1-external-service
#
#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/camera/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml
#
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.camera.external.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.external.xml
#
#PRODUCT_PACKAGES += \
#    android.hardware.camera.provider@2.5-service_64 
#    #camera.libcamera 
#    #ipa_rpi_pisp
#
#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/camera/android.hardware.camera.provider@2.5-service_64.rpi.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.camera.provider@2.5-service_64.rpi.rc
#
#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/camera/camera_hal.yaml:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/camera_hal.yaml \
#    external/libcamera/src/ipa/rpi/pisp/data/imx219.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx219.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx219_noir.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx219_noir.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx296.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx296.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx296_mono.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx296_mono.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx477.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx477.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx477_noir.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx477_noir.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx477_scientific.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx477_scientific.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx708.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx708.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx708_noir.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx708_noir.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx708_wide.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx708_wide.json \
#    external/libcamera/src/ipa/rpi/pisp/data/imx708_wide_noir.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/imx708_wide_noir.json \
#    external/libcamera/src/ipa/rpi/pisp/data/ov5647.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/ov5647.json \
#    external/libcamera/src/ipa/rpi/pisp/data/ov5647_noir.json:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/rpi/pisp/ov5647_noir.json
#
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
#    frameworks/native/data/etc/android.hardware.camera.concurrent.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
#    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
#    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
#    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
#    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/camera/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# CEC
PRODUCT_PACKAGES += \
    android.hardware.tv.cec@1.0-impl \
    android.hardware.tv.cec@1.0-service \
    hdmi_cec.rpi

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml

# Debugfs
#PRODUCT_SET_DEBUGFS_RESTRICTIONS := false

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Emergency info
PRODUCT_PACKAGES += \
    EmergencyInfo

# Ethernet
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

# Gnss
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl

# VNCflinger
PRODUCT_PACKAGES += \
    vncflinger

# OpenSSH
PRODUCT_PACKAGES += \
    ssh \
    sshd \
    scp \
    sftp \
    ssh-keygen \
    sshd_config \
    start-ssh

# GPS
PRODUCT_PACKAGES += \
    gps.default

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl \
    sensors.iio

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# DRM modetest
PRODUCT_PACKAGES += \
    modetest

# Raspberry Pi utils
PRODUCT_PACKAGES += \
    dtmerge \
    dtoverlay \
    pinctrl \
    vcgencmd \
    vclog \
    vcmailbox

# V4L utils
PRODUCT_PACKAGES += \
    cec-ctl \
    ir-keytable \
    v4l2-ctl

# FFmpeg
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2-service-ffmpeg

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm_gbm_mesa \
    android.hardware.graphics.mapper@4.0-impl.minigbm_gbm_mesa \
    libgbm_mesa_wrapper

PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service \
    hwcomposer.drm

PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2023-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml

PRODUCT_PACKAGES += \
    vulkan.broadcom

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2023-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml \
    $(DEVICE_PATH)/vulkan/android.hardware.vulkan.version-1_2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.rpi

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/Generic.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Generic.kl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1-service

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.rpi

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_tv.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_tv.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \
    $(DEVICE_PATH)/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml 

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.example

# Ramdisk
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/ramdisk/fstab.rpi5:$(TARGET_COPY_OUT_RAMDISK)/fstab.rpi5 \
    $(DEVICE_PATH)/ramdisk/fstab.rpi5:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.rpi5 \
    $(DEVICE_PATH)/ramdisk/init.rpi5.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi5.rc \
    $(DEVICE_PATH)/ramdisk/init.rpi5.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi5.usb.rc \
    $(DEVICE_PATH)/ramdisk/init.konstakang.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.konstakang.rc \
    $(DEVICE_PATH)/ramdisk/ueventd.rpi5.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
    $(DEVICE_PATH)/ramdisk/ueventd.konstakang.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.konstakang.rc \
    $(DEVICE_PATH)/ramdisk/adb-tcp.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/adb-tcp.rc \
    $(DEVICE_PATH)/ramdisk/sysinit.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/sysinit.rc

# Seccomp
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(DEVICE_PATH)/seccomp_policy/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy

# Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Suspend
PRODUCT_PACKAGES += \
    suspend_blocker_rpi

# Thermal
PRODUCT_PACKAGES += \
    com.android.hardware.thermal

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.example \
    android.hardware.usb.gadget@1.2-service.rpi

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Virtualization
$(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    hostapd_cli \
    libwpa_client \
    wificond \
    wpa_cli \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    hardware/broadcom/wlan/bcmdhd/config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

# Window extensions
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)
