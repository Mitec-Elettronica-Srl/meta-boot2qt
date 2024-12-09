# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Noto Sans CJK"
SECTION = "fonts"
HOMEPAGE = "http://www.google.com/get/noto"
LICENSE = "OFL-1.1"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=55719faa0112708e946b820b24b14097"

INHIBIT_DEFAULT_DEPS = "1"

inherit allarch fontcache

PV = "1.004"
SRC_URI = "git://github.com/notofonts/noto-cjk.git;branch=main;protocol=https"
SRCREV = "40d9f5b179a59a06b98373c76bdc3e2119e4e6b2"

S = "${WORKDIR}/git"

do_install() {
    install -m 0755 -d ${D}${datadir}/fonts/otf/noto
    install -m 0644 ${S}/NotoSansCJKsc-Regular.otf ${D}${datadir}/fonts/otf/noto
}

PACKAGES = "${PN}"
FILES:${PN} += "${datadir}/fonts/otf/noto"
