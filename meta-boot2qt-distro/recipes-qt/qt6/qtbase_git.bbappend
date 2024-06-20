
PACKAGECONFIG += " \
    ctf \
    cups \
    glib \
    sql-sqlite \
    tslib \
    use-gold-linker \
    xkbcommon \
    "

PACKAGECONFIG:remove:mipsarch = "use-gold-linker"
PACKAGECONFIG:remove:riscv64 = "use-gold-linker"

do_configure:prepend() {
    echo "QMAKE_PLATFORM += boot2qt" >> ${S}/mkspecs/oe-device-extra.pri
}

EXTRA_OECMAKE:remove = "-DQT_AVOID_CMAKE_ARCHIVING_API=ON"
