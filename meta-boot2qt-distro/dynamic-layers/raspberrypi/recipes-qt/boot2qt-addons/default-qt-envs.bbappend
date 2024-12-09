
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kms.conf"

do_configure:append() {
    echo "QT_QPA_EGLFS_FORCE888=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_ATOMIC=0" >> ${WORKDIR}/defaults
    echo "QT_WAYLAND_HARDWARE_INTEGRATION=linux-dmabuf-unstable-v1" >> ${WORKDIR}/defaults

    # gstreamer uses the hardware h264 encoders/decoders, which cause problems:
    # * the encoder causes the recording to freeze
    # * the decoder maxes out a single thread at 100% and drops frames, while the libavcodec based
    #   decoder uses 4 threads at 30ish% and plays the media player example file smoothly

    echo "GST_PLUGIN_FEATURE_RANK=v4l2h264dec:1,v4l2h264enc:1" >> ${WORKDIR}/defaults
}

do_configure:append() {
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
}

do_install:append() {
    install -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/
}
