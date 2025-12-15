FILESEXTRAPATHS:prepend := "${THISDIR}/refpolicy:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#SRC_URI += " \
#    file://0001-xserver-fixup-labelling-for-mesa-cache.patch \
#    file://0002-wayland-allow-reading-udev-runtime-files-for-input-d.patch \
#    file://0003-wayland-grant-access-to-dev-input-for-libinput.patch \
#    file://0004-wayland-allow-talking-to-logind-over-dbus.patch \
#    file://0005-wayland-allow-managing-wayland_runtime_t-sock-files-.patch \
#    file://0006-wayland-allow-managing-wayland_runtime_t-files-for-d.patch \
#    file://0007-wayland-grant-wayland_compositor-access-to-dev-udmab.patch \
#    file://0008-wayland-allow-violating-W-X-for-compositors-behind-a.patch \
#    file://0009-Revert-kernel-remove-some-unused-initial-SID-context.patch \
#    file://0010-chromium-drop-the-chromium_render_t-domain.patch \
#    file://0011-fapolicyd-support-for-new-usr-sbin-fapolicyd-rpm-loa.patch \
#    file://0012-Label-.cache-gstreamer-0-9-.-.-files-1042.patch \
#    file://0013-games-1026.patch \
#    file://0014-Wireshark-patch-to-allow-execmem-which-it-unfortunat.patch \
#    file://0015-firewalld-Allow-firewall-cmd-to-be-called-from-syste.patch \
#    file://0016-gcc_config_t-allow-reading-cgroup-files-for-cpu.max.patch \
#    file://0017-logging-allow-syslogd_t-syslog_tls_port_t-name_conne.patch \
#"

SRC_URI += " \
    file://0001-fix-bin-commands.patch \
    file://0002-Allow-more-things.patch \
"

do_install:append() {
    install -d ${D}/${systemd_unitdir}/system/getty@.service.d/
    install -Dm755 ${WORKDIR}/getty_override.conf ${D}/${systemd_unitdir}/system/getty@.service.d/override.conf
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/getty@.service.d/override.conf \
"