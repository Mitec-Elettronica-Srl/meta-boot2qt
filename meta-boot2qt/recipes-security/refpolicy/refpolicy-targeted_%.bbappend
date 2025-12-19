FILESEXTRAPATHS:prepend := "${THISDIR}/refpolicy:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/Mitec-Elettronica-Srl/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"

# Specific config files for Poky
SRC_URI += "file://customizable_types \
            file://setrans-mls.conf \
            file://setrans-mcs.conf \
           "

SRCREV_refpolicy = "6a0f65b759904955b68b6ea450c7b23f1834b981"

do_install:append() {
    install -d ${D}/${systemd_unitdir}/system/getty@.service.d/
    install -Dm755 ${S}/systemd/getty_override.conf ${D}/${systemd_unitdir}/system/getty@.service.d/override.conf
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/getty@.service.d/override.conf \
"
