# This is used by genimage.sh
IMAGE_FSTYPES += "tar"

#PACKAGE_EXCLUDE += " iptables "
PACKAGE_EXCLUDE += " libnss-mdns "

PACKAGECONFIG:append:pn-weston = " vnc shell-kiosk shell-ivi remoting systemd "
PACKAGECONFIG:append:pn-neatvnc = " tls"

# To disable security layer remove the following line
DISTRO_FEATURES:remove = " directfb "
# x11: x11 
DISTRO_FEATURES:append = " wayland acl xattr pam "

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
"
