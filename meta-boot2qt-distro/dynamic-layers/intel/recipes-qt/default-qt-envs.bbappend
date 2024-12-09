
SRC_URI += "file://kms.conf"

do_configure:append() {
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    echo "QSG_RENDER_LOOP=basic" >> ${WORKDIR}/defaults
}

do_install:append() {
    install -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/
}
