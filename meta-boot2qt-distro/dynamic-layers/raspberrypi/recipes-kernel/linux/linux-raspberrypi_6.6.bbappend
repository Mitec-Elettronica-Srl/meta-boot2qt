
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#KERNEL_DEBUG = "True"
# Below is equal to above but taken to make dependency future proof if KERNEL_DEBUG
# variable is decided to change also something else than adding native pahole tool
do_kernel_configme[depends] += "pahole-native:do_populate_sysroot"
EXTRA_OEMAKE:remove = "PAHOLE=false"

SRC_URI += "\
    file://0001-6.6-vt-conmakehash-improve-reproducibility.patch \
    file://tracing.cfg \
"

DEPENDS += " bpftool-native "

do_install:append() {
    bpftool btf dump file ${D}/${KERNEL_IMAGEDEST}/vmlinux-${KERNEL_VERSION} format c | tee ${B}/vmlinux.h 1> /dev/null
    install -d ${D}${includedir}
    install -m 0644 ${B}/vmlinux.h ${D}${includedir}/
}

PACKAGES += "linux-bpf-dev"
FILES:linux-bpf-dev = "${includedir}/vmlinux.h"
