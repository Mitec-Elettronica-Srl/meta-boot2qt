# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Titillium Web Fonts"
SECTION = "fonts"
HOMEPAGE = "https://fonts.google.com/specimen/Titillium+Web"
LICENSE = "OFL-1.1"
LIC_FILES_CHKSUM = "file://ofl/titilliumweb/OFL.txt;md5=624efcc17a6f7350735d2d13054f7764"

INHIBIT_DEFAULT_DEPS = "1"

inherit allarch fontcache

SRC_URI = "git://github.com/google/fonts;branch=main;protocol=https"
SRCREV = "93550bd32b353b74c90d683d0f00251a3f7b314d"

S = "${WORKDIR}/git"

do_install() {
    install -m 0755 -d ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-Regular.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-Light.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-LightItalic.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-SemiBold.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-SemiBoldItalic.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-Bold.ttf ${D}${datadir}/fonts/truetype/titilliumweb
    install -m 0644 ofl/titilliumweb/TitilliumWeb-BoldItalic.ttf ${D}${datadir}/fonts/truetype/titilliumweb
}

PACKAGES = "${PN}"
FILES:${PN} += "${datadir}/fonts/truetype/titilliumweb"
