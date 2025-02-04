# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Meta task for CI QBSP creation"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit qbsp

S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"

PV = "${DISTRO_VERSION}"

QBSP_SDK_TASK = "meta-toolchain-b2qt-ci-sdk"
QBSP_IMAGE_TASK = "b2qt-ci-image"

BOOT2QT_REVISION = "${@oe.buildcfg.get_metadata_git_revision(d.getVar('BOOT2QTBASE'))[:8].strip('<')}"

QBSP_SDK:b2qt .= "-${BOOT2QT_REVISION}"
QBSP_OUTPUTNAME:append = "-${BOOT2QT_REVISION}"
IMAGE_NAME_SUFFIX:append = ".${BOOT2QT_REVISION}"
QBSP_IMAGE_CONTENT = "${IMAGE_LINK_NAME}.ext4"
