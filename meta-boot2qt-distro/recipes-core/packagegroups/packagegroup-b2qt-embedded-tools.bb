# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Additional tools packagegroup for B2Qt embedded Linux image"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

require gcc-sanitizers.inc

RDEPENDS:${PN} = "\
        alsa-utils-amixer \
        binutils \
        binutils-symlinks \
        connman-client \
        ${GCC-SANITIZERS} \
        e2fsprogs-resize2fs \
        htop \
        i2c-tools \
        iproute2 \
        ldd \
        mtd-utils \
        parted \
        procps \
        rsync \
        tslib-calibrate \
        sysstat \
        nfs-utils \
        ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd-analyze", "", d)} \
        ${@bb.utils.contains_any("TRANSLATED_TARGET_ARCH", "x86-64 aarch64 riscv64", "bpftool", "", d)} \
        "
