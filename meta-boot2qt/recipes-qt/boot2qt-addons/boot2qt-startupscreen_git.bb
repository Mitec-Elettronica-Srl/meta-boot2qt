# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Boot to Qt Startup Screen"
LICENSE = "BSD-3-Clause | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://main.cpp;md5=123fa3be981d2a73f4680a70d277c22a;beginline=1;endline=49"

inherit qt6-cmake systemd
require recipes-qt/qt6/qt6-git.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE = "boot2qt-demos"
QT_MODULE_BRANCH = "dev"
CVE_PRODUCT = "${BPN}"

SRC_URI += "\
    file://startupscreen.service \
"

DEPENDS += "qtbase qtdeclarative qtdeclarative-native"
RDEPENDS:${PN} = "qtdeviceutilities"

S = "${WORKDIR}/git/startupscreen"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/startupscreen.service ${D}${systemd_unitdir}/system/
}


SYSTEMD_SERVICE:${PN} = "startupscreen.service"

SRCREV = "7db9a1314622ad11e12c64cb44e70fea134d29b1"
