############################################################################
##
## Copyright (C) 2022 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#KERNEL_DEBUG = "True"
# Below is equal to above but taken to make dependency future proof if KERNEL_DEBUG
# variable is decided to change also something else than adding native pahole tool
do_kernel_configme[depends] += "pahole-native:do_populate_sysroot"
EXTRA_OEMAKE:remove = "PAHOLE=false"

SRC_URI += "\
    file://0001-6.6-vt-conmakehash-improve-reproducibility.patch \
    file://0001-lib-build_OID_registry-don-t-mention-the-full-path-o.patch \
    file://0001-video-logo-Drop-full-path-of-the-input-filename-in-g.patch \
    file://tracing.cfg \
"

DEPENDS += " bpftool-native "

do_install:append() {
    bpftool btf dump file ${D}/${KERNEL_IMAGEDEST}/vmlinux-${KERNEL_VERSION} format c | tee ${B}/vmlinux.h 1> /dev/null
    install -d ${D}${includedir}
    install -m 0644 ${B}/vmlinux.h ${D}${includedir}/
}

PACKAGES += "linux-bpf-dev"
FILES:linux-bpf-dev = "${includedir}/vmlinux.h"
