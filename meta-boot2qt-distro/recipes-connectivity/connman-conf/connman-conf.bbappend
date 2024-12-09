
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

CONNMAN_SETTINGS_DIR := "${localstatedir}/lib/connman"

FILES:${PN} += "${CONNMAN_SETTINGS_DIR}/settings"

SRC_URI += "file://settings \
          "

do_install:append() {
    install -d ${D}/${CONNMAN_SETTINGS_DIR}
    install -m 0644 ${WORKDIR}/settings ${D}/${CONNMAN_SETTINGS_DIR}/settings
}
