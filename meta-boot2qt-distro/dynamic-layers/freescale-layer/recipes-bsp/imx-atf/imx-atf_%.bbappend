
EXTRA_OEMAKE:remove = 'LD="${@remove_options_tail(d.getVar('LD'))}"'
EXTRA_OEMAKE:remove = 'CC="${@remove_options_tail(d.getVar('CC'))}"'
