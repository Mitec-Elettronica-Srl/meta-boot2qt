#!/bin/bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

set -e

ABI="arm-linux-poky-elf-32bit"
CONFIG=""
MACHINE=""

printUsage ()
{
    echo "Usage: $0 --config <environment-setup-file> [--remove] --sdktool <path>] [--name <basename>]"
}

while test -n "$1"; do
  case "$1" in
    "--remove")
      REMOVEONLY=1
      ;;
    "--sdktool")
      shift
      SDKTOOL=$1
      ;;
    "--config")
      shift
      CONFIG=$1
      ;;
    "--name")
      shift
      NAME=$1
      ;;
    *)
      printUsage
      exit 0
      ;;
  esac
  shift
done

if [ ! -f "$CONFIG" ]; then
   printUsage
   exit 1
fi

if [ -z "${SDKTOOL}" ]; then
    SDKTOOL="${HOME}/Qt/Tools/sdktool/libexec/qtcreator/sdktool"
fi
if [ ! -x ${SDKTOOL} ]; then
    echo "Cannot find 'sdktool'"
    printUsage
    exit 1
fi

source $CONFIG

MKSPEC=$(qmake -query QMAKE_XSPEC)
RELEASE=$(qmake -query QT_VERSION)

NAME=${NAME:-"Custom Qt ${RELEASE} ${MACHINE}"}
BASEID="byos.${RELEASE}.${MACHINE}"

${SDKTOOL} rmKit --id ${BASEID}.kit 2>/dev/null || true
${SDKTOOL} rmQt --id ${BASEID}.qt || true
${SDKTOOL} rmTC --id ProjectExplorer.ToolChain.Gcc:${BASEID}.gcc || true
${SDKTOOL} rmTC --id ProjectExplorer.ToolChain.Gcc:${BASEID}.g++ || true
${SDKTOOL} rmDebugger --id ${BASEID}.gdb 2>/dev/null || true
${SDKTOOL} rmCMake --id ${BASEID}.cmake 2>/dev/null || true

if [ -n "${REMOVEONLY}" ]; then
    echo "Kit removed: ${NAME}"
    exit 0
fi

${SDKTOOL} addAbiFlavor \
    --flavor poky \
    --oses linux 2>/dev/null || true

${SDKTOOL} addTC \
    --id "ProjectExplorer.ToolChain.Gcc:${BASEID}.gcc" \
    --name "GCC (${NAME})" \
    --path "$(type -p ${CC})" \
    --abi "${ABI}" \
    --language C

${SDKTOOL} addTC \
    --id "ProjectExplorer.ToolChain.Gcc:${BASEID}.g++" \
    --name "G++ (${NAME})" \
    --path "$(type -p ${CXX})" \
    --abi "${ABI}" \
    --language Cxx

${SDKTOOL} addDebugger \
    --id "${BASEID}.gdb" \
    --name "GDB (${NAME})" \
    --engine 1 \
    --binary "$(type -p ${GDB})" \
    --abis "${ABI}"

${SDKTOOL} addQt \
    --id "${BASEID}.qt" \
    --name "${NAME}" \
    --type "Qdb.EmbeddedLinuxQt" \
    --qmake "$(type -p qmake)" \
    --abis "${ABI}"

${SDKTOOL} addCMake \
    --id "${BASEID}.cmake" \
    --name "CMake ${NAME}" \
    --path "$(type -p cmake)"

${SDKTOOL} addKit \
    --id "${BASEID}.kit" \
    --name "${NAME}" \
    --qt "${BASEID}.qt" \
    --debuggerid "${BASEID}.gdb" \
    --sysroot "${SDKTARGETSYSROOT}" \
    --devicetype "QdbLinuxOsType" \
    --Ctoolchain "ProjectExplorer.ToolChain.Gcc:${BASEID}.gcc" \
    --Cxxtoolchain "ProjectExplorer.ToolChain.Gcc:${BASEID}.g++" \
    --icon ":/boot2qt/images/B2Qt_QtC_icon.png" \
    --mkspec "${MKSPEC}" \
    --cmake "${BASEID}.cmake" \
    --cmake-config "CMAKE_CXX_COMPILER:STRING=%{Compiler:Executable:Cxx}" \
    --cmake-config "CMAKE_C_COMPILER:STRING=%{Compiler:Executable:C}" \
    --cmake-config "CMAKE_PREFIX_PATH:STRING=%{Qt:QT_INSTALL_PREFIX}" \
    --cmake-config "QT_QMAKE_EXECUTABLE:STRING=%{Qt:qmakeExecutable}" \
    --cmake-config "CMAKE_TOOLCHAIN_FILE:FILEPATH=${OECORE_NATIVE_SYSROOT}/usr/lib/cmake/Qt6/qt.toolchain.cmake" \
    --cmake-config "CMAKE_MAKE_PROGRAM:FILEPATH=$(type -p ninja)" \
    --cmake-generator "Ninja"

echo "Configured Qt Creator with new kit: ${NAME}"
