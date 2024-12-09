# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Device specific installation instructions for the QBSP"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit deploy nopackages

SRC_URI = "file://README"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/README ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build
