# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Common default environment variables for running Qt applications"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit systemd

SRC_URI += "\
    file://defaults \
    file://b2qt.service \
    file://locale.conf \
"

QT_QPA_PLATFORM ?= "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'eglfs', 'linuxfb', d)}"


SQUISH_PREFIX ?= "${@'/opt/squish' if bb.utils.to_boolean(d.getVar('USE_SQUISH')) else ''}"

do_configure() {
    echo "QT_QPA_PLATFORM=${QT_QPA_PLATFORM}" >> ${WORKDIR}/defaults
    if [ -n "${SQUISH_PREFIX}" ]; then
        echo "SQUISH_PREFIX=${SQUISH_PREFIX}" >> ${WORKDIR}/defaults
    fi
}

do_install:append() {
    install -m 0755 -d ${D}${sysconfdir}/default
    install -m 0755 ${WORKDIR}/defaults ${D}${sysconfdir}/default/qt

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/b2qt.service ${D}${systemd_unitdir}/system/

    install -m 0755 ${WORKDIR}/locale.conf ${D}${sysconfdir}

    # loginctl enable-linger root
    install -d ${D}/var/lib/systemd/linger
    touch ${D}/var/lib/systemd/linger/root
}

SYSTEMD_SERVICE:${PN} = "b2qt.service"

