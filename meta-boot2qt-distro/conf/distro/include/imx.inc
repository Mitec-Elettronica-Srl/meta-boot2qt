# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

IMAGE_FSTYPES += "wic.xz"

DEPLOY_CONF_IMAGE_TYPE = "wic.xz"

QBSP_IMAGE_CONTENT += "\
    ${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} \
    ${IMAGE_LINK_NAME}.conf \
    ${IMAGE_LINK_NAME}.info \
    ${IMAGE_LINK_NAME}.spdx.tar.zst \
"

QBSP_LICENSE_FILE ?= "${FSL_EULA_FILE}"
QBSP_LICENSE_NAME ?= "NXP Semiconductors Software License Agreement"

GPULESS_FEATURES = "wayland opengl vulkan webengine virtualization"
DISTRO_FEATURES:remove:mx6ul-generic-bsp = "${GPULESS_FEATURES}"
DISTRO_FEATURES:remove:mx7-generic-bsp = "${GPULESS_FEATURES}"
DISTRO_FEATURES:remove:mx93-generic-bsp = "${GPULESS_FEATURES}"

BBMASK += "meta-freescale/dynamic-layers/qt6-layer/recipes-qt/qt6"
