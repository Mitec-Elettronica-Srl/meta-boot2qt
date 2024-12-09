
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kms.conf.in"

# Default DRI device to use with KMS
DRI_DEVICE ?= "card0"

do_configure:append() {
    echo "FB_MULTI_BUFFER=2" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_FORCEVSYNC=1" >> ${WORKDIR}/defaults
}

do_configure:append:mx8-generic-bsp() {
    echo "QT_QPA_EGLFS_FORCE888=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_ATOMIC=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    sed -e 's/@DEVICE@/${DRI_DEVICE}/' ${WORKDIR}/kms.conf.in > ${WORKDIR}/kms.conf
}

do_configure:append:mx6-mainline-bsp() {
    echo "QT_QPA_EGLFS_KMS_ATOMIC=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    sed -e 's/@DEVICE@/${DRI_DEVICE}/' ${WORKDIR}/kms.conf.in > ${WORKDIR}/kms.conf
}

do_install:append() {
    if [ -e ${WORKDIR}/kms.conf ]; then
        install -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/
    fi
}
