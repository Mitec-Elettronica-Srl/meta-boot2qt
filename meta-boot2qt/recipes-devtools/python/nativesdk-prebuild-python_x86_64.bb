############################################################################
##
## Copyright (C) 2017 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

require nativesdk-prebuild-python.inc

COMPATIBLE_HOST = "x86_64.*-mingw.*"

SRC_URI = "\
    https://www.python.org/ftp/python/${PV}/python-${PV}-embed-amd64.zip \
    https://download.qt.io/development_releases/prebuilt/python/x86-64/libpython312.a;name=lib \
    "
SRC_URI[sha256sum] = "a86a2e28870967745d255cc597d1e4d19ae79e65e927cdc324baa0256202231c"
SRC_URI[lib.sha256sum] = "cce5cefdb428f2d42918cf03b44beaf17739bd874d66b8e87ed921ca551424de"

# python wheels for amd64
SRC_URI:append = "\
    https://files.pythonhosted.org/packages/3f/14/c3554d512d5f9100a95e737502f4a2323a1959f6d0d01e0d0997b35f7b10/MarkupSafe-2.1.5-cp312-cp312-win_amd64.whl;name=markupsafe \
    https://files.pythonhosted.org/packages/fa/de/02b54f42487e3d3c6efb3f89428677074ca7bf43aae402517bc7cca949f3/PyYAML-6.0.2-cp313-cp313-win_amd64.whl;name=pyyaml \
    https://files.pythonhosted.org/packages/91/b4/2b5b59358dadfa2c8676322f955b6c22cde4937602f40490e2f7403e548e/watchdog-5.0.3-py3-none-win_amd64.whl;name=watchdog \
"
SRC_URI[markupsafe.sha256sum] = "823b65d8706e32ad2df51ed89496147a42a2a6e01c13cfb6ffb8b1e92bc910bb"
SRC_URI[pyyaml.sha256sum] = "8388ee1976c416731879ac16da0aff3f63b286ffdd57cdeb95f3f2e085687563"
SRC_URI[watchdog.sha256sum] = "f00b4cf737f568be9665563347a910f8bdc76f88c2970121c86243c8cfdf90e9"
