FILESEXTRAPATHS:prepend := "${THISDIR}/refpolicy:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy \
    0001-fix-bin-commands.patch \
    0002-Allow-more-things.patch \
    0003-fc-subs-volatile-alias-common-var-volatile-paths.patch \
    0004-refpolicy-minimum-make-sysadmin-module-optional.patch \
    0005-Revert-users-Move-unconfined_u-definition-to-unconfi.patch \
    0006-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch \
    0007-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch \
    0008-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
    0009-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch \
    0010-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch \
    0011-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch \
    0012-fc-login-apply-login-context-to-login.shadow.patch \
    0013-fc-hwclock-add-hwclock-alternatives.patch \
    0014-fc-dmesg-apply-policy-to-dmesg-alternatives.patch \
    0015-fc-ssh-apply-policy-to-ssh-alternatives.patch \
    0016-fc-sysnetwork-apply-policy-to-network-commands-alter.patch \
    0017-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch \
    0018-fc-su-apply-policy-to-su-alternatives.patch \
    0019-fc-fstools-fix-real-path-for-fstools.patch \
    0020-fc-init-fix-update-alternatives-for-sysvinit.patch \
    0021-fc-brctl-apply-policy-to-brctl-alternatives.patch \
    0022-fc-corecommands-apply-policy-to-nologin-alternatives.patch \
    0023-fc-locallogin-apply-policy-to-sulogin-alternatives.patch \
    0024-fc-ntp-apply-policy-to-ntpd-alternatives.patch \
    0025-fc-kerberos-apply-policy-to-kerberos-alternatives.patch \
    0026-fc-ldap-apply-policy-to-ldap-alternatives.patch \
    0027-fc-postgresql-apply-policy-to-postgresql-alternative.patch \
    0028-fc-usermanage-apply-policy-to-usermanage-alternative.patch \
    0029-fc-getty-add-file-context-to-start_getty.patch \
    0030-fc-vlock-apply-policy-to-vlock-alternatives.patch \
    0031-fc-add-fcontext-for-init-scripts-and-systemd-service.patch \
    0032-file_contexts.subs_dist-set-aliase-for-root-director.patch \
    0033-policy-modules-system-logging-add-rules-for-the-syml.patch \
    0034-policy-modules-system-logging-add-rules-for-syslogd-.patch \
    0035-policy-modules-kernel-files-add-rules-for-the-symlin.patch \
    0036-policy-modules-system-logging-fix-auditd-startup-fai.patch \
    0037-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
    0038-policy-modules-system-systemd-enable-support-for-sys.patch \
    0039-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
    0040-policy-modules-system-systemd-systemd-user-fixes.patch \
    0041-policy-modules-system-logging-grant-getpcap-capabili.patch \
    0042-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
    0043-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
    0044-systemd-allow-systemd-logind-to-inherit-fds.patch \
    0045-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
    0046-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
    0047-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
    0048-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
    0049-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
    0050-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
    0051-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
    0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \\
    0053-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
    0054-policy-modules-system-systemd-systemd-make-systemd_-.patch \
    0055-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
    0056-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
    0057-policy-modules-system-init-all-init_t-to-read-any-le.patch \
    0058-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
    0059-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
    0060-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
    0061-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
    0062-policy-modules-system-logging-make-syslogd_runtime_t.patch \
"

SRCREV_refpolicy = "0deb7170f8e5466a39c95468959321c2c28a5f33"

do_install:append() {
    install -d ${D}/${systemd_unitdir}/system/getty@.service.d/
    install -Dm755 ${WORKDIR}/getty_override.conf ${D}/${systemd_unitdir}/system/getty@.service.d/override.conf
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/getty@.service.d/override.conf \
"