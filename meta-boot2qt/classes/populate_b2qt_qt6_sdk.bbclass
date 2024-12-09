# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

inherit populate_sdk populate_sdk_qt6_base abi-arch siteinfo

SDK_NAME = "${DISTRO}-${SDKMACHINE}-${IMAGE_BASENAME}"
TOOLCHAIN_OUTPUTNAME = "${SDK_NAME}-${MACHINE}"

create_sdk_files:append () {

    create_qtcreator_configure_script

    # Link /etc/resolv.conf is broken in the toolchain sysroot, remove it
    rm -f ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/resolv.conf
}

create_qtcreator_configure_script () {
    # add qtcreator configuration script
    install -m 0755 ${BOOT2QTBASE}/files/configure-qtcreator.sh ${SDK_OUTPUT}/${SDKPATH}
    sed -i -e '/^CONFIG=/c\CONFIG="${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
    sed -i -e '/^ABI=/c\ABI="${ABI}-linux-poky-elf-${SITEINFO_BITS}bit"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
    sed -i -e '/^MACHINE=/c\MACHINE="${MACHINE}"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
}

create_qtcreator_configure_script:sdkmingw32 () {
    # no script available for mingw
    true
}

quiet_sdk_extraction() {
EXTRA_TAR_OPTIONS="$EXTRA_TAR_OPTIONS --checkpoint=9999999"
}
SDK_PRE_INSTALL_COMMAND = "${quiet_sdk_extraction}"
