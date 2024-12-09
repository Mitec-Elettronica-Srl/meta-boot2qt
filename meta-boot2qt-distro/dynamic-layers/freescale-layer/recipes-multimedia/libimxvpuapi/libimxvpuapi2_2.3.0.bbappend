
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-imx8m-hantro-implement-imx_vpu_api_enc_get_skipped_f.patch \
    file://0002-imx8m-hantro-dummy_encoder-implement-imx_vpu_api_enc.patch \
"
