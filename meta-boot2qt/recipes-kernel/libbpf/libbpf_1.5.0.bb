SUMMARY = "Library for BPF handling"
DESCRIPTION = "Library for BPF handling"
HOMEPAGE = "https://github.com/libbpf/libbpf"
SECTION = "libs"
LICENSE = "BSD-2-Clause | LGPL-2.1-or-later"

LIC_FILES_CHKSUM = "file://../LICENSE;md5=ef85bb9c22630a7bfbcbbea6ec81ac72"

DEPENDS = "zlib elfutils"

SRC_URI = "git://github.com/libbpf/libbpf.git;protocol=https;branch=master"
SRCREV = "09b9e83102eb8ab9e540d36b4559c55f3bcdb95d"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_HOST = "(x86_64|i.86|arm|aarch64|riscv64|powerpc|powerpc64|mips64).*-linux"

S = "${WORKDIR}/git/src"

EXTRA_OEMAKE += "DESTDIR=${D} LIBDIR=${libdir} INCLUDEDIR=${includedir}"
EXTRA_OEMAKE:append:class-native = " UAPIDIR=${includedir}"

inherit pkgconfig

do_compile() {
        oe_runmake
}

do_install() {
        oe_runmake install
}

do_install:append:class-native() {
        oe_runmake install_uapi_headers
}

BBCLASSEXTEND = "native nativesdk"
