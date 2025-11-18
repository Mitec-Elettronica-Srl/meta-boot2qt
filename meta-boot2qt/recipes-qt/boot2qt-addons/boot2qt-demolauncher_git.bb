# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

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

BB_GIT_DEFAULT_DESTSUFFIX ?= "git"

SRC_URI += " \
    ${QT_GIT}/qt-apps/boot2qt-demos.git;name=metadata;branch=dev;protocol=${QT_GIT_PROTOCOL};destsuffix=${BB_GIT_DEFAULT_DESTSUFFIX}/metadata \
    file://demolauncher.service \
    "

SRCREV = "9fb7f723cf2bcf840075e361d473f82015d42334"
SRCREV_FORMAT = "${QT_MODULE}"
SRCREV_metadata = "6ecef815b2277e88906e3e5baa4482256de39b64"

DEPENDS += "\
    qtbase \
    qtdeclarative \
    qtdeclarative-native \
    qtwayland \
    ${@'qtwayland-native' if bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.10', '<') else ''} \
"
RDEPENDS:${PN} += "qtdoc-examples ttf-titilliumweb boot2qt-startupscreen"

do_install:append() {
    for DEMONAME in startupscreen calqlatr coffee robotarm samegame thermostat todolist
    do
        install -d 0644 ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
        install -m 0644 ${WORKDIR}/${BB_GIT_DEFAULT_DESTSUFFIX}/metadata/metadata/${DEMONAME}/demo.xml ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
        install -m 0644 ${WORKDIR}/${BB_GIT_DEFAULT_DESTSUFFIX}/metadata/metadata/${DEMONAME}/preview.png ${D}/usr/share/examples/boot2qt-launcher-demos/${DEMONAME}
    done

    # in Qt version before 6.9, calqltr example had different name
    if [ "${@bb.utils.vercmp_string_op(d.getVar('QT_VERSION'), '6.9', '<')}" = "True" ]; then
        sed -i ${D}/usr/share/examples/boot2qt-launcher-demos/calqlatr/demo.xml \
            -e 's|bin/calqlatr|bin/calqlatrexample|'
    fi

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/demolauncher.service ${D}${systemd_unitdir}/system/
}

FILES:${PN} += " \
    /usr/share/examples/boot2qt-launcher-demos/* \
    "

SYSTEMD_SERVICE:${PN} = "demolauncher.service"
