
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://rtsx_pci_sdmmc \
    file://network \
    "

do_install:append() {
    install -m 0755 ${WORKDIR}/rtsx_pci_sdmmc ${D}/init.d/20-rtsx_pci_sdmmc
    install -m 0755 ${WORKDIR}/network ${D}/init.d/30-network
}

PACKAGES += "\
    initramfs-module-rtsx-pci-sdmmc \
    initramfs-module-network \
    "

SUMMARY:initramfs-module-rtsx-pci-sdmmc = "initramfs support for rtsx_pci_sdmmc"
RDEPENDS:initramfs-module-rtsx-pci-sdmmc = "${PN}-base"
FILES:initramfs-module-rtsx-pci-sdmmc = "/init.d/20-rtsx_pci_sdmmc"

SUMMARY:initramfs-module-network = "initramfs support for Realtek LAN driver and Intel(R) Ethernet Controller I225-LM/I225-V"
RDEPENDS:initramfs-module-network = "${PN}-base"
FILES:initramfs-module-network = "/init.d/30-network"
