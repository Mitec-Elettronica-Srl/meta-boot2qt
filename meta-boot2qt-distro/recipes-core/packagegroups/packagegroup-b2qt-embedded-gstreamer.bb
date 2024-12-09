# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Additional gstreamer packagegroup for B2Qt embedded Linux image"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

inherit packagegroup

MACHINE_GSTREAMER_1_0_PLUGIN ?= ""

RDEPENDS:${PN} = "\
        gstreamer1.0-plugins-base-meta \
        gstreamer1.0-plugins-good-meta \
        gstreamer1.0-plugins-ugly-meta \
        gstreamer1.0-plugins-bad-meta \
        gstreamer1.0-libav \
        ${MACHINE_GSTREAMER_1_0_PLUGIN} \
        "
