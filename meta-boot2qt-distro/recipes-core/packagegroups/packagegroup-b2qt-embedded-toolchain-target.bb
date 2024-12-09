# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Target packages for B2Qt embedded SDK"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"

MACHINE_EXTRA_INSTALL_SDK ?= ""

require gcc-sanitizers.inc

RDEPENDS:${PN} += " \
    packagegroup-core-standalone-sdk-target \
    ${GCC-SANITIZERS} \
    ${MACHINE_EXTRA_INSTALL_SDK} \
    ${@bb.utils.contains("DISTRO_FEATURES", "vulkan", "vulkan-headers-dev", "", d)} \
"
