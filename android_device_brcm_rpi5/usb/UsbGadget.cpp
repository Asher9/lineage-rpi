/*
 * Copyright (C) 2020 The Android Open Source Project
 * Copyright (C) 2023 KonstaKANG
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.usb.gadget@1.2-service.rpi"

#include "UsbGadget.h"
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/inotify.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

namespace android {
namespace hardware {
namespace usb {
namespace gadget {
namespace V1_2 {
namespace implementation {

UsbGadget::UsbGadget() {
    if (access(OS_DESC_PATH, R_OK) != 0) {
        ALOGE("configfs setup not done yet");
        abort();
    }
}

void currentFunctionsAppliedCallback(bool functionsApplied, void* payload) {
    UsbGadget* gadget = (UsbGadget*)payload;
    gadget->mCurrentUsbFunctionsApplied = functionsApplied;
}

Return<void> UsbGadget::getCurrentUsbFunctions(const sp<V1_0::IUsbGadgetCallback>& callback) {
    Return<void> ret = callback->getCurrentUsbFunctionsCb(
            mCurrentUsbFunctions, mCurrentUsbFunctionsApplied ? Status::FUNCTIONS_APPLIED
                                                              : Status::FUNCTIONS_NOT_APPLIED);
    if (!ret.isOk()) ALOGE("Call to getCurrentUsbFunctionsCb failed %s", ret.description().c_str());

    return Void();
}

Return<void> UsbGadget::getUsbSpeed(const sp<V1_2::IUsbGadgetCallback>& callback) {
    std::string current_speed;
    if (ReadFileToString(SPEED_PATH, &current_speed)) {
        current_speed = Trim(current_speed);
        ALOGI("current USB speed is %s", current_speed.c_str());
        if (current_speed == "low-speed")
            mUsbSpeed = UsbSpeed::LOWSPEED;
        else if (current_speed == "full-speed")
            mUsbSpeed = UsbSpeed::FULLSPEED;
        else if (current_speed == "high-speed")
            mUsbSpeed = UsbSpeed::HIGHSPEED;
        else if (current_speed == "super-speed")
            mUsbSpeed = UsbSpeed::SUPERSPEED;
        else if (current_speed == "super-speed-plus")
            mUsbSpeed = UsbSpeed::SUPERSPEED_10Gb;
        else if (current_speed == "UNKNOWN")
            mUsbSpeed = UsbSpeed::UNKNOWN;
        else {
            /**
             * This part is used for USB4 or reserved speed.
             *
             * If reserved speed is detected, it needs to convert to other speeds.
             * For example:
             * If the bandwidth of new speed is 7G, adding new if
             * statement and set mUsbSpeed to SUPERSPEED.
             * If the bandwidth of new speed is 80G, adding new if
             * statement and set mUsbSpeed to USB4_GEN3_40Gb.
             */
            mUsbSpeed = UsbSpeed::RESERVED_SPEED;
        }
    } else {
        ALOGE("Fail to read current speed");
        mUsbSpeed = UsbSpeed::UNKNOWN;
    }

    if (callback) {
        Return<void> ret = callback->getUsbSpeedCb(mUsbSpeed);

        if (!ret.isOk()) ALOGE("Call to getUsbSpeedCb failed %s", ret.description().c_str());
    }

    return Void();
}

V1_0::Status UsbGadget::tearDownGadget() {
    if (resetGadget() != V1_0::Status::SUCCESS) return V1_0::Status::ERROR;

    if (monitorFfs.isMonitorRunning()) {
        monitorFfs.reset();
    } else {
        ALOGI("mMonitor not running");
    }
    return V1_0::Status::SUCCESS;
}

Return<Status> UsbGadget::reset() {
    if (!WriteStringToFile("none", PULLUP_PATH)) {
        ALOGI("Gadget cannot be pulled down");
        return Status::ERROR;
    }

    usleep(kDisconnectWaitUs);

    if (!WriteStringToFile(kGadgetName, PULLUP_PATH)) {
        ALOGI("Gadget cannot be pulled up");
        return Status::ERROR;
    }

    return Status::SUCCESS;
}

