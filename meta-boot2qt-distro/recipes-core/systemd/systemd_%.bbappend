
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://usb-rndis.network \
"

PACKAGECONFIG:append = " networkd"

# By default sytemd uses it's build time as epoch. This causes problems when
# using yocto cache since systemd build time might be more than day older than
# the actual image build time. If that kind of image is booted with a device
# that does not have backup battery for RTC, the first fsck interprets successful
# result as failure because last mount time is in the future. This can be worked
# around by setting TIME_EPOCH to 0, which causes fsck to detect the system time as
# insane and ignore the mount time error.
EXTRA_OECONF:append = " --with-time-epoch=0"

do_install:append() {
    # remove login from tty1
    rm -f ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@tty1.service
    # set up link-local IPs for USB network interface
    install -d ${D}${prefix}/lib/systemd/network/
    install -m 0644 ${WORKDIR}/usb-rndis.network ${D}${prefix}/lib/systemd/network/
}
