# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DEPLOY_CONF_NAME = "Intel NUC"

IMAGE_FSTYPES += "wic.xz"

DISTRO_FEATURES:remove = "usbgadget"

DEPLOY_CONF_IMAGE_TYPE = "wic.xz"

QBSP_IMAGE_CONTENT += "\
    ${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} \
    ${IMAGE_LINK_NAME}.conf \
    ${IMAGE_LINK_NAME}.info \
    "

INITRAMFS_IMAGE = "core-image-minimal-initramfs"

SYSVINIT_ENABLED_GETTYS = "1"

SERIAL_CONSOLES += "115200;ttyUSB0"

WKS_FILE = "systemd-bootdisk-microcode-initramfs.wks"
WKS_FILE_DEPENDS:append = " microcode-initramfs"
