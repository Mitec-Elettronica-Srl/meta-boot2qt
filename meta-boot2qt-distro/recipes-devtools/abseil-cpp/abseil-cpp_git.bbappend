PV = "20230802.1"
SRCREV = "fb3621f4f897824c0dbe0615fa94543df6192f30"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0004-Avoid-using-both-Win32Waiter-and-PthreadWaiter-on-Mi.patch"

SYSROOT_DIRS:append:class-nativesdk:mingw32 = " ${bindir}"
