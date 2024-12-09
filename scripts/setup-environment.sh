#!/bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

while test -n "$1"; do
  case "$1" in
    "--help" | "-h")
      echo "Usage: . $0 [build directory]"
      return 0
      ;;
    *)
      BUILDDIRECTORY=$1
      ;;
  esac
  shift
done

THIS_SCRIPT="setup-environment.sh"

if [[ $ZSH_EVAL_CONTEXT=="toplevel" || $ZSH_EVAL_CONTEXT=="toplevel:file" ]]; then
  if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
    echo "Error: This script needs to be sourced. Please run as '. $0'"
    return 1
  fi
else
  if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $0'"
    return 1
  fi
fi

if [ -z "$MACHINE" ]; then
  echo "Error: MACHINE environment variable not defined"
  return 1
fi

BUILDDIRECTORY=${BUILDDIRECTORY:-build-${MACHINE}}

TEMPLATECONF=$(readlink -f "${PWD}/sources/templates")
if [ ! -e "${TEMPLATECONF}" ]; then
  TEMPLATECONF=$(readlink -f "${PWD}/sources/meta-boot2qt/meta-boot2qt-distro/conf/templates/default")
fi
export TEMPLATECONF

if [ ! -e ${PWD}/${BUILDDIRECTORY} ]; then
  case ${MACHINE} in
    imx*)
      LAYERSCONF="bblayers.conf.fsl.sample"
      ;;
    raspberrypi*)
      LAYERSCONF="bblayers.conf.rpi.sample"
      ;;
    intel-*)
      LAYERSCONF="bblayers.conf.intel.sample"
      ;;
    jetson-*)
      LAYERSCONF="bblayers.conf.jetson.sample"
      ;;
    *)
      LAYERSCONF="bblayers.conf.sample"
      ;;
  esac
  LAYERSCONF=${TEMPLATECONF}/${LAYERSCONF}
  if [ ! -e ${LAYERSCONF} ]; then
    echo "Error: Could not find layer conf '${LAYERSCONF}'"
    return 1
  fi

  mkdir -p ${PWD}/${BUILDDIRECTORY}/conf
  cp ${LAYERSCONF} ${PWD}/${BUILDDIRECTORY}/conf/bblayers.conf
  if [ ! -e "${TEMPLATECONF}/local.conf.sample" ]; then
    cp ${PWD}/sources/meta-boot2qt/meta-boot2qt-distro/conf/templates/default/local.conf.sample  ${PWD}/${BUILDDIRECTORY}/conf/local.conf
  fi

fi

. sources/poky/oe-init-build-env ${BUILDDIRECTORY}

unset BUILDDIRECTORY
unset TEMPLATECONF
unset LAYERSCONF
