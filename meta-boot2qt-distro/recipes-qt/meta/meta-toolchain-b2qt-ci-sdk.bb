# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

DESCRIPTION = "Qt6 SDK toolchain for CI use"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=40a1036f91cefc0e3fabad241fb5f187"

inherit populate_sdk

SDKIMAGE_FEATURES = "dev-pkgs"

MACHINE_EXTRA_INSTALL_SDK ?= ""

TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-toolchain-host"
TOOLCHAIN_TARGET_TASK += "packagegroup-qt6-modules ${MACHINE_EXTRA_INSTALL_SDK}"

PACKAGE_EXCLUDE_COMPLEMENTARY += "\
  ^libqt6 \
  qmlcompilerplus qt3d qt5compat qtapplicationmanager qtbase qtcharts \
  qtcoap qtconnectivity qtdatavis3d qtdeclarative qtdeviceutilities qtgraphs \
  qtgrpc qthttpserver qtimageformats qtinsighttracker qtinterfaceframework \
  qtlanguageserver qtlocation qtlottie qtmqtt qtmultimedia qtnetworkauth \
  qtopcua qtpdf qtpositioning qtquick3d qtquick3dphysics qtquickdesigner-components \
  qtquicktimeline qtremoteobjects qtscxml qtsensors qtserialbus qtserialport \
  qtshadertools qtspeech qtsvg qttools qttranslations qtvirtualkeyboard \
  qtvncserver qtwayland qtwebchannel qtwebengine qtwebsockets qtwebview \
"

SDK_POSTPROCESS_COMMAND:prepend = "apply_ci_fixes;"

apply_ci_fixes () {
    # If the request has more than two labels, it is rejected (e.g., apache2.test-net.qt.local)
    sed -i -e '/^hosts:/s/mdns4_minimal/mdns4/' ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/nsswitch.conf
    # root is expected to be 0755
    chmod g-w ${SDK_OUTPUT}${SDKTARGETSYSROOT}
}

# Append current layer revision to toolchain file name
TOOLCHAIN_OUTPUTNAME:append = "-${@oe.buildcfg.get_metadata_git_revision(d.getVar('BOOT2QTBASE'))[:8]}"

# Prepare the root links to point to the /usr counterparts.
create_merged_usr_symlinks() {
    root="$1"
    install -d $root${base_bindir} $root${base_sbindir} $root${base_libdir}
    ln -rs $root${base_bindir} $root/bin
    ln -rs $root${base_sbindir} $root/sbin
    ln -rs $root${base_libdir} $root/${baselib}

    if [ "${nonarch_base_libdir}" != "${base_libdir}" ]; then
       install -d $root${nonarch_base_libdir}
       ln -rs $root${nonarch_base_libdir} $root/lib
    fi

    # create base links for multilibs
    multi_libdirs="${@d.getVar('MULTILIB_VARIANTS')}"
    for d in $multi_libdirs; do
        install -d $root${exec_prefix}/$d
        ln -rs $root${exec_prefix}/$d $root/$d
    done
}

create_merged_usr_symlinks_sdk() {
    create_merged_usr_symlinks ${SDK_OUTPUT}${SDKTARGETSYSROOT}
}

POPULATE_SDK_PRE_TARGET_COMMAND += "${@bb.utils.contains('DISTRO_FEATURES', 'usrmerge', 'create_merged_usr_symlinks_sdk', '',d)}"
