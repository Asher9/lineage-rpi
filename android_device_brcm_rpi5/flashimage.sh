#!/bin/bash

SCRIPTDIR=$(pwd)/device/brcm/rpi5
OUTDIR=$(pwd | sed 's/\/device\/brcm\/rpi5$//')/out/target/product/rpi5
SYSTEMDEV=/dev/disk/by-id/usb-Verbatim_STORE_N_GO_23031853020050-0:0-part2
VENDORDEV=/dev/disk/by-id/usb-Verbatim_STORE_N_GO_23031853020050-0:0-part3

MD5SYSTEM=$(md5sum "${OUTDIR}/system.img" | cut -d' ' -f1)
MD5VENDOR=$(md5sum "${OUTDIR}/vendor.img" | cut -d' ' -f1)

if [ ! -e ${SYSTEMDEV} ] || [ ! -e ${VENDORDEV} ]; then

    echo "Storage not available"
    exit 0

else
    function _write_systemImage {
        echo "Write System Image to Storage"
        echo "MD5 Sum of System Image:" ${MD5SYSTEM}
        systemWritten=true
        sudo dd if=${OUTDIR}/system.img of=${SYSTEMDEV} bs=4M
    }

    function _write_vendorImage {
        echo "Write Vendor Image to Storage"
        echo "MD5 Sum of Vendor Image:" ${MD5VENDOR}
        sudo dd if=${OUTDIR}/vendor.img of=${VENDORDEV} bs=4M
    }

    function _write_md5System_to_file {
        echo ${MD5SYSTEM} > ${SCRIPTDIR}/md5system.txt
    }

    function _write_md5Vendor_to_file {
        echo ${MD5VENDOR} > ${SCRIPTDIR}/md5vendor.txt
    }

    if [ ! -f ${SCRIPTDIR}/md5system.txt ]; then
        _write_md5System_to_file
        _write_systemImage
        MD5SYSTEMOLD=$(cat ${SCRIPTDIR}/md5system.txt)
    else
        MD5SYSTEMOLD=$(cat ${SCRIPTDIR}/md5system.txt)
    fi

    if [ ! -f ${SCRIPTDIR}/md5vendor.txt ]; then
        _write_md5Vendor_to_file
        _write_vendorImage
        MD5VENDOROLD=$(cat ${SCRIPTDIR}/md5vendor.txt)
    else
        MD5VENDOROLD=$(cat ${SCRIPTDIR}/md5vendor.txt)
    fi

    if [ "$MD5SYSTEMOLD" != "$MD5SYSTEM" ]; then
        _write_md5System_to_file
        _write_systemImage
    else
        echo "Same System Image, nothing to do"
    fi

    if [ "$MD5VENDOROLD" != "$MD5VENDOR" ]; then
        _write_md5Vendor_to_file
        _write_vendorImage
    else
        echo "Same Vendor Image, nothing to do"
    fi

    sync

    exit 0
fi