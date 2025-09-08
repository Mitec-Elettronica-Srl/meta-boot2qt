require ${BPN}.inc

PACKAGECONFIG:append:rpi = " gallium vc4 v3d ${@bb.utils.contains('DISTRO_FEATURES', 'vulkan', 'vulkan broadcom', '', d)}"
PACKAGECONFIG:remove:class-native = "libclc gallium-llvm amd"
PACKAGECONFIG:remove:class-nativesdk = "libclc gallium-llvm amd"
