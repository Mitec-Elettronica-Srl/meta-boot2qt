# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Meta task for QBSP creation"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

# get Qt version number
require recipes-qt/qt6/qt6-git.inc
S = "${WORKDIR}"

inherit qbsp

PV := "${@d.getVar('PV').split('+')[0]}"

VERSION_SHORT = "${@d.getVar('PV').replace('.','')}"
QBSP_NAME = "Boot2Qt ${PV}"
QBSP_MACHINE = "${@d.getVar('MACHINE').replace('-','')}"
QBSP_INSTALLER_COMPONENT = "embedded.b2qt.${VERSION_SHORT}.${QBSP_MACHINE}"
QBSP_INSTALL_PATH = "/${PV}/Boot2Qt/${MACHINE}"

QBSP_SDK_TASK = "meta-toolchain-b2qt-embedded-qt6-sdk"
QBSP_IMAGE_TASK = "b2qt-embedded-qt6-image"
