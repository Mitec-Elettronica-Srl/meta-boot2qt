# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "B2Qt embedded Qt6 SDK toolchain"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit populate_b2qt_qt6_sdk

SDKIMAGE_FEATURES = "dev-pkgs"

MACHINE_EXTRA_INSTALL_SDK ?= ""

TOOLCHAIN_HOST_TASK += " \
    nativesdk-packagegroup-b2qt-embedded-qt6-toolchain-host \
    nativesdk-openssl-dev \
    nativesdk-openssl \
"

TOOLCHAIN_TARGET_TASK += "\
    packagegroup-b2qt-embedded-toolchain-target \
    packagegroup-qt6-modules \
    openssl-dev \
    libcurl4 \
    qtquickdesigner-components-dev \
    qtquickdesigner-components-plugins \
    ${MACHINE_EXTRA_INSTALL_SDK} \
"

PACKAGE_EXCLUDE_COMPLEMENTARY += "qtwebengine-dbg"
PACKAGE_EXCLUDE += "sudo"

# For static libs of target SDK
SDKIMAGE_FEATURES:append = " staticdev-pkgs"
