# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Qt for Device Creation Demo Image"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

DEPLOY_CONF_TYPE = "Boot2Qt ${QT_VERSION}"

IMAGE_FEATURES += "\
        package-management \
        ssh-server-openssh \
        tools-debug \
        tools-profile \
        debug-tweaks \
        hwcodecs \
        "

inherit core-image deploy-buildinfo
inherit consistent_timestamps

# add some extra space to the device images
IMAGE_ROOTFS_EXTRA_SPACE = "100000"

IMAGE_INSTALL += "\
    packagegroup-b2qt-embedded-base \
    packagegroup-b2qt-embedded-tools \
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer", "packagegroup-b2qt-embedded-gstreamer", "", d)} \
    packagegroup-qt6-modules \
    packagegroup-b2qt-embedded-addons \
    ${@bb.utils.contains("DISTRO_FEATURES", "virtualization", "packagegroup-docker", "", d)} \
    "
