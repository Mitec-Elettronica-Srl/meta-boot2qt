# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

inherit image_types

do_image_conf[depends] += "xz-native:do_populate_sysroot file-native:do_populate_sysroot gawk-native:do_populate_sysroot"

DEPLOY_CONF_NAME ?= "${MACHINE}"
DEPLOY_CONF_TYPE ?= "Boot2Qt"
DEPLOY_CONF_IMAGE_TYPE ?= ""
DEPLOY_CONF_IMAGE_DEP ?= "${DEPLOY_CONF_IMAGE_TYPE}"

IMAGE_CMD:conf() {
    IMAGE_UNCOMPRESSED_SIZE=0
    IMAGE_TYPE=$(file -L ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} | awk '{ print $2 }')
    if [ -e "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE}" ] && [ "${IMAGE_TYPE}" = "XZ" ] ; then
        IMAGE_UNCOMPRESSED_SIZE=$(xz --robot --list ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} | awk -F ' ' '{if (NR==2){ print $5 }}')
    fi

    cat > ${IMGDEPLOYDIR}/${IMAGE_NAME}.conf <<EOF
[${MACHINE}]
name=${DEPLOY_CONF_NAME}
platform=${MACHINE}
product=${DEPLOY_CONF_TYPE}
qt=Qt ${QT_VERSION}
os=linux
imagefile=${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE}
imageuncompressedsize=$IMAGE_UNCOMPRESSED_SIZE
asroot=true
EOF
}
IMAGE_TYPEDEP:conf = "${DEPLOY_CONF_IMAGE_DEP}"
