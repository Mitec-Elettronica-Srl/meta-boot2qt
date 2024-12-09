# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Boot to Qt Appcontroller"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://main.cpp;md5=f25c7436dbc72d4719a5684b28dbcf4b;beginline=1;endline=17"

inherit qt6-cmake
require recipes-qt/qt6/qt6-git.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE_BRANCH = "dev"
CVE_PRODUCT = "${BPN}"

SRCREV = "3e0ecc85628f17e4d7929f3341aa76b376b8080e"

DEPENDS = "qtbase"
RDEPENDS:${PN} = " \
    default-qt-envs \
    "

do_configure:append() {
    echo "base=linux" >> ${WORKDIR}/appcontroller.conf
    echo "platform=${MACHINE}" >> ${WORKDIR}/appcontroller.conf
    echo "environmentFile=/etc/default/qt" >> ${WORKDIR}/appcontroller.conf
}

do_install:append() {
    install -m 0755 -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/appcontroller.conf ${D}${sysconfdir}/
}
