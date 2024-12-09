
do_install:append() {
    ln -s /home/root ${D}/root
    echo ${MACHINE_HOSTNAME} > ${D}${sysconfdir}/hostname

    # Add quotes around command expansion, since tty may return "not a tty"
    sed -i 's#test `tty | cut -c1-8`#test "`tty | cut -c1-8`"#' ${D}${sysconfdir}/profile
}
