
$(call inherit-product, device/brcm/rpi4/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

#DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay
#TARGET_BOOTANIMATION_SIZE := 720p

$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product, vendor/brcm/rpi4/rpi4-vendor.mk)
$(call inherit-product, vendor/lineage/config/BoardConfigLineage.mk)

PRODUCT_DEVICE := rpi4
PRODUCT_NAME := lineage_rpi4
PRODUCT_BRAND := Raspberry
PRODUCT_BOARD := Raspberry Pi4
PRODUCT_MODEL := Raspberry Pi4
PRODUCT_MANUFACTURER := Raspberry Pi Ltd
