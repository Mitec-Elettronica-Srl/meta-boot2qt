SUMMARY = "Inspect and manipulate eBPF programs and maps"
DESCRIPTION = "bpftool is a kernel tool for inspection and simple manipulation \
of eBPF programs and maps."
LICENSE = "GPL-2.0-only | BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.BSD-2-Clause;md5=5d6306d1b08f8df623178dfd81880927"

DEPENDS = "binutils elfutils"
DEPENDS:append:class-native = " clang-native"
DEPENDS:append:class-nativesdk = " clang-native"
PROVIDES = "virtual/bpftool"
SRC_URI = "gitsm://github.com/libbpf/bpftool.git;protocol=https;branch=main"
SRCREV = "d844a27fc175aeae3bcb29b052813ef210c97004"

inherit bash-completion pkgconfig

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_HOST = "(x86_64|aarch64|riscv64).*-linux"
COMPATIBLE_HOST:libc-musl = 'null'

S = "${WORKDIR}/git"
B = "${WORKDIR}/${BPN}-${PV}"

EXTRA_OEMAKE = "\
    V=1 \
    -C ${S}/src \
    O=${B}/ \
    OUTPUT=${B}/ \
    HOSTCC="${CC} ${BUILD_CFLAGS}" \
    ARCH=${ARCH} \
    bash_compdir=${prefix}/share/bash-completion \
"

SECURITY_CFLAGS = ""

BUILD_CFLAGS += " -I${STAGING_INCDIR_NATIVE}/bpf  "
BUILDSDK_CFLAGS += " -I${STAGING_INCDIR}/bpf "

EXTRA_OEMAKE:append:class-native = " bootstrap"
EXTRA_OEMAKE:append:class-nativesdk = " bootstrap"

do_compile() {
    oe_runmake
}

do_install() {
    oe_runmake DESTDIR=${D} install
}

do_install:class-native() {
    install -d ${D}${sbindir}
    install -m 0755 ${B}/bootstrap/bpftool ${D}${sbindir}
}

do_install:class-nativesdk() {
    install -d ${D}${sbindir}
    install -m 0755 ${B}/bootstrap/bpftool ${D}${sbindir}
}

FILES:${PN} = "${sbindir}/bpftool"

BBCLASSEXTEND = "native nativesdk"
