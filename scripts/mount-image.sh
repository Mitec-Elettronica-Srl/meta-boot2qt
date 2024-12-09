#!/bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <image>"
    echo "Mount the two partitions (boot and rootfs) from the image to current folder"
    exit 1
fi

IMAGE=$1

if [ ! -f "${IMAGE}" ]; then
    echo "Image '${IMAGE}' not found"
    exit 1
fi

mkdir -p boot
mkdir -p root

sudo umount boot root || true

PARTITION=$(parted "${IMAGE}" unit B print | grep "^ 1")
OFFSET=$(echo ${PARTITION} | awk {'print $2'} | cut -d B -f 1)
SIZE=$(echo ${PARTITION}| awk {'print $4'} | cut -d B -f 1)
sudo mount -o loop,offset=${OFFSET},sizelimit=${SIZE} "${IMAGE}" boot

PARTITION=$(parted "${IMAGE}" unit B print | grep "^ 2")
OFFSET=$(echo ${PARTITION}| awk {'print $2'} | cut -d B -f 1)
SIZE=$(echo ${PARTITION}| awk {'print $4'} | cut -d B -f 1)
sudo mount -o loop,offset=${OFFSET},sizelimit=${SIZE} "${IMAGE}" root
