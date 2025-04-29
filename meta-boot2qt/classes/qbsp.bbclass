# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

inherit nopackages abi-arch siteinfo image-artifact-names

FILESEXTRAPATHS:prepend := "${BOOT2QTBASE}/files/qbsp:"

SRC_URI = "\
    file://base_package.xml.in \
    file://base_installscript.qs.in \
    file://image_package.xml.in \
    file://toolchain_package.xml.in \
    file://toolchain_installscript.qs.in \
    "

INHIBIT_DEFAULT_DEPS = "1"
do_qbsp[depends] += "\
    p7zip-native:do_populate_sysroot \
    installer-framework-native:do_populate_sysroot \
    ${@d.getVar('QBSP_SDK_TASK') + ':do_populate_sdk' if d.getVar('QBSP_SDK_TASK') else ''}  \
    ${@d.getVar('QBSP_IMAGE_TASK') + ':do_image_complete' if d.getVar('QBSP_IMAGE_TASK') else ''}  \
    ${QBSP_IMAGE_DEPENDS} \
"

QBSP_NAME ??= "Qt ${QT_VERSION}"

QBSP_IMAGE_CONTENT ??= ""
QBSP_IMAGE_DEPENDS ??= ""

QBSP_OUTPUTNAME ?= "${PN}-${SDKMACHINE}-${MACHINE}-${PV}"
QBSP_VERSION ?= "${PV}${VERSION_AUTO_INCREMENT}"
QBSP_INSTALLER_COMPONENT ?= "${@d.getVar('MACHINE').replace('-','')}"
QBSP_INSTALL_PATH ?= "/Extras/${MACHINE}"

QBSP_LICENSE_FILE ??= ""
QBSP_LICENSE_FILE_BASENAME = "${@os.path.basename(d.getVar('QBSP_LICENSE_FILE')) if d.getVar('QBSP_LICENSE_FILE') else ''}"
QBSP_LICENSE_NAME ??= ""

QBSP_FORCE_CONTAINER_TOOLCHAIN ?= "false"
QBSP_FORCE_CONTAINER_TOOLCHAIN:sdkmingw32 = "false"

TOOLCHAIN_HOST_TYPE = "linux"
TOOLCHAIN_HOST_TYPE:sdkmingw32 = "windows"

VERSION_AUTO_INCREMENT = "-${DATETIME}"
VERSION_AUTO_INCREMENT[vardepsexclude] = "DATETIME"

DEPLOY_CONF_NAME ?= "${MACHINE}"
RELEASEDATE = "${@time.strftime('%Y-%m-%d',time.gmtime())}"

# overwrite IMAGE_BASENAME so that IMAGE_LINK_NAME still works as expected
IMAGE_BASENAME = "${QBSP_IMAGE_TASK}"

QBSP_SDK ??= "${DISTRO}-${TCLIBC}-${SDKMACHINE}-${QBSP_SDK_TASK}-${TUNE_PKGARCH}-${MACHINE}-toolchain-${SDK_VERSION}"
QBSP_SDK:b2qt ?= "${DISTRO}-${SDKMACHINE}-${QBSP_SDK_TASK}-${MACHINE}"
QBSP_SDK:append = "${SDK_POSTFIX}"
SDK_POSTFIX = ".sh"
SDK_POSTFIX:sdkmingw32 = ".tar.xz"
REAL_MULTIMACH_TARGET_SYS = "${TUNE_PKGARCH}${TARGET_VENDOR}-${TARGET_OS}"
SDK_DEPLOY ?= "${DEPLOY_DIR}/sdk"

DOCKER_ARCH = "${@'arm64' if d.getVar('SDKMACHINE') == 'aarch64' else 'amd64'}"

QBSP_OS_TYPE ?= "GenericLinuxOsType"
QBSP_OS_TYPE:b2qt ?= "QdbLinuxOsType"
QBSP_QT_TYPE ?= "RemoteLinux.EmbeddedLinuxQt"
QBSP_QT_TYPE:b2qt ?= "Qdb.EmbeddedLinuxQt"

