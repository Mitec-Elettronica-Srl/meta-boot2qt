# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

update_file_timestaps() {
    # Update file timestamp to 1 second since Epoch time.
    TZ=UTC find ${IMAGE_ROOTFS} -exec touch -h -m -t '197001010000.01' {} \;
}

ROOTFS_POSTINSTALL_COMMAND += "update_file_timestaps; "
