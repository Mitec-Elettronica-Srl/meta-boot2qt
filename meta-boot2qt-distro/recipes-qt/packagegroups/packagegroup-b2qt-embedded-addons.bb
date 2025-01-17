# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Device Creation specific Qt packages"
LICENSE = "The-Qt-Company-Commercial"

inherit packagegroup

PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"

USE_QT_DEMO_LAUNCHER ?= "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', \
    bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.7', '>'), False, d)}"

USE_PYSIDE ?= "${@bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.7.0', '>') & \
    bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.8.0', '!=') & \
    bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.9', '<')}"

RDEPENDS:${PN} += " \
    ${@'boot2qt-demolauncher' if bb.utils.to_boolean(d.getVar('USE_QT_DEMO_LAUNCHER')) else ''} \
    boot2qt-appcontroller \
    boot2qt-startupscreen \
    qdb \
    qtdeclarative-tools \
    qttools-tools \
    ${@'squish' if bb.utils.to_boolean(d.getVar('USE_SQUISH')) else ''} \
    ${@'python3-pyside6' if bb.utils.to_boolean(d.getVar('USE_PYSIDE')) else ''} \
    "
