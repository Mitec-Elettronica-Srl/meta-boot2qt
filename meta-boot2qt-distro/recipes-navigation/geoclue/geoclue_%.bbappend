FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit systemd

SRC_URI += "\
    file://geoclue-demo-agent.service \
"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/geoclue-demo-agent.service ${D}${systemd_unitdir}/system/
}

FILES:${PN}-demo-agent += "${systemd_unitdir}/system/geoclue-demo-agent.service"

PACKAGES += "${PN}-demo-agent"

SYSTEMD_PACKAGES += "${PN}-demo-agent"

SYSTEMD_SERVICE:${PN}-demo-agent = "geoclue-demo-agent.service"
