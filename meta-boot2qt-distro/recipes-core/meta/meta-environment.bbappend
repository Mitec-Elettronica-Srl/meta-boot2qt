
inherit image-buildinfo

toolchain_create_sdk_version:append () {
    echo 'Layer Revisions:' >> $versionfile
    echo '${@get_layer_revs(d)}' >> $versionfile
}
