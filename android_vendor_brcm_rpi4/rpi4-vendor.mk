# Automatically generated file. DO NOT MODIFY
#
# This file is generated by device/brcm/rpi4/setup-makefiles.sh

PRODUCT_SOONG_NAMESPACES += \
    vendor/brcm/rpi4

PRODUCT_COPY_FILES += \
    vendor/brcm/rpi4/proprietary/vendor/bin/hw/android.hardware.drm@1.4-service.widevine:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.drm@1.4-service.widevine \
    vendor/brcm/rpi4/proprietary/vendor/etc/init/android.hardware.drm@1.4-service.widevine.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.drm@1.4-service.widevine.rc \
    vendor/brcm/rpi4/proprietary/vendor/lib64/libwvhidl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwvhidl.so
    
PRODUCT_COPY_FILES += \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43455-sdio.bin \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43455-sdio.clm_blob \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43455-sdio.txt \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43456-sdio.bin \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43456-sdio.clm_blob \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43456-sdio.txt \
    vendor/brcm/rpi4/proprietary/vendor/firmware/regulatory.db:$(TARGET_COPY_OUT_VENDOR)/firmware/regulatory.db \
    vendor/brcm/rpi4/proprietary/vendor/firmware/regulatory.db.p7s:$(TARGET_COPY_OUT_VENDOR)/firmware/regulatory.db.p7s \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/BCM4345C0.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/BCM4345C0.hcd \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/BCM4345C5.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/BCM4345C5.hcd

PRODUCT_COPY_FILES += \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.bin \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43455-sdio.txt \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.bin:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43456-sdio.bin \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.clm_blob:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43456-sdio.clm_blob \
    vendor/brcm/rpi4/proprietary/vendor/firmware/brcm/brcmfmac43456-sdio.txt:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/brcm/brcmfmac43456-sdio.txt \
    vendor/brcm/rpi4/proprietary/vendor/firmware/regulatory.db:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/regulatory.db \
    vendor/brcm/rpi4/proprietary/vendor/firmware/regulatory.db.p7s:$(TARGET_COPY_OUT_RAMDISK)/lib/firmware/regulatory.db.p7s

PRODUCT_PACKAGES += \
    manifest_android.hardware.drm@1.4-service.widevine