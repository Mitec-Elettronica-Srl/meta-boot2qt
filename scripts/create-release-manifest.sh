#!/bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

# Turn manifest from meta-boot2qt into usable release manifest for boot2qt-manifest.
# Use '--use-head' argument to create manifest using HEAD of current branch for
# meta-boot2qt and meta-qt6 instead of current sha1s.
set -e

MANIFEST="scripts/manifest.xml"

if [ ! -f "${MANIFEST}" ]; then
  echo "Manifest file not found: ${MANIFEST}"
  exit 1
fi

if [ "$1" = "--use-head" ]; then
  USE_HEAD=1
fi

BRANCH=$(git branch --show-current)
if [ "$USE_HEAD" ]; then
  REV=${BRANCH}
else
  REV=$(git rev-parse HEAD)
fi

# add meta-boot2qt
sed -i -e '/<project name="meta-qt/i\
\  <project name="meta-boot2qt"\
           remote="qt"\
           revision="'${REV}'"\
           upstream="'${BRANCH}'"\
           path="sources/meta-boot2qt">\
    <linkfile dest="setup-environment.sh" src="scripts/setup-environment.sh"/>\
    <linkfile dest="sources/templates" src="meta-boot2qt-distro/conf/templates/default"/>\
  </project>' ${MANIFEST}

if [ "$USE_HEAD" ]; then
  sed -i -e '/meta-qt6/,/path/s/revision.*/revision="'${BRANCH}'"/' ${MANIFEST}
fi
