#!/bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

set -x
set -e

RELEASE=$(grep PV ../sources/meta-qt6/recipes-qt/qt6/qt6-git.inc | grep -o [0-9.]*)
UPLOADPATH=QT@ci-files02-hki.intra.qt.io:/srv/jenkins_data/enterprise/b2qt/yocto/${BRANCH}/
UPLOADS="\
    tmp/deploy/images/${MACHINE}/b2qt-${PROJECT}-qt6-image-${MACHINE}.7z \
    tmp/deploy/sdk/b2qt-x86_64-meta-toolchain-b2qt-${PROJECT}-qt6-sdk-${MACHINE}.sh \
    tmp/deploy/sdk/b2qt-${MINGW}-meta-toolchain-b2qt-${PROJECT}-qt6-sdk-${MACHINE}.tar.xz \
    tmp/deploy/sdk/b2qt-x86_64-meta-toolchain-b2qt-ci-sdk-${MACHINE}.sh \
    tmp/deploy/qbsp/meta-b2qt-${PROJECT}-qbsp-x86_64-${MACHINE}-${RELEASE}.qbsp \
    tmp/deploy/qbsp/meta-b2qt-${PROJECT}-qbsp-${MINGW}-${MACHINE}-${RELEASE}.qbsp \
    "

for f in ${UPLOADS}; do
    if [ -e ${f} ]; then
        rsync -L ${f} ${UPLOADPATH}/
    fi
done
