# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

inherit image-buildinfo

IMAGE_BUILDINFO_VARS:append = "\
    DISTRO_CODENAME \
    QT_VERSION \
    TARGET_SYSROOT \
    DEPLOY_CONF_NAME \
    DEPLOY_CONF_TYPE \
"

TARGET_SYSROOT = "${REAL_MULTIMACH_TARGET_SYS}"

python deploy_buildinfo () {
    import shutil
    shutil.copyfile(
        d.expand('${IMAGE_ROOTFS}${IMAGE_BUILDINFO_FILE}'),
        d.expand('${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.info')
    )
}

IMAGE_PREPROCESS_COMMAND += "deploy_buildinfo"
