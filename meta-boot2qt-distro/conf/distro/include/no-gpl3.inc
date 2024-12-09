# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

# Configuration for boot2qt image without (L)GPLv3 components
# Include in your conf/local.conf and add meta-gplv2 layer to your configuration
# https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#migration-2.3-gplv2-and-gplv3-moves

INCOMPATIBLE_LICENSE += "*GPLv3"

IMAGE_FEATURES:remove:pn-b2qt-embedded-qt6-image = "tools-debug debug-tweaks"

RDEPENDS:packagegroup-b2qt-embedded-tools:remove:pn-packagegroup-b2qt-embedded-tools = "binutils binutils-symlinks perf"
RDEPENDS:packagegroup-b2qt-embedded-base:remove:pn-packagegroup-b2qt-embedded-base = "ttf-freefont-mono"

PACKAGECONFIG:remove:pn-qtvirtualkeyboard = "hunspell"
PACKAGECONFIG:remove:pn-python3-pygobject = "cairo"

# intel nuc specific changes
IMAGE_FSTYPES:intel-x86-common = "tar.gz"
MACHINE_EXTRA_INSTALL:remove:intel-x86-common = "grub-efi-config"
QBSP_IMAGE_CONTENT:intel-x86-common = ""
