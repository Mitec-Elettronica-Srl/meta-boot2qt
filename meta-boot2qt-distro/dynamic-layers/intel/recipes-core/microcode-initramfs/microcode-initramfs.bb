# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "Initramfs with early load intel microcode"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit deploy nopackages

do_compile[depends] += " \
    ${INITRAMFS_IMAGE}:do_image_complete \
    ${@bb.utils.contains('MACHINE_FEATURES', 'intel-ucode', 'intel-microcode:do_deploy', '', d)} \
    "

do_compile() {
    # https://www.kernel.org/doc/Documentation/x86/microcode.txt
    microcode="${@bb.utils.contains('MACHINE_FEATURES', 'intel-ucode', '${DEPLOY_DIR_IMAGE}/microcode.cpio ', '', d)}"
    cat ${microcode} ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.cpio.gz > ${S}/microcode-initramfs
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${S}/microcode-initramfs ${DEPLOYDIR}/
}

addtask deploy before do_build after do_compile
