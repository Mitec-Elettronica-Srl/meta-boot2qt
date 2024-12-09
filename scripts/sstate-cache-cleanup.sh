#!/bin/bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <sstate-cache-dir(s)>"
    echo "Remove all old files from <sstate-cache-dir(s)>"
    exit 1
fi

DAYS_TO_KEEP=${2:-7}
NOW=$(date +%s)

for cachedir in $@; do

  if [ ! -d $cachedir ]; then
    echo "$cachedir: No such directory"
    continue
  fi

  # find the most recently modified file's timestamp
  LATEST=$(find $cachedir -type f -printf '%T@\n' | sort -n | tail -1 | cut -f 1 -d'.')
  # calculate days
  TIMEOUT=$(( ($NOW - $LATEST) / 3600 / 24 + $DAYS_TO_KEEP ))
  # delete all files older
  find ${cachedir} -type f -atime +${TIMEOUT} -delete

done
