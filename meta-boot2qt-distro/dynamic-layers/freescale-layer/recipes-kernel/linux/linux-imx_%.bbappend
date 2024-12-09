
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# kernel image files are not needed in the image
RDEPENDS:${KERNEL_PACKAGE_NAME}-base = ""

SRC_URI:append = "\
    file://profiling.cfg \
"
