# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

MACHINE_FAMILY ??= "empty"
MACHINE_FAMILY:intel-x86-common = "intel"
MACHINE_FAMILY:qemuall = "qemu"
MACHINE_FAMILY:rpi = "raspberrypi"
MACHINE_FAMILY:tegra = "jetson"

include conf/distro/include/${MACHINE_FAMILY}.inc
include conf/distro/include/${MACHINE}.inc

# prefer .inc, but include .conf for backwards compatibility
include conf/distro/include/${MACHINE}.conf
