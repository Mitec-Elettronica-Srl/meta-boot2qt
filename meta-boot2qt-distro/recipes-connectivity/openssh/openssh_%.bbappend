do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'true', 'false', d)}; then
        echo "session    required     pam_env.so envfile=/etc/locale.conf" >> ${D}${sysconfdir}/pam.d/sshd
    fi
}
