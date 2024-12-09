# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Open Sans Fonts"
SECTION = "fonts"
HOMEPAGE = "https://fonts.google.com"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://apache/opensans/LICENSE.txt;md5=d273d63619c9aeaf15cdaf76422c4f87"

INHIBIT_DEFAULT_DEPS = "1"

inherit allarch fontcache

SRC_URI = "git://github.com/google/fonts;branch=main;protocol=https"
SRCREV = "beaec0837bd21524b57ecb435158f9011fc03999"

S = "${WORKDIR}/git"

do_install() {
    install -m 0755 -d ${D}${datadir}/fonts/truetype/opensans
    install -m 0644 apache/opensans/*.ttf ${D}${datadir}/fonts/truetype/opensans
}

PACKAGES = "${PN}"
FILES:${PN} += "${datadir}/fonts/truetype/opensans"
