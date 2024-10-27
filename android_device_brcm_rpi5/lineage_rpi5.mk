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

$(call inherit-product, device/brcm/rpi5/device.mk)

PRODUCT_AAPT_CONFIG := normal mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_CHARACTERISTICS := tablet,nosdcard
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Overlays
PRODUCT_PACKAGES += \
    AndroidRpiOverlay \
    SettingsRpiOverlay \
    SettingsProviderRpiOverlay \
    SystemUIRpiOverlay \
    WifiRpiOverlay
    #LineageRpiOverlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware.xml

PRODUCT_DEVICE := rpi5
PRODUCT_NAME := lineage_rpi5
PRODUCT_BRAND := Raspberry
PRODUCT_MODEL := Raspberry Pi 5
PRODUCT_MANUFACTURER := Raspberry Pi Foundation
PRODUCT_RELEASE_NAME := Raspberry Pi 5
