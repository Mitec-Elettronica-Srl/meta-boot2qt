# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DEPLOY_CONF_NAME:jetson-agx-orin-devkit = "NVIDIA Jetson AGX Orin 64GB Developer Kit"
DEPLOY_CONF_NAME:jetson-orin-nano-devkit = "NVIDIA Jetson Orin Nano Developer Kit"

# Attach unsigned kernel image and dtb into boot folder of rootfs
MACHINE_EXTRA_RRECOMMENDS:append = " kernel-devicetree"
RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base:append = " kernel-image"

QBSP_IMAGE_CONTENT += "\
    ${IMAGE_LINK_NAME}.info \
    ${IMAGE_LINK_NAME}.tegraflash.tar.gz \
    "

# NVIDIA's Vulkan support is for X only
DISTRO_FEATURES:remove = "vulkan"

NVIDIA_DEVNET_MIRROR ?= "file://${BSPDIR}/sources/nvidia-devnet-mirror"
NVIDIA_DEVNET_MIRROR[vardepsexclude] = "BSPDIR"

# meta-tegra doesn't have styhead branch yet
BBMASK = "meta-tegra/external/openembedded-layer/recipes-support/opencv/opencv_4.10.%.bbappend"

MACHINE_EXTRA_INSTALL += "nvidia-container-toolkit"
