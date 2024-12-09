# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

LICENSE = "PSF-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=b52c821c7750804295e23b9e94525085"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
    https://www.python.org/ftp/python/${PV}/Python-${PV}.tar.xz;name=sources \
    "
SRC_URI[sources.sha256sum] = "1999658298cf2fb837dffed8ff3c033ef0c98ef20cf73c5d5f66bed5ab89697c"

SRC_URI:append = "\
    https://files.pythonhosted.org/packages/e6/4b/e0c340160a33921fc0b7b2ef8ee9de231e445f9ed7c6198dcaedf187912f/qface-2.0.11-9-py3-none-any.whl;name=qface \
    https://files.pythonhosted.org/packages/89/03/a851e84fcbb85214dc637b6378121ef9a0dd61b4c65264675d8a5c9b1ae7/antlr4_python3_runtime-4.13.2-py3-none-any.whl;name=antlr4_python3_runtime \
    https://files.pythonhosted.org/packages/d2/52/fcd83710b6f8786df80e5d335882d1b24d1f610f397703e94a6ffb0d6f66/argh-0.31.3-py3-none-any.whl;name=argh \
    https://files.pythonhosted.org/packages/00/2e/d53fa4befbf2cfa713304affc7ca780ce4fc1fd8710527771b58311a3229/click-8.1.7-py3-none-any.whl;name=click \
    https://files.pythonhosted.org/packages/a7/06/3d6badcf13db419e25b07041d9c7b4a2c331d3f4e7134445ec5df57714cd/coloredlogs-15.0.1-py2.py3-none-any.whl;name=coloredlogs \
    https://files.pythonhosted.org/packages/31/80/3a54838c3fb461f6fec263ebf3a3a41771bd05190238de3486aae8540c36/jinja2-3.1.4-py3-none-any.whl;name=jinja2 \
    https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl;name=six \
    https://files.pythonhosted.org/packages/6b/77/7440a06a8ead44c7757a64362dd22df5760f9b12dc5f11b6188cd2fc27a0/pytest-8.3.3-py3-none-any.whl;name=pytest \
    https://files.pythonhosted.org/packages/d1/d6/3965ed04c63042e047cb6a3e6ed1a63a35087b6a609aa3a15ed8ac56c221/colorama-0.4.6-py2.py3-none-any.whl;name=colorama \
    https://files.pythonhosted.org/packages/6c/dd/a834df6482147d48e225a49515aabc28974ad5a4ca3215c18a882565b028/html5lib-1.1-py2.py3-none-any.whl;name=html5lib \
    https://files.pythonhosted.org/packages/a0/b9/1906bfeb30f2fc13bb39bf7ddb8749784c05faadbd18a21cf141ba37bff2/setuptools_scm-8.1.0-py3-none-any.whl;name=setuptools-scm \
    https://files.pythonhosted.org/packages/4f/60/c9fdd6bacad33ff9f6871f4f6e30e4d35ba9c91f2ff0847f0f7d27eb2b0c/spdx_tools-0.7.0rc0-py3-none-any.whl;name=spdx-tools \
"
SRC_URI[qface.sha256sum] = "e3f8b99ad311868ee9daa64ecc372a4116ed3c6f82f8952240b81db8770d523b"
SRC_URI[antlr4_python3_runtime.sha256sum] = "fe3835eb8d33daece0e799090eda89719dbccee7aa39ef94eed3818cafa5a7e8"
SRC_URI[argh.sha256sum] = "2edac856ff50126f6e47d884751328c9f466bacbbb6cbfdac322053d94705494"
SRC_URI[click.sha256sum] = "ae74fb96c20a0277a1d615f1e4d73c8414f5a98db8b799a7931d1582f3390c28"
SRC_URI[coloredlogs.sha256sum] = "612ee75c546f53e92e70049c9dbfcc18c935a2b9a53b66085ce9ef6a6e5c0934"
SRC_URI[jinja2.sha256sum] = "bc5dd2abb727a5319567b7a813e6a2e7318c39f4f487cfe6c89c6f9c7d25197d"
SRC_URI[six.sha256sum] = "8abb2f1d86890a2dfb989f9a77cfcfd3e47c2a354b01111771326f8aa26e0254"
SRC_URI[pytest.sha256sum] = "a6853c7375b2663155079443d2e45de913a911a11d669df02a50814944db57b2"
SRC_URI[colorama.sha256sum] = "4f1d9991f5acc0ca119f9d443620b77f9d6b33703e51011c16baf57afb285fc6"
SRC_URI[html5lib.sha256sum] = "0d78f8fde1c230e99fe37986a60526d7049ed4bf8a9fadbad5f00e22e58e041d"
SRC_URI[setuptools-scm.sha256sum] = "897a3226a6fd4a6eb2f068745e49733261a21f70b1bb28fce0339feb978d9af3"
SRC_URI[spdx-tools.sha256sum] = "cf950dc92e916a0097f3cef3aaa6632462d2e0312561244a3f7640d018749a01"

inherit bin_package python3-dir nativesdk

# Fix dependency to compilers
BASEDEPENDS:class-nativesdk = "${BASE_DEFAULT_DEPS}"

PV = "3.12.6"

S = "${WORKDIR}"

do_unpack[depends] += "unzip-native:do_populate_sysroot"

PROVIDES += " \
    python3 \
    python3-qface \
    python3-antlr4_python3_runtime \
    python3-click \
    python3-coloredlogs \
    python3-jinja2 \
    python3-markupsafe \
    python3-pyyaml \
    python3-six \
    python3-watchdog \
    python3-pytest \
    python3-colorama \
    python3-html5lib \
    python3-spdx-tools \
    "
RPROVIDES:${PN} += "${PROVIDES}"

do_install() {
    # python headers
    install -d ${D}${includedir}/${PYTHON_DIR}
    install -m 0644 ${S}/Python-${PV}/PC/pyconfig.h ${D}${includedir}/${PYTHON_DIR}
    cp -R --no-dereference --preserve=mode,links -v ${S}/Python-${PV}/Include/* ${D}${includedir}/${PYTHON_DIR}

    # python binaries
    install -d ${D}${bindir}
    install -m 0644 ${S}/*.pyd ${D}/${bindir}/
    install -m 0644 ${S}/python.exe ${D}${bindir}
    install -m 0644 ${S}/python.exe ${D}${bindir}/python3.exe
    install -m 0644 ${S}/python312.dll ${D}${bindir}
    install -m 0644 ${S}/python312.zip ${D}${bindir}

    # python wheels
    # install to bindir to not fix python paths
    unzip -o -d whl_unpack ${S}/\*.whl
    cp -R --no-dereference --preserve=mode,links -v ${S}/whl_unpack/* ${D}${bindir}/

    # libpython.a was generated manually:
    # gendef python312.dll
    # x86_64-w64-mingw32-dlltool --dllname python312.dll --def python312.def --output-lib libpython312.a -m i386/:x86-64
    install -d ${D}${libdir}
    install -m 0644 ${WORKDIR}/libpython312.a ${D}${libdir}/libpython312.a
}

FILES:${PN} += "\
    ${libdir}/${PYTHON_DIR}/site-packages/* \
"
