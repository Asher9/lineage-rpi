
# Enable Scoped Storage related
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

PRODUCT_SOONG_NAMESPACES += \
    device/brcm/rpi4 \
    external/mesa3d \
    external/v4l2_codec2

# Set custom settings
DEVICE_PACKAGE_OVERLAYS := device/brcm/rpi4/overlay

#Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm_gbm_mesa \
    android.hardware.graphics.mapper@4.0-impl.minigbm_gbm_mesa \
    android.hardware.graphics.composer@2.4-impl \
    android.hardware.graphics.composer@2.4-service \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libgbm_mesa \
    libglapi \
    hwcomposer.drm \
    vulkan.broadcom \
    gralloc.minigbm_gbm_mesa

#Vulkan
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Software Gatekeeper HAL
PRODUCT_PACKAGES += \
	android.hardware.gatekeeper@1.0-service.software

#Health
PRODUCT_PACKAGES += \
	android.hardware.health@2.1-impl-rpi4 \
    android.hardware.health@2.1-service

#Security
PRODUCT_PACKAGES += \
	android.hardware.keymaster@3.0-impl \
	android.hardware.keymaster@3.0-service \
	android.hardware.drm@1.0-impl \
	android.hardware.drm@1.0-service \
    android.hardware.drm@1.4-service.clearkey

# Audio
PRODUCT_PACKAGES += \
	android.hardware.audio@7.0-impl \
	android.hardware.audio.service \
	android.hardware.audio.effect@7.0-impl \
    android.hardware.soundtrigger@2.3-impl

# Audio policy configuration
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
	device/brcm/rpi4/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration_7_0.xml \
	frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration_7_0.xml \
	frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
	frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

# USB
PRODUCT_PACKAGES += \
	android.hardware.usb@1.0-service

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml

#Ramdisk
PRODUCT_COPY_FILES += \
    device/brcm/rpi4/init.rpi4.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.rc \
    device/brcm/rpi4/init.rpi4.custom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.custom.rc \
    device/brcm/rpi4/init.rpi4.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rpi4.usb.rc \
    device/brcm/rpi4/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
    device/brcm/rpi4/fstab.rpi4:$(TARGET_COPY_OUT_RAMDISK)/fstab.rpi4 \
    device/brcm/rpi4/fstab.rpi4:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.rpi4 \
	frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

PRODUCT_CHARACTERISTICS := tablet,nosdcard

PRODUCT_PACKAGES += \
	Launcher3 \
	WallpaperPicker2 \
    Camera2 \
    ThemePicker

PRODUCT_PACKAGES += \
    androidx.window.extensions \
    androidx.window.sidecar

#System Packages
PRODUCT_PACKAGES += \
    android.hardware.tv.cec@1.0-service.mock \
    v4l2-ctl \
    cec-ctl \
    libc2plugin_store

# HALs
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service \
    android.hardware.media.c2@1.0-service-v4l2 \
    android.hardware.power-service.example \
    audio.primary.rpi4 \
    audio.usb.default \
    audio.r_submix.default \
    audio.bluetooth.default \
    audio.hearing_aid.default \
    audio.a2dp.default

#Sensors
PRODUCT_PACKAGES += \
    sensors.iio \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl

#Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth.audio@2.0-impl \
    libbt-vendor

#Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.5-service_64 \
    boost \
    libyuv_chromium \
    libyaml \
    camera.libcamera \
    ipa_rpi

LIBCAMERA_CFGS := ov5647.json ov5647_noir.json imx219_noir.json imx219.json imx477_noir.json imx477.json

PRODUCT_COPY_FILES += \
    $(foreach cfg,$(LIBCAMERA_CFGS),external/libcamera/src/ipa/raspberrypi/data/$(cfg):$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/ipa/raspberrypi/$(cfg)$(space))


#frameworks/native/data/etc/android.hardware.camera.external.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.external.xml
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml
    #device/brcm/rpi4/camera_hal.yaml:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/camera_hal.yaml \
    #device/brcm/rpi4/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

#Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf \
    hostapd \
    hostapd_cli \
    wificond \
    wpa_cli

PRODUCT_COPY_FILES += \
    device/brcm/rpi4/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

#Shell scripts_vendor
PRODUCT_COPY_FILES += \
    device/brcm/rpi4/scripts_vendor/rpi4-audio.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-audio.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-cec.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-cec.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-console.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-console.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-dac.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-dac.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-ir.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-ir.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-keys.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-keys.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-overclock.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-overclock.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-recovery.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-recovery.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-resolution.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-resolution.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-rtc.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-rtc.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-sensors.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-sensors.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-touchscreen.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-touchscreen.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-utils.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-utils.sh \
    device/brcm/rpi4/scripts_vendor/rpi4-video.sh:$(TARGET_COPY_OUT_VENDOR)/bin/rpi4-video.sh \
    device/brcm/rpi4/scripts_vendor/sysinit:$(TARGET_COPY_OUT_VENDOR)/bin/sysinit \
    device/brcm/rpi4/scripts_init.d/00banner:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/00banner \
    device/brcm/rpi4/scripts_init.d/01rtc:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/01rtc \
    device/brcm/rpi4/scripts_init.d/02remote:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/02remote \
    device/brcm/rpi4/scripts_init.d/03ssh:$(TARGET_COPY_OUT_VENDOR)/etc/init.d/03ssh

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \

#Sensor Permissions
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
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    device/generic/goldfish/camera/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml \
    device/generic/goldfish/camera/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    device/brcm/rpi4/media_codecs_v4l2_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_v4l2_c2_video.xml \
    device/brcm/rpi4/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy

#PRODUCT_COPY_FILES += \
#    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
#    frameworks/av/media/libstagefright/data/media_codecs_google_c2_tv.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_tv.xml \
#    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml
    #device/brcm/rpi4/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    #device/brcm/rpi4/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \

PRODUCT_COPY_FILES += \
    device/brcm/rpi4/Generic.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Generic.kl

ifeq ($(TARGET_NO_RECOVERY),false)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/brcm/rpi4/recovery/root,recovery/root)
endif