
FILESEXTRAPATHS:prepend:sdkmingw32 := "${THISDIR}/${BPN}:"
SRC_URI:append:sdkmingw32 = " file://0001-Do-not-use-win32-specific-filehandling.patch"

DEPENDS:append:sdkmingw32 = " nativesdk-prebuild-python"
RDEPENDS:${PN}:append:sdkmingw32 = " nativesdk-prebuild-python"
EXTRA_OECONF:remove:sdkmingw32 = "--without-python --with-python=no"
EXTRA_OECONF:append:sdkmingw32 = " --with-python=${WORKDIR}/python_win"
CXXFLAGS:append:sdkmingw32 = " -D_hypot=hypot"

do_configure:prepend:sdkmingw32() {
cat > ${WORKDIR}/python_win << EOF
#! /bin/sh
case "\$2" in
        --includes) echo "-I${STAGING_INCDIR}/${PYTHON_DIR}" ;;
        --ldflags) echo "-Wl,-rpath-link,${STAGING_LIBDIR}/.. -lpython312" ;;
        --exec-prefix) echo "${exec_prefix}" ;;
        *) exit 1 ;;
esac
exit 0
EOF
        chmod +x ${WORKDIR}/python_win
}

do_install:append:sdkmingw32() {
    ln -s ../python3.dll ${D}${bindir}/
    ln -s ../python312.dll ${D}${bindir}/
    ln -s ../python312.zip ${D}${bindir}/
    ln -s ../libexpat-1.dll ${D}${bindir}/
    ln -s ../libiconv-2.dll ${D}${bindir}/
    ln -s ../libintl-8.dll ${D}${bindir}/
    ln -s ../libstdc++-6.dll ${D}${bindir}/
}
