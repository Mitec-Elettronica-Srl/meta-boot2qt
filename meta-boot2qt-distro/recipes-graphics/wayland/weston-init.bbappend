
do_install:append() {
    # remove udev rules
    rm -rf ${D}${sysconfdir}/udev
}
