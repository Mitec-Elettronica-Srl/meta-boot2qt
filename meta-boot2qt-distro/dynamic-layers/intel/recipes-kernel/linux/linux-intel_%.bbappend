
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "\
    file://add-partition-uuid-to-uevent.patch \
    file://wlan-realtek.cfg \
    file://b2qt.cfg \
    file://fragment.cfg \
    "
