#!/bin/bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

while test -n "$1"; do
  case "$1" in
    "--upload")
      UPLOAD=1
      ;;
  esac
  shift
done

echo "-------------------------------------" >> build.log
for DIR in $(ls -d build-*); do
    (
    export MACHINE=${DIR#*-}
    . ./setup-environment.sh

    echo "${MACHINE}:" >> ../build.log
    echo "  start: $(date)" >> ../build.log
    bitbake b2qt-embedded-image meta-toolchain-b2qt-embedded-sdk
    if [ $? = 0 ]; then
        if [ -n "${UPLOAD}" ]; then
            ../sources/meta-boot2qt/scripts/upload.sh
        fi
    else
        echo "    build failed" >> ../build.log
    fi
    echo "  end:   $(date)" >> ../build.log
    )
done
