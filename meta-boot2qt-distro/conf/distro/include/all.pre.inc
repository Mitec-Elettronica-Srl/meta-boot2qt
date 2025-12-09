# This is used by genimage.sh
IMAGE_FSTYPES += "tar"

#PACKAGE_EXCLUDE += " iptables "
PACKAGE_EXCLUDE += " libnss-mdns "

# x11: xwayland
PACKAGECONFIG:append:pn-weston = " vnc shell-kiosk shell-ivi remoting systemd "
PACKAGECONFIG:append:pn-neatvnc = " tls"

# gtk stuff
## x11: x11
#PACKAGECONFIG:append:pn-gtk4 = " wayland gstreamer"
## x11: x11
#PACKAGECONFIG:append:pn-gtk+3 = " wayland opengl"

# To disable security layer remove the following line
DISTRO_FEATURES:remove = " directfb "
# x11: x11 
#DISTRO_FEATURES:append = " wayland acl xattr pam "
# security + selinux layers
#DISTRO_FEATURES:append = " acl xattr pam seccomp security opengl wayland selinux "
DISTRO_FEATURES += " acl xattr pam seccomp security opengl wayland selinux "

# selinux default policy
PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mls"

EXTRA_IMAGE_FEATURES += "read-only-rootfs"

# If you have access to QtSafeRenderer sources, either from git or QtSDK,
# you can enable it by uncommenting following line
#DISTRO_FEATURES_BACKFILL:append = " qtsaferenderer"

# vim fails to build
# building rustdesk: libvpx-staticdev aom-staticdev yuv-staticdev libopus-staticdev nasm yasm cmake clang ninja meson
# x11 stuff: xauth xhost xdotool
# gtk stuff: gtk+ gtkmm gtkmm3 gtkmm4 gtk+3 gtk4
# rustdesk (enable all the above): rustdesk
IMAGE_INSTALL:append = " \
    libvpx \
    aom \
    yuv \
    libopus \
    fuse3 fuse3-utils \
    fuse fuse-utils \
    atomrootfsinit \
    autologin \
    libcurl \
    libsqlite3 \
    qtquickdesigner-components \
    btrfs-tools \
    fsenlarge \
    python3-pycairo \
    weston \
    git \
    nano \
    zip \
    zerotier-one \
    softether \
    embuer \
    hmidaemon \
    sdl2 \
    networkmanager \
    networkmanager-nmcli \
"

PREFERRED_VERSION_go = "1.25.2"
PREFERRED_VERSION_golang-native = "1.25.2"
PREFERRED_VERSION_golang-nativesdk = "1.25.2"

IMAGE_CLASSES += "extrausers"
EXTRA_USERS_PARAMS = "\
    groupadd -g 1002 user; \
    useradd -s /bin/bash -d /home/autologin -m -e 2199-12-31 --no-user-group -g 1002 -u 1002 user; \
    usermod -aG render user; \
    usermod -aG video user; \
    usermod -aG audio user; \
    usermod -aG seat user; \
    usermod -aG input user; \
    usermod -aG tty user; \
"
