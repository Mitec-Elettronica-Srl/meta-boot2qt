# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Host packages for B2Qt on embedded Linux SDK"
PR = "r0"
LICENSE = "The-Qt-Company-Commercial"

inherit packagegroup
inherit_defer nativesdk

MACHINE_EXTRA_INSTALL_SDK_HOST ?= ""

RDEPENDS:${PN} = "\
    ${MACHINE_EXTRA_INSTALL_SDK_HOST} \
    nativesdk-cmake \
    nativesdk-gperf \
    nativesdk-make \
    nativesdk-ninja \
    nativesdk-perl-modules \
    nativesdk-python3-html5lib \
    nativesdk-python3-spdx-tools \
    "

RDEPENDS:${PN}:remove:mingw32 = "\
    nativesdk-perl-modules \
    "
