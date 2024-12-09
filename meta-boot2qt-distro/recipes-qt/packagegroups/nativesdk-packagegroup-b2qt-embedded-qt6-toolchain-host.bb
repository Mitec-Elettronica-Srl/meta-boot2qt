# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Host packages for B2Qt embedded Qt6 SDK"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

inherit packagegroup
inherit_defer nativesdk

RDEPENDS:${PN} += "\
    nativesdk-packagegroup-b2qt-embedded-toolchain-host \
    nativesdk-packagegroup-qt6-toolchain-host \
    "

RDEPENDS:${PN}:append:mingw32 = "\
    nativesdk-qtinterfaceframework-dev \
    nativesdk-qtinterfaceframework-tools \
"
