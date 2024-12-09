
PACKAGECONFIG:append:mx8-generic-bsp = " gbm kms"
PACKAGECONFIG:append:mx6-mainline-bsp = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', ' gbm kms', '', d)}"
PACKAGECONFIG:remove:mx6-nxp-bsp = "gbm"
