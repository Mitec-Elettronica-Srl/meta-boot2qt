# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

BOOTFS_NAME = "${IMAGE_BASENAME}-boot-${MACHINE}-${DATETIME}"
BOOTFS_LINK_NAME = "${IMAGE_BASENAME}-boot-${MACHINE}"
BOOTFS_NAME[vardepsexclude] += "DATETIME"

BOOTFS_DEPENDS ?= ""

fakeroot do_bootfs () {
    if [ -z "${BOOTFS_CONTENT}" ]; then
        exit 0
    fi

    mkdir -p ${S}/bootfs

    for item in ${BOOTFS_CONTENT}; do
        src=`echo $item | awk -F':' '{ print $1 }'`
        dst=`echo $item | awk -F':' '{ print $2 }'`

        install -D -m 0755 ${IMGDEPLOYDIR}/$src ${S}/bootfs/$dst
    done

    cd ${S}/bootfs
    rm -f ${IMGDEPLOYDIR}/${BOOTFS_NAME}.tar.gz ${IMGDEPLOYDIR}/${BOOTFS_LINK_NAME}.tar.gz

    mkdir -p ${IMGDEPLOYDIR}
    tar czvf ${IMGDEPLOYDIR}/${BOOTFS_NAME}.tar.gz .
    ln -s ${BOOTFS_NAME}.tar.gz ${IMGDEPLOYDIR}/${BOOTFS_LINK_NAME}.tar.gz
}

addtask bootfs before do_rootfs

do_bootfs[depends] += "${BOOTFS_DEPENDS}"