B = "${WORKDIR}/build"

def render_template(d, input, output):
    import os
    from jinja2 import Environment, FileSystemLoader, meta

    with open(input) as f:
        source = f.read()

    env = Environment(trim_blocks=True)

    parsed_content = env.parse(source)
    variables = meta.find_undeclared_variables(parsed_content)

    context = {}
    for var in variables:
        val = d.getVar(var)
        if val is not None:
            context[var] = val

    template = env.from_string(source)
    rendered = template.render(context)

    with open(output, "w") as f:
        f.write(rendered)

prepare_qbsp() {
    # Toolchain component
    if [ -e ${SDK_DEPLOY}/${QBSP_SDK} ]; then
        COMPONENT_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}.toolchain"
        mkdir -p ${COMPONENT_PATH}/meta
        mkdir -p ${COMPONENT_PATH}/data

        cp ${WORKDIR}/toolchain_package.xml ${COMPONENT_PATH}/meta/package.xml
        cp ${WORKDIR}/toolchain_installscript.qs ${COMPONENT_PATH}/meta/installscript.qs

        if [ "${SDK_POSTFIX}" = "${SDK_POSTFIX:sdkmingw32}" ]; then
            cp ${SDK_DEPLOY}/${QBSP_SDK} ${COMPONENT_PATH}/data/toolchain${SDK_POSTFIX}
        else
            7za a -mx=0 ${COMPONENT_PATH}/data/toolchain.7z ${SDK_DEPLOY}/${QBSP_SDK}
        fi
    fi

    # Image component, only if we have image content
    if [ -n "${QBSP_IMAGE_CONTENT}" ]; then
        COMPONENT_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}.system"
        mkdir -p ${COMPONENT_PATH}/meta
        mkdir -p ${COMPONENT_PATH}/data

        cp ${WORKDIR}/image_package.xml ${COMPONENT_PATH}/meta/package.xml

        mkdir -p ${B}/qbsp-image
        for item in ${QBSP_IMAGE_CONTENT}; do
            src=`echo $item | awk -F':' '{ print $1 }'`
            dst=`echo $item | awk -F':' '{ print $2 }'`

            if [ -d "$src" ]; then
                mkdir -p ${B}/qbsp-image/$dst
                cp -r $src/* ${B}/qbsp-image/$dst
            else
                install -D -m 0755 ${DEPLOY_DIR_IMAGE}/$src ${B}/qbsp-image/$dst
            fi
        done

        cd ${B}/qbsp-image
        7za a ${COMPONENT_PATH}/data/image.7z .
    fi

    # Base component
    COMPONENT_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}"
    mkdir -p ${COMPONENT_PATH}/meta

    cp ${WORKDIR}/base_package.xml ${COMPONENT_PATH}/meta/package.xml
    cp ${WORKDIR}/base_installscript.qs ${COMPONENT_PATH}/meta/installscript.qs
    if [ -n "${QBSP_LICENSE_FILE}" ]; then
        cp ${QBSP_LICENSE_FILE} ${COMPONENT_PATH}/meta/
    fi
}

create_qbsp() {
    prepare_qbsp

    # Repository creation
    repogen --unite-metadata --af 7z --ac 0 -p ${B}/pkg ${B}/repository

    mkdir -p ${DEPLOY_DIR}/qbsp
    rm -f ${DEPLOY_DIR}/qbsp/${QBSP_OUTPUTNAME}.qbsp

    cd ${B}/repository
    7za a ${DEPLOY_DIR}/qbsp/${QBSP_OUTPUTNAME}.qbsp *
}

python do_qbsp() {
    workdir = d.getVar("WORKDIR")
    for template in os.listdir(workdir):
        if template.endswith(".in"):
            output = template[:-3]
            render_template(d,os.path.join(workdir,template),os.path.join(workdir,output))

    bb.build.exec_func('create_qbsp', d)
}

addtask qbsp after do_unpack before do_build

do_qbsp[cleandirs] += "${B}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_populate_sysroot[noexec] = "1"
do_populate_lic[noexec] = "1"
