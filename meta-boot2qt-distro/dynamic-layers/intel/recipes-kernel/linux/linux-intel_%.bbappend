
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "\
    file://wlan-realtek.cfg \
    file://b2qt.cfg \
    file://fragment.cfg \
    file://add-partition-uuid-to-uevent.patch \
    "
