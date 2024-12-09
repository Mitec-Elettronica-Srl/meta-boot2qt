# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

include conf/distro/include/imx.inc

DEPLOY_CONF_NAME:imx6qdlsabresd = "NXP i.MX6QP/Q/DL SABRE Smart Device"
DEPLOY_CONF_NAME:imx7dsabresd = "NXP SABRE SD i.MX7 Dual"
DEPLOY_CONF_NAME:imx8mm-ddr4-evk = "NXP i.MX 8M Mini DDR4 EVK"
DEPLOY_CONF_NAME:imx8mm-lpddr4-evk = "NXP i.MX 8M Mini LPDDR4 EVK"
DEPLOY_CONF_NAME:imx8mn-ddr4-evk = "NXP i.MX 8M Nano DDR4 EVK"
DEPLOY_CONF_NAME:imx8mn-lpddr4-evk = "NXP i.MX 8M Nano LPDDR4 EVK"
DEPLOY_CONF_NAME:imx8mp-ddr4-evk = "NXP i.MX 8M Plus DDR4 EVK"
DEPLOY_CONF_NAME:imx8mp-lpddr4-evk = "NXP i.MX 8M Plus LPDDR4 EVK"
DEPLOY_CONF_NAME:imx8mq-evk = "NXP i.MX 8MQuad EVK"
DEPLOY_CONF_NAME:imx8qm-mek = "NXP i.MX 8QuadMax MEK"
DEPLOY_CONF_NAME:imx8qxp-mek = "NXP i.MX 8QuadXPlus MEK"
DEPLOY_CONF_NAME:imx8ulp-lpddr4-evk = "NXP i.MX 8 ULP EVK"
DEPLOY_CONF_NAME:imx93-11x11-lpddr4x-evk = "NXP i.MX 93 11x11 LPDDR4X EVK"

# Use NXP BSP and u-boot for default (meta-freescale-distro)
IMX_DEFAULT_BSP = "nxp"
IMX_DEFAULT_BOOTLOADER:imx-nxp-bsp = "u-boot-imx"
IMX_DEFAULT_KERNEL:imx-nxp-bsp = "linux-imx"
