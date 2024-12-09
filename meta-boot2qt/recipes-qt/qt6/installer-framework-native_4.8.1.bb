# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Qt Installer Framework"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit bin_package native

do_unpack[depends] += "p7zip-native:do_populate_sysroot"

DEPENDS = "patchelf-native"

PLATFORM = "Linux"
PLATFORM:aarch64 = "Linux-AARCH64"
SRC_URI = "https://download.qt.io/development_releases/installer-framework/${PV}/${PLATFORM}/ifw_data.7z;downloadfilename=ifw-${PLATFORM}.7z"

CHECKSUM = "c918a0e4c02c7f4bddaaa28b7ca83966b796233f8b977e03b1e8e536a0caa694"
CHECKSUM:aarch64 = "25476981d81e4ba7a252f488eb45bdb5765935566406d447f584e656d8115c6c"
SRC_URI[sha256sum] = "${CHECKSUM}"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 -t ${D}${bindir} ${S}/bin/*
    patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/*
}

INSANE_SKIP:${PN} += "already-stripped"
