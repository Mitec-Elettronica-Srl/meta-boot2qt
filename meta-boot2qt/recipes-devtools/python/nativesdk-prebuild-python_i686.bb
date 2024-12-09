# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

require nativesdk-prebuild-python.inc

COMPATIBLE_HOST = "i686.*-mingw.*"

SRC_URI = "\
    https://www.python.org/ftp/python/${PV}/python-${PV}-embed-win32.zip \
    https://download.qt.io/development_releases/prebuilt/python/i686/libpython312.a;name=lib \
    "
SRC_URI[sha256sum] = "8c1b9cd9f63001a58f986f8570a5ab79276e8c1a048f7bfe3efe631a878e189c"
SRC_URI[lib.sha256sum] = "97159d8226e8513a754adb509c7f422a8730c05e22e29946c779ca34979fd4bb"

# python wheels for win32
SRC_URI:append = "\
    https://files.pythonhosted.org/packages/96/0c/620c1fb3661858c0e37eb3cbffd8c6f732a67cd97296f725789679801b31/MarkupSafe-2.1.5-cp312-cp312-win32.whl;name=markupsafe \
    https://files.pythonhosted.org/packages/14/0d/e2c3b43bbce3cf6bd97c840b46088a3031085179e596d4929729d8d68270/PyYAML-6.0.2-cp313-cp313-win32.whl;name=pyyaml \
    https://files.pythonhosted.org/packages/97/69/cfb2d17ba8aabc73be2e2d03c8c319b1f32053a02c4b571852983aa24ff2/watchdog-5.0.3-py3-none-win32.whl;name=watchdog \
"
SRC_URI[markupsafe.sha256sum] = "8590b4ae07a35970728874632fed7bd57b26b0102df2d2b233b6d9d82f6c62ad"
SRC_URI[pyyaml.sha256sum] = "bc2fa7c6b47d6bc618dd7fb02ef6fdedb1090ec036abab80d4681424b84c1183"
SRC_URI[watchdog.sha256sum] = "c66f80ee5b602a9c7ab66e3c9f36026590a0902db3aea414d59a2f55188c1f49"
