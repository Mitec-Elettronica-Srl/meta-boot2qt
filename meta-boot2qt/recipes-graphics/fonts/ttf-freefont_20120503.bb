# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "GNU FreeFont is a free family of scalable outline fonts"
HOMEPAGE = "http://savannah.gnu.org/projects/freefont"
LICENSE = "GPL-3.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

require recipes-graphics/ttf-fonts/ttf.inc

inherit allarch fontcache

S = "${WORKDIR}/freefont-${PV}"

SRC_URI = "http://ftp.gnu.org/gnu/freefont/freefont-ttf-${PV}.zip"

SRC_URI[md5sum] = "879b76d2e3c8003d567b555743f39154"
SRC_URI[sha256sum] = "7c85baf1bf82a1a1845d1322112bc6ca982221b484e3b3925022e25b5cae89af"

PACKAGES = "${PN}-sans ${PN}-mono ${PN}-serif"
FILES:${PN}-sans = "${datadir}/fonts/truetype/FreeSans*.ttf"
FILES:${PN}-mono = "${datadir}/fonts/truetype/FreeMono*.ttf"
FILES:${PN}-serif = "${datadir}/fonts/truetype/FreeSerif*.ttf"
