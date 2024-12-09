FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
    file://0001-Fix-API-break-in-init_disassemble_info.patch \
    file://enable-kprobes-for-lttng.cfg \
"
