FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
    file://enable-kprobes-for-lttng.cfg \
"