static V1_0::Status validateAndSetVidPid(uint64_t functions) {
    V1_0::Status ret = V1_0::Status::SUCCESS;

    switch (functions) {
        case static_cast<uint64_t>(V1_2::GadgetFunction::MTP):
            ret = setVidPid("0x18d1", "0x4ee1");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::MTP:
            ret = setVidPid("0x18d1", "0x4ee2");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::RNDIS):
            ret = setVidPid("0x18d1", "0x4ee3");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::RNDIS:
            ret = setVidPid("0x18d1", "0x4ee4");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::PTP):
            ret = setVidPid("0x18d1", "0x4ee5");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::PTP:
            ret = setVidPid("0x18d1", "0x4ee6");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::ADB):
            ret = setVidPid("0x18d1", "0x4ee7");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::MIDI):
            ret = setVidPid("0x18d1", "0x4ee8");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::MIDI:
            ret = setVidPid("0x18d1", "0x4ee9");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::NCM):
            ret = setVidPid("0x18d1", "0x4eeb");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::NCM:
            ret = setVidPid("0x18d1", "0x4eec");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::ACCESSORY):
            ret = setVidPid("0x18d1", "0x2d00");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::ACCESSORY:
            ret = setVidPid("0x18d1", "0x2d01");
            break;
        case static_cast<uint64_t>(V1_2::GadgetFunction::AUDIO_SOURCE):
            ret = setVidPid("0x18d1", "0x2d02");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::AUDIO_SOURCE:
            ret = setVidPid("0x18d1", "0x2d03");
            break;
        case V1_2::GadgetFunction::ACCESSORY | V1_2::GadgetFunction::AUDIO_SOURCE:
            ret = setVidPid("0x18d1", "0x2d04");
            break;
        case V1_2::GadgetFunction::ADB | V1_2::GadgetFunction::ACCESSORY |
                V1_2::GadgetFunction::AUDIO_SOURCE:
            ret = setVidPid("0x18d1", "0x2d05");
            break;
        default:
            ALOGE("Combination not supported");
            ret = V1_0::Status::CONFIGURATION_NOT_SUPPORTED;
    }
    return ret;
}

V1_0::Status UsbGadget::setupFunctions(uint64_t functions,
                                       const sp<V1_0::IUsbGadgetCallback>& callback,
                                       uint64_t timeout) {
    bool ffsEnabled = false;
    int i = 0;

    if (addGenericAndroidFunctions(&monitorFfs, functions, &ffsEnabled, &i) !=
        V1_0::Status::SUCCESS)
        return V1_0::Status::ERROR;

    if ((functions & V1_2::GadgetFunction::ADB) != 0) {
        ffsEnabled = true;
        if (addAdb(&monitorFfs, &i) != V1_0::Status::SUCCESS) return V1_0::Status::ERROR;
    }

    // Pull up the gadget right away when there are no ffs functions.
    if (!ffsEnabled) {
        if (!WriteStringToFile(kGadgetName, PULLUP_PATH)) return V1_0::Status::ERROR;
        mCurrentUsbFunctionsApplied = true;
        if (callback) callback->setCurrentUsbFunctionsCb(functions, V1_0::Status::SUCCESS);
        return V1_0::Status::SUCCESS;
    }

    monitorFfs.registerFunctionsAppliedCallback(&currentFunctionsAppliedCallback, this);
    // Monitors the ffs paths to pull up the gadget when descriptors are written.
    // Also takes of the pulling up the gadget again if the userspace process
    // dies and restarts.
    monitorFfs.startMonitor();

    if (kDebug) ALOGI("Mainthread in Cv");

    if (callback) {
        bool pullup = monitorFfs.waitForPullUp(timeout);
        Return<void> ret = callback->setCurrentUsbFunctionsCb(
                functions, pullup ? V1_0::Status::SUCCESS : V1_0::Status::ERROR);
        if (!ret.isOk()) ALOGE("setCurrentUsbFunctionsCb error %s", ret.description().c_str());
    }

    return V1_0::Status::SUCCESS;
}

Return<void> UsbGadget::setCurrentUsbFunctions(uint64_t functions,
                                               const sp<V1_0::IUsbGadgetCallback>& callback,
                                               uint64_t timeout) {
    std::unique_lock<std::mutex> lk(mLockSetCurrentFunction);

    mCurrentUsbFunctions = functions;
    mCurrentUsbFunctionsApplied = false;

    // Unlink the gadget and stop the monitor if running.
    V1_0::Status status = tearDownGadget();
    if (status != V1_0::Status::SUCCESS) {
        goto error;
    }

    ALOGI("Returned from tearDown gadget");

    // Leave the gadget pulled down to give time for the host to sense disconnect.
    usleep(kDisconnectWaitUs);

    if (functions == static_cast<uint64_t>(V1_2::GadgetFunction::NONE)) {
        if (callback == NULL) return Void();
        Return<void> ret = callback->setCurrentUsbFunctionsCb(functions, V1_0::Status::SUCCESS);
        if (!ret.isOk())
            ALOGE("Error while calling setCurrentUsbFunctionsCb %s", ret.description().c_str());
        return Void();
    }

    status = validateAndSetVidPid(functions);

    if (status != V1_0::Status::SUCCESS) {
        goto error;
    }

    status = setupFunctions(functions, callback, timeout);
    if (status != V1_0::Status::SUCCESS) {
        goto error;
    }

    ALOGI("Usb Gadget setcurrent functions called successfully");
    return Void();

error:
    ALOGI("Usb Gadget setcurrent functions failed");
    if (callback == NULL) return Void();
    Return<void> ret = callback->setCurrentUsbFunctionsCb(functions, status);
    if (!ret.isOk())
        ALOGE("Error while calling setCurrentUsbFunctionsCb %s", ret.description().c_str());
    return Void();
}
}  // namespace implementation
}  // namespace V1_2
}  // namespace gadget
}  // namespace usb
}  // namespace hardware
}  // namespace android