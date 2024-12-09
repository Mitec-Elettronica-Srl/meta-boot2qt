# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

# map target architecture to abi architectures used by Qt Creator
valid_archs = "arm x86 itanium mips ppc sh riscv"

def map_abi_arch(a, d):
    import re

    valid_archs = d.getVar('valid_archs').split()

    if   re.match('i.86$', a):                  return 'x86'
    elif re.match('x86.64$', a):                return 'x86'
    elif re.match('armeb$', a):                 return 'arm'
    elif re.match('aarch64', a):                return 'arm'
    elif re.match('mips(el|64|64el)$', a):      return 'mips'
    elif re.match('p(pc|owerpc)(|64)', a):      return 'ppc'
    elif re.match('sh(3|4)$', a):               return 'sh'
    elif re.match('riscv(32|64)', a):           return 'riscv'
    elif a in valid_archs:                      return a
    else:
        bb.warn("cannot map '%s' to a QtCreator abi architecture" % a)
        return a

ABI = "${@map_abi_arch(d.getVar('TARGET_ARCH'), d)}"
