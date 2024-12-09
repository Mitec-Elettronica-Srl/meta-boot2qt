#!/bin/bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

if [ $# -lt 1 ]; then
    echo "Usage: $0 <gitdir> [<layerdir>]"
    echo "Update SRCREVs for all Qt modules in the current layer."
    echo "The <gitdir> is path to the super repo, where modules' SHA1 is taken."
    exit 1
fi

SHA1S=$(git -C $1 submodule status --recursive |  cut -c2- | awk '{print $1$2}')
SHA1S=${SHA1S,,}
LAYERDIR=${2:-$PWD}

for S in $SHA1S; do
    SHA1=${S:0:40}
    PROJECT=${S:40}
    BASEPROJECT=$(echo $PROJECT | cut -d / -f 1)
    TAG="${PROJECT}"

    if [ "${PROJECT}" = "qtquick3d/src/3rdparty/assimp/src" ]; then
        TAG="qtquick3d-assimp"
    elif [ "${PROJECT}" = "qt3d/src/3rdparty/assimp/src" ]; then
        TAG="qt3d-assimp"
    elif [ "${PROJECT}" = "qtwebengine/src/3rdparty" ]; then
        TAG="qtwebengine-chromium"
    elif [ "${PROJECT}" = "qtlocation/src/3rdparty/mapbox-gl-native" ]; then
        TAG="qtlocation-mapboxgl"
    elif [ "${PROJECT}" = "qttools/src/assistant/qlitehtml" ]; then
        TAG="qttools-qlitehtml"
    elif [ "${PROJECT}" = "qttools/src/assistant/qlitehtml/src/3rdparty/litehtml" ]; then
        TAG="qttools-qlitehtml-litehtml"
    fi

    if sed -n "/\"${BASEPROJECT}\"/,/status/p" $1/.gitmodules | grep -q ignore ; then
        echo "${PROJECT} -> ignored"
    else
        echo "${PROJECT} -> ${SHA1}"
        sed -E -i -e "/^SRCREV_${TAG} /s/\".*\"/\"${SHA1}\"/" ${LAYERDIR}/recipes-qt/qt6/qt6-git.inc
    fi
done

