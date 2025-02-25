# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Packagegroup for B2Qt embedded Linux image"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

inherit packagegroup

MACHINE_EXTRA_INSTALL ?= ""

RDEPENDS:${PN} = "\
        kernel-modules \
        ca-certificates \
        liberation-fonts \
        ttf-devanagari \
        ttf-opensans \
        ttf-dejavu-common \
        ttf-dejavu-sans \
        ttf-freefont-mono \
        ttf-tlwg \
        otf-noto \
        ttf-titilliumweb \
        tzdata \
        tzdata-americas \
        tzdata-asia \
        tzdata-europe \
        connman \
        rng-tools \
        udev-extraconf \
        kmsxx \
        python3-misc \
        python3-pip \
        ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "weston weston-init weston-examples", "", d)} \
        ${@bb.utils.contains("DISTRO_FEATURES", "pulseaudio", "pulseaudio-server pulseaudio-misc", "", d)} \
        ${MACHINE_EXTRA_INSTALL} \
        "
