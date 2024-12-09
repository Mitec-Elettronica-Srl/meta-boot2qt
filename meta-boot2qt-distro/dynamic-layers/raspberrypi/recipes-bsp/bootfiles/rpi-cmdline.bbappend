
CMDLINE_CGROUPS ?= "${@bb.utils.contains('DISTRO_FEATURES','systemd','cgroup_enable=memory', '', d)}"
CMDLINE += "${CMDLINE_CGROUPS}"
