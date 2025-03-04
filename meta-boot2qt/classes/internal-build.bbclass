# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

python enable_internal_build () {
    import socket
    try:
        socket.gethostbyname('yocto-cache.ci.qt.io')
    except:
        return

    # enable qtsaferenderer for internal builds
    e.data.appendVar('DISTRO_FEATURES_BACKFILL', ' qtsaferenderer')
    # enable commercial modules and qmlcompiler
    e.data.setVar('QT_COMMERCIAL_MODULES', '1')

    e.data.setVar('SQUISH_MIRROR', 'https://ci-files01-hki.ci.qt.io/input/squish/releasepackages')
    e.data.setVar('SQUISH_LICENSE_KEY', 'qt-srv-19.intra.qt.io:49345')

    e.data.setVar('QT_INTERNAL_BUILD', "1")
    e.data.prependVar('SSTATE_MIRRORS', "file://.* https://yocto-cache.ci.qt.io/sstate-caches/${DISTRO}-${DISTRO_CODENAME}/PATH ")
    e.data.setVar("BB_HASHSERVE_UPSTREAM", "yocto-cache.ci.qt.io:8686")
    e.data.prependVar('PREMIRRORS', "\
        ftp://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        http://.*/.*  https://yocto-cache.ci.qt.io/sources/ \n \
        https://.*/.* https://yocto-cache.ci.qt.io/sources/ \n \
        bzr://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        cvs://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        git://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        gitsm://.*/.* https://yocto-cache.ci.qt.io/sources/ \n \
        hg://.*/.*    https://yocto-cache.ci.qt.io/sources/ \n \
        osc://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        p4://.*/.*    https://yocto-cache.ci.qt.io/sources/ \n \
        svn://.*/.*   https://yocto-cache.ci.qt.io/sources/ \n \
        ")
}

addhandler enable_internal_build
enable_internal_build[eventmask] = "bb.event.ConfigParsed"
