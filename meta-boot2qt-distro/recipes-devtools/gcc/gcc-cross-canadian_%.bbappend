
BUILDSDK_CFLAGS:append:sdkmingw32 = " -D__USE_MINGW_ACCESS"

do_install:append:sdkmingw32() {
    ln -sf ../libwinpthread-1.dll ${D}${bindir}
    ln -sf ${BINRELPATH}/libwinpthread-1.dll $dest
    ln -sf ../libgcc_s_seh-1.dll ${D}${bindir}
    ln -sf ${BINRELPATH}/libgcc_s_seh-1.dll $dest
}
