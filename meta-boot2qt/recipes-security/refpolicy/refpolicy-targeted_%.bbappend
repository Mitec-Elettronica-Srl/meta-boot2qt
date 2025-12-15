FILESEXTRAPATHS:prepend := "${THISDIR}/refpolicy:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/Mitec-Elettronica-Srl/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"

SRCREV_refpolicy = "0dc9aa0adf0d90c1dc52846597173390e4770ae6"

do_install:append() {
    install -d ${D}/${systemd_unitdir}/system/getty@.service.d/
    install -Dm755 ${THISDIR}/refpolicy/getty_override.conf ${D}/${systemd_unitdir}/system/getty@.service.d/override.conf
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/getty@.service.d/override.conf \
"