# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

SUMMARY = "blazesym C-API for address symbolization and related tasks"
DESCRIPTION = "blazesym-c provides C language bindings for blazesym library"
HOMEPAGE = "https://github.com/libbpf/blazesym"
LICENSE = "BSD-3-Clause"
SECTION = "devel"

LIC_FILES_CHKSUM = "file://LICENSE;md5=94eb873ea21918539469bf1c8a2c499d"
S = "${WORKDIR}/git"

SRC_URI = " \
    git://github.com/libbpf/blazesym;branch=main;protocol=https \
    file://0001-Add-cargo-c-support.patch \
"

SRCREV = "c6c1d2c798c8d69e120195a191036bd1b57da257"
CARGO_SRC_DIR = "capi"

# To update recipe for new version
# 1) Check out correct tag from repo
# 2) run following in repo root: cargo generate-lockfile --manifest-path capi/Cargo.toml
# 3) Update LIC_FILES_CHKSUM md5 and use correct SRCREV for step 1
# 4) Copy generated Cargo.lock to recipe WORKDIR and uncomment CARGO_LOCK_SRC_DIR
# 5) Comment out require ${BPN}-crates.inc
# 6) Run following: bitbake -c update_crates blazesym-c
# 7) Comment out CARGO_LOCK_SRC_DIR and uncomment require ${BPN}-crates.inc
#CARGO_LOCK_SRC_DIR = "${WORKDIR}"
require ${BPN}-crates.inc

inherit cargo_c cargo-update-recipe-crates

CARGO_BUILD_FLAGS:remove = "--frozen"
