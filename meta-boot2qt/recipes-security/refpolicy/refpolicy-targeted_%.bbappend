FILESEXTRAPATHS:prepend := "${THISDIR}/refpolicy:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/Mitec-Elettronica-Srl/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"

# Specific config files for Poky
SRC_URI += "file://customizable_types \
            file://setrans-mls.conf \
            file://setrans-mcs.conf \
           "

SRCREV_refpolicy = "16bba37b271889138d35d08515999239964afdbb"

do_install:append() {
    install -d ${D}/${systemd_unitdir}/system/getty@.service.d/
    install -Dm755 ${S}/systemd/getty_override.conf ${D}/${systemd_unitdir}/system/getty@.service.d/override.conf
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/getty@.service.d/override.conf \
"
