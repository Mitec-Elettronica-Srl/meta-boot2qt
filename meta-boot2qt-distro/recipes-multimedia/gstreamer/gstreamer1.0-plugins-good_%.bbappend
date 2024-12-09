
FILESEXTRAPATHS:append := "${THISDIR}/files:"
SRC_URI:append = " \
    ${@ 'file://0001-v4l2-enforce-a-pixel-aspect-ratio-of-1-1-if-no-data-.patch' if bb.utils.vercmp_string(d.getVar('PV'), '1.24.2') < 0 else '' } \
    ${@ 'file://7953.patch' if bb.utils.vercmp_string(d.getVar('PV'), '1.24.10') < 0 else '' } \
"
