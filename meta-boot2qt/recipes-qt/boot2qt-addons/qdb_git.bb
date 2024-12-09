# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Qt Debug Bridge Daemon"
SECTION = "devel"
LICENSE = "GPL-3.0-only | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504"

inherit features_check
inherit qt6-cmake
require recipes-qt/qt6/qt6-git.inc
require recipes-qt/qt6/qt6.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE_BRANCH = "master"
CVE_PRODUCT = "${BPN}"

SRC_URI += "\
    file://b2qt-gadget-network.sh \
    file://defaults \
    file://qdbd.service \
    file://qdbd-init.sh \
"

SRCREV = "c68a9483d809c277a8190982206380c40199d413"
PV = "1.3.2+git${SRCPV}"

REQUIRED_DISTRO_FEATURES = "systemd"
DEPENDS = "qtbase qtdeclarative qtdeclarative-native"
RRECOMMENDS:${PN} += "kernel-module-usb-f-fs kernel-module-usb-f-rndis"
EXTRA_OECMAKE += "-DDAEMON_ONLY=ON"

do_install:append() {
    install -m 0755 ${WORKDIR}/b2qt-gadget-network.sh ${D}${bindir}/

    install -m 0755 ${WORKDIR}/qdbd-init.sh ${D}${bindir}/

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/qdbd.service ${D}${systemd_unitdir}/system/

    install -m 0755 -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/defaults ${D}${sysconfdir}/default/qdbd
}

SYSTEMD_SERVICE:${PN} = "qdbd.service"

inherit systemd

FILES:${PN}-tools = ""
