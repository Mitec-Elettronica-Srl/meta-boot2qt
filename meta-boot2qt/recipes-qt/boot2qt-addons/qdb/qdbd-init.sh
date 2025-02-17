#! /bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
MANUFACTURER="The Qt Company"
QDBDAEMON=/usr/bin/qdbd
PRODUCT_STRING="Boot2Qt-USB-Ethernet-CDC/NCM"
CONFIG_NAME="USB-Ethernet_CDC-NCM+QDB"

. /etc/default/qdbd

configure_gadget()
{
    mkdir -p /sys/kernel/config/usb_gadget/g1
    echo $VENDOR > /sys/kernel/config/usb_gadget/g1/idVendor
    echo $PRODUCT > /sys/kernel/config/usb_gadget/g1/idProduct

    mkdir -p /sys/kernel/config/usb_gadget/g1/strings/0x409
    echo $MANUFACTURER > /sys/kernel/config/usb_gadget/g1/strings/0x409/manufacturer
    echo $PRODUCT_STRING > /sys/kernel/config/usb_gadget/g1/strings/0x409/product
    echo ${SERIAL:0:32} > /sys/kernel/config/usb_gadget/g1/strings/0x409/serialnumber

    mkdir -p /sys/kernel/config/usb_gadget/g1/configs/c.1/strings/0x409
    echo $CONFIG_NAME > /sys/kernel/config/usb_gadget/g1/configs/c.1/strings/0x409/configuration

    mkdir -p /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0
    mkdir -p /sys/kernel/config/usb_gadget/g1/functions/ffs.qdb
    ln -sf /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0 /sys/kernel/config/usb_gadget/g1/configs/c.1
    ln -sf /sys/kernel/config/usb_gadget/g1/functions/ffs.qdb /sys/kernel/config/usb_gadget/g1/configs/c.1

    mkdir -p /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0/os_desc/interface.ncm
    echo WINNCM > /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0/os_desc/interface.ncm/compatible_id
    echo 000000 > /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0/os_desc/interface.ncm/sub_compatible_id

    mkdir -p /sys/kernel/config/usb_gadget/g1/os_desc
    echo 1 > /sys/kernel/config/usb_gadget/g1/os_desc/use
    echo 0x80 > /sys/kernel/config/usb_gadget/g1/os_desc/b_vendor_code
    echo MSFT100 > /sys/kernel/config/usb_gadget/g1/os_desc/qw_sign
    ln -sf /sys/kernel/config/usb_gadget/g1/configs/c.1 /sys/kernel/config/usb_gadget/g1/os_desc

    mkdir -p /dev/usb-ffs
    chmod 770 /dev/usb-ffs
    mkdir -p /dev/usb-ffs/qdb
    chmod 770 /dev/usb-ffs/qdb
    mount -t functionfs qdb /dev/usb-ffs/qdb -o uid=0,gid=0
}

unconfigure_gadget()
{
    umount /dev/usb-ffs/qdb

    rm /sys/kernel/config/usb_gadget/g1/configs/c.1/ncm.usb0
    rm /sys/kernel/config/usb_gadget/g1/configs/c.1/ffs.qdb
    rmdir /sys/kernel/config/usb_gadget/g1/configs/c.1/strings/0x409
    rmdir /sys/kernel/config/usb_gadget/g1/configs/c.1
    rmdir /sys/kernel/config/usb_gadget/g1/functions/ncm.usb0
    rmdir /sys/kernel/config/usb_gadget/g1/functions/ffs.qdb
    rmdir /sys/kernel/config/usb_gadget/g1/strings/0x409
    rmdir /sys/kernel/config/usb_gadget/g1
}

if [ "$1" = "start" ]
then
    b2qt-gadget-network.sh --reset
    modprobe libcomposite
    sleep 1
    configure_gadget
    start-stop-daemon --start --quiet --background --exec $QDBDAEMON -- --usb-ethernet-function-name ncm.usb0
elif [ "$1" = "stop" ]
then
    start-stop-daemon --stop --quiet --exec $QDBDAEMON
    sleep 1
    unconfigure_gadget
elif [ "$1" = "restart" ]
then
    start-stop-daemon --stop --quiet --exec $QDBDAEMON
    b2qt-gadget-network.sh --reset
    sleep 1
    start-stop-daemon --start --quiet --background --exec $QDBDAEMON -- --usb-ethernet-function-name ncm.usb0
else
    echo "Usage: $0 {start|stop|restart}"
    exit 1
fi
exit 0
