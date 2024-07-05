############################################################################
##
## Copyright (C) 2023 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

DESCRIPTION = "Boot to Qt Demo Launcher"
LICENSE = "GPL-3.0-only | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = " \
    file://LICENSES/GPL-3.0-only.txt;md5=d32239bcb673463ab874e80d47fae504 \
    file://LICENSES/LicenseRef-Qt-Commercial.txt;md5=caa060942f6b722bc4329d4195584c38 \
"

inherit qt6-cmake systemd
require recipes-qt/qt6/qt6-git.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE = "boot2qt-launcher"
QT_MODULE_BRANCH = "dev"
CVE_PRODUCT = "${BPN}"

SRC_URI += " \
    ${QT_GIT}/qt-apps/boot2qt-demos.git;name=metadata;branch=dev;protocol=${QT_GIT_PROTOCOL};destsuffix=git/metadata \
    file://demolauncher.service \
    "

SRCREV = "c1919571254d9191de9576bcb35e663d4efc0e9e"
SRCREV_FORMAT = "${QT_MODULE}"
SRCREV_metadata = "2262f73e6479f5c2aae34e4bc82362acc5631749"

DEPENDS += "qtbase qtdeclarative qtdeclarative-native qtwayland qtwayland-native"
RDEPENDS:${PN} += "qtdoc-examples"

S = "${WORKDIR}/git"

do_install:append() {
    for DEMONAME in startupscreen calqlatr coffee robotarm samegame thermostat todolist
    do
        install -d 0644 ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
        install -m 0644 ${WORKDIR}/git/metadata/metadata/${DEMONAME}/demo.xml ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
        install -m 0644 ${WORKDIR}/git/metadata/metadata/${DEMONAME}/preview.png ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
    done

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/demolauncher.service ${D}${systemd_unitdir}/system/
}

FILES:${PN} += " \
    /usr/share/examples/boot2qt-launcher-demos/* \
    "

SYSTEMD_SERVICE:${PN} = "demolauncher.service"
